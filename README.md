# KenyaEMR-LDMS

# ETL Pipeline with DHIS2 Integration

This project is a Python-based ETL pipeline that executes stored procedures and SQL scripts on multiple MySQL databases, processes the results, and posts the data to a DHIS2 instance. The pipeline can be customized using environment variables and command-line arguments.

## Features

- Executes stored procedures on a list of MySQL databases.
- Runs SQL scripts with dynamic parameters (`startDate`, `endDate`, `period`).
- Reads data from MySQL, processes it into a specific format, and posts it to a DHIS2 instance.
- Tracks execution progress with percentage completion.
- Sensitive information is securely managed using a `.env` file.

## Requirements

- Python
- MySQL Server
- DHIS2 instance

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Josh-Murunga/KenyaEMR-LDMS
cd pipeline
```

### 2. Install Dependencies
```bash
pip install -r requirements.txt
```

### 3. Create a .env File
In the project root directory, create a .env file with the following content (you can rename the dot.env file in the project directory and edit accordingly):

```bash
DHIS2_URL=
DHIS2_USERNAME=
DHIS2_PASSWORD=
DB_USER=
DB_PASSWORD=
DB_HOST=
DB_PORT=
DB_NAME=
DB_TABLE=
```

### 3. Prepare Input Files
* Database List: Ensure you have a CSV file with the list of databases to process. You Can add and remove as you please.
* SQL Scripts: Place your SQL files in a folder named api_scripts. These are the indicator scripts generating data for storage in DHIS2.

### 4. Other Setup
* The databases directory includes a database called 'ldwh' that should be imported. This is the staging database for the transformed data. A table called facility_info contains details pertaining to the facility database that is relevant to the pipeline. Any facility can be added to the table provided the correct details match with your KenyaEMR database and DHIS2 instance.
* All databases listed in the database.csv file should be present in MySQL.
* The databases directory also includes a 'kenyaemrsp.sql' file that should be imported into every database available in the database.csv file.

### 5. Running the Pipeline
You can run the pipeline from the command line by specifying the required arguments. Replace the startdate, enddate and period with the respective details.

```bash
python DxCentre-2.py --startdate 2024-01-01 --enddate 2024-01-31 --period 202401
```
