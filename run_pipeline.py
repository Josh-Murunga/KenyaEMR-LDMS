import mysql.connector
from mysql.connector import Error
import pandas as pd
import os
from sqlalchemy import create_engine
from datetime import datetime, timedelta
import calendar

# MySQL database connection details
db_user = 'root'
db_password = 'test' # Set mysql password
db_host = 'localhost'
db_port = '3306'  # Default MySQL port is 3306
db_name = 'ldwh'
table_name = 'dataset_values'
facility_name = 'facility_name'

# Folder containing SQL query files
sql_folder = '/opt/ldms_script/api_scripts'
databases_folder = '/opt/ldms_script/databases'
backup_directory = '/var/backups/KenyaEMR'

# Create a database connection engine
engine = create_engine(f'mysql+pymysql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}')

def get_dates():
    # Get today's date
    today = datetime.today()

    # Check if the date is between 1st and 10th
    if 1 <= today.day <= 10:
        # Set to previous month
        first_day_prev_month = (today.replace(day=1) - timedelta(days=1)).replace(day=1)
    else:
        # Set to current month
        first_day_prev_month = today.replace(day=1)

    # Set startdate, enddate, and period
    last_day_prev_month = first_day_prev_month.replace(day=calendar.monthrange(first_day_prev_month.year, first_day_prev_month.month)[1])
    startdate = first_day_prev_month.strftime('%Y-%m-%d')
    enddate = last_day_prev_month.strftime('%Y-%m-%d')
    period = first_day_prev_month.strftime('%Y%m')

    # Determine startqtr and endqtr if the period falls in Dec, Mar, Jun, or Sep
    startqtr, endqtr = None, None
    if first_day_prev_month.month in [12, 3, 6, 9]:
        if first_day_prev_month.month == 12:
            startqtr = f"{first_day_prev_month.year}-10-01"
            endqtr = f"{first_day_prev_month.year}-12-31"
        elif first_day_prev_month.month == 3:
            startqtr = f"{first_day_prev_month.year}-01-01"
            endqtr = f"{first_day_prev_month.year}-03-31"
        elif first_day_prev_month.month == 6:
            startqtr = f"{first_day_prev_month.year}-04-01"
            endqtr = f"{first_day_prev_month.year}-06-30"
        elif first_day_prev_month.month == 9:
            startqtr = f"{first_day_prev_month.year}-07-01"
            endqtr = f"{first_day_prev_month.year}-09-30"

    return startdate, enddate, period, startqtr, endqtr


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
        query = query.format(
            startDate=params['startdate'],
            endDate=params['enddate'],
            period=params['period'],
            startQtr=params.get('startqtr', 'null'),
            endQtr=params.get('endqtr', 'null')
        )
        
        # Execute the query
        for result in cursor.execute(query, multi=True):
            if result.with_rows:
                print(f"Rows produced by query: {result.fetchall()}")
            else:
                print(f"Number of rows affected: {result.rowcount}")

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
def post_data_to_csv():
    try:
        # Read data from MySQL table into a DataFrame
        query = f'SELECT * FROM {table_name}'
        df = pd.read_sql(query, engine)

        # Remove any rows with null values
        df = df.dropna()

        today_date = datetime.now().strftime('%Y-%m-%d')
        csv_file_name = f"{facility_name}_{today_date}.csv"
        csv_file_path = os.path.join(backup_directory, csv_file_name)

        df.to_csv(csv_file_path, index=False)

    except Exception as e:
        print(f"Error posting data to csv: {e}")

# Main function to run the pipeline
def run_pipeline(params):
    databases = read_databases_from_csv('/opt/ldms_script/databases.csv')
    if not databases:
        print("No databases to process.")
        return

    sql_files = [os.path.join(sql_folder, f) for f in os.listdir(sql_folder) if f.endswith('.sql')]

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

                # Execute the create_ldwh.sql script
                execute_sql_file(cursor, os.path.join(databases_folder, 'create_ldwh.sql'), params)

                # Execute stored procedures
                execute_stored_procedure(cursor, 'create_etl_tables')
                execute_stored_procedure(cursor, 'sp_first_time_setup')
                
                # Execute SQL queries from files
                for sql_file in sql_files:
                    execute_sql_file(cursor, sql_file, params)
                    
                # Commit the transactions
                connection.commit()
                print(f"Pipeline completed for database {db}")

        except Error as e:
            print(f"Error connecting to database {db}: {e}")
        finally:
            if connection.is_connected():
                cursor.close()
                connection.close()
                print(f"Connection to database {db} closed.")
    
    # Post data to DHIS2 after processing all databases
    post_data_to_csv()

if __name__ == "__main__":
    startdate, enddate, period, startqtr, endqtr = get_dates()

    params = {
        'startdate': startdate,
        'enddate': enddate,
        'period': period,
        'startqtr': startqtr if startqtr else 'NULL',  # Handle None values for quarters
        'endqtr': endqtr if endqtr else 'NULL'         # Handle None values for quarters
    }
        
    run_pipeline(params)
