import mysql.connector
from mysql.connector import Error
import pandas as pd
import os
import json
import requests
from sqlalchemy import create_engine
import argparse
from tqdm import tqdm  # Import tqdm for progress tracking
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Get DHIS2 credentials and URL from environment variables
dhis2_url = os.getenv('DHIS2_URL')
username = os.getenv('DHIS2_USERNAME')
password = os.getenv('DHIS2_PASSWORD')

# MySQL database connection details
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')
db_host = os.getenv('DB_HOST')
db_port = os.getenv('DB_PORT')  # Default MySQL port is 3306
db_name = os.getenv('DB_NAME')
table_name = os.getenv('DB_TABLE')

# Folder containing SQL query files
sql_folder = 'api_scripts'

# Create a database connection engine
engine = create_engine(f'mysql+pymysql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}')

# Parse command-line arguments
def parse_arguments():
    parser = argparse.ArgumentParser(description='ETL pipeline with DHIS2 integration.')
    parser.add_argument('--startdate', required=True, help='Start date in the format YYYY-MM-DD')
    parser.add_argument('--enddate', required=True, help='End date in the format YYYY-MM-DD')
    parser.add_argument('--period', required=True, help='Period in the format YYYYMM')
    return parser.parse_args()

# Function to execute a stored procedure
def execute_stored_procedure(cursor, proc_name):
    try:
        cursor.callproc(proc_name)
        print(f"Stored procedure {proc_name} executed successfully.")
    except Error as e:
        print(f"Error executing stored procedure {proc_name}: {e}")

# Function to execute SQL queries from files
def execute_sql_file(cursor, file_path, params):
    try:
        with open(file_path, 'r') as file:
            query = file.read()
        
        # Replace placeholders with actual values
        query = query.format(startDate=params['startdate'], endDate=params['enddate'], period=params['period'])
        
        # Execute the query
        cursor.execute(query, multi=True)
        print(f"SQL file {file_path} executed successfully.")
    except Error as e:
        print(f"Error executing SQL file {file_path}: {e}")
    except FileNotFoundError:
        print(f"File {file_path} not found.")

# Function to read database names from a CSV file
def read_databases_from_csv(file_path):
    try:
        df = pd.read_csv(file_path)
        return df['database_name'].tolist()
    except Exception as e:
        print(f"Error reading database names from CSV: {e}")
        return []

# Function to post data to DHIS2
def post_data_to_dhis2():
    try:
        # Read data from MySQL table into a DataFrame
        query = f'SELECT * FROM {table_name}'
        df = pd.read_sql(query, engine)

        # Remove any rows with null values
        df = df.dropna()

        # Convert the DataFrame to the required JSON format
        data_values = [
            {
                "dataElement": row['data_element'],
                "categoryOptionCombo": row['category_option'],
                "orgUnit": row['organization_unit'],
                "period": row['period'],
                "value": row['value']
            }
            for _, row in df.iterrows()
        ]

        data_value_set = {
            "dataValues": data_values
        }

        json_data = json.dumps(data_value_set, indent=2)

        # Headers for the request
        headers = {
            'Content-Type': 'application/json'
        }

        # Make the POST request to the DHIS2 API
        response = requests.post(dhis2_url, headers=headers, data=json_data, auth=(username, password))

        # Print the response from the server
        print(response.status_code)
        print(response.json())
    except Exception as e:
        print(f"Error posting data to DHIS2: {e}")

# Main function to run the pipeline
def run_pipeline(params):
    databases = read_databases_from_csv('databases.csv')
    if not databases:
        print("No databases to process.")
        return

    sql_files = [os.path.join(sql_folder, f) for f in os.listdir(sql_folder) if f.endswith('.sql')]

    total_tasks = len(databases) * (2 + len(sql_files))  # 2 stored procedures + number of SQL files per database
    progress_bar = tqdm(total=total_tasks, desc="Processing")

    for db in databases:
        try:
            # Connect to the database
            connection = mysql.connector.connect(
                host=db_host,
                user=db_user,
                password=db_password,
                database=db
            )
            if connection.is_connected():
                cursor = connection.cursor()
                print(f"Connected to database {db}")

                # Execute stored procedures
                execute_stored_procedure(cursor, 'create_etl_tables')
                progress_bar.update(1)
                execute_stored_procedure(cursor, 'sp_first_time_setup')
                progress_bar.update(1)

                # Execute SQL queries from files
                for sql_file in sql_files:
                    execute_sql_file(cursor, sql_file, params)
                    progress_bar.update(1)

        except Error as e:
            print(f"Error connecting to database {db}: {e}")
        finally:
            if connection.is_connected():
                cursor.close()
                connection.close()
                print(f"Connection to database {db} closed.")
    
    progress_bar.close()

    # Post data to DHIS2 after processing all databases
    post_data_to_dhis2()

if __name__ == "__main__":
    args = parse_arguments()
    params = {'startdate': args.startdate, 'enddate': args.enddate, 'period': args.period}
    run_pipeline(params)
