# nyc-311-data-pipeline
Data pipeline repository of nyc service requests

The GCP project (ee-india-se-data)
Warehouse (Snowflake)

Expected sources is GCP bucket 


Data profiling findings
    * Total rows - 2,70,39,784
    * Role - SE_DE_PARTICIPANT
    * 
    * Warehouse - SNOWFLAKE_LEARNING_WH
    * Database - PROFILE_NYC_311
    * Schema - CROSS_SKILLING_NYC_311
    * Table - NYC_311_DATASET
    * Maximum date - 
        * Created date - 2021-11-08 02:00:58 UTC
        * Closed Date 3027-03-30 00:00:00 UTC
        * Due Date 2021-12-07 15:47:46 UTC
        * Resolution Action Updated Date - 2927-03-06 12:30:00 UTC
    * Minimum date
        * Created Date - 2010-01-01 00:00:00 UTC
        * Closed Date - 1899-12-31 19:00:00 UTC
        * Due Date - 1900-01-02 00:00:00 UTC
        * Resolution Action Updated Date - 2000-12-31 23:21:26 UTC
    * Data ranges
    * Primary key - 
    * Column Names, Type
        UNIQUE_KEY NUMBER(38,0),
	    CREATED_DATE VARCHAR(16777216),
	    CLOSED_DATE VARCHAR(16777216),
	    AGENCY VARCHAR(16777216),
	    AGENCY_NAME VARCHAR(16777216),
	    COMPLAINT_TYPE VARCHAR(16777216),
	    DESCRIPTOR VARCHAR(16777216),
	    LOCATION_TYPE VARCHAR(16777216),
	    INCIDENT_ZIP VARCHAR(16777216),
	    INCIDENT_ADDRESS VARCHAR(16777216),
	    STREET_NAME VARCHAR(16777216),
	    CROSS_STREET_1 VARCHAR(16777216),
	    CROSS_STREET_2 VARCHAR(16777216),
	    INTERSECTION_STREET_1 VARCHAR(16777216),
	    INTERSECTION_STREET_2 VARCHAR(16777216),
	    ADDRESS_TYPE VARCHAR(16777216),
	    CITY VARCHAR(16777216),
	    LANDMARK VARCHAR(16777216),
	    FACILITY_TYPE VARCHAR(16777216),
	    STATUS VARCHAR(16777216),
	    DUE_DATE VARCHAR(16777216),
	    RESOLUTION_DESCRIPTION VARCHAR(16777216),
	    RESOLUTION_ACTION_UPDATED_DATE VARCHAR(16777216),
	    COMMUNITY_BOARD VARCHAR(16777216),
	    BOROUGH VARCHAR(16777216),
	    X_COORDINATE NUMBER(38,0),
	    Y_COORDINATE NUMBER(38,0),
	    PARK_FACILITY_NAME VARCHAR(16777216),
	    PARK_BOROUGH VARCHAR(16777216),
	    BBL NUMBER(38,0),
	    OPEN_DATA_CHANNEL_TYPE VARCHAR(16777216),
	    VEHICLE_TYPE VARCHAR(16777216),
	    TAXI_COMPANY_BOROUGH VARCHAR(16777216),
	    TAXI_PICKUP_LOCATION VARCHAR(16777216),
	    BRIDGE_HIGHWAY_NAME VARCHAR(16777216),
	    BRIDGE_HIGHWAY_DIRECTION VARCHAR(16777216),
	    ROAD_RAMP VARCHAR(16777216),
	    BRIDGE_HIGHWAY_SEGMENT VARCHAR(16777216),
	    LATITUDE FLOAT,
	    LONGITUDE FLOAT,
	    LOCATION VARCHAR(16777216), 
    * types and nullability verify  
        SELECT column_name, data_type, is_nullable, ordinal_position
            FROM PROFILE_NYC_311.INFORMATION_SCHEMA.COLUMNS
            WHERE table_schema = 'CROSS_SKILLING_NYC_311'
              AND table_name   = 'NYC_311_DATASET'
            ORDER BY ordinal_position;

        CSV in docs folder have column name and data types with nullable column
    * Calculate missing Values for every column
        UNIQUE_KEY - 0
        CREATED_DATE - 0
        CLOSED_DATE - 758262
        AGENCY - 0
        AGENCY_NAME - 0
        COMPLAINT_TYPE - 0
        DESCRIPTOR - 424492
        LOCATION_TYPE - 6404466
        INCIDENT_ZIP - 1422622
        INCIDENT_ADDRESS - 4432167
        STREET_NAME - 4433525
        CROSS_STREET_1 - 8441757
        CROSS_STREET_2 - 8560717
        INTERSECTION_STREET_1 - 19704581
        INTERSECTION_STREET_2 - 19710648
        ADDRESS_TYPE - 4263826
        CITY - 1686478
        LANDMARK - 23460333
        FACILITY_TYPE - 21524303
        STATUS - 0
        DUE_DATE - 18370773
        RESOLUTION_DESCRIPTION - 551859
        RESOLUTION_ACTION_UPDATED_DATE - 402354
        COMMUNITY_BOARD - 45148
        BOROUGH - 45148
        X_COORDINATE - 2160847
        Y_COORDINATE - 2160561
        PARK_FACILITY_NAME - 1357
        PARK_BOROUGH - 45148
        BBL - 6299200
        OPEN_DATA_CHANNEL_TYPE - 0
        VEHICLE_TYPE - 27030277
        TAXI_COMPANY_BOROUGH - 27017966
        TAXI_PICKUP_LOCATION - 26832838
        BRIDGE_HIGHWAY_NAME - 26964731
        BRIDGE_HIGHWAY_DIRECTION - 26973268
        ROAD_RAMP - 26977922
        BRIDGE_HIGHWAY_SEGMENT - 26961591
        LATITUDE - 2160861
        LONGITUDE - 2160861
        LOCATION - 2160861

    * Identify critical columns types (timestamp, primary value type) to have zero or null
        null handling in snow flake
        https://community.snowflake.com/s/article/NULL-handling-in-Snowflake
    * Fixed fields cointaining PII(IP Address, Co Ordinates, names)- identify and flag
        - location contains Co ordinates
        - latitude and longitude contains co-ordinates
        - INCIDENT_ADDRESS

    * business 
        select status, agency, count(*) as status_per_agency from NYC_311_DATASET group by status,agency

        select COMPLAINT_TYPE, agency, count(*) as aggregate from NYC_311_DATASET group by COMPLAINT_TYPE,agency



Used the variables of previous project.
    Snowflake stage
        - Temp storage before inserting/importing the data to/from table
        - External stage when files are stored externally
    Storage integration 
        - Stores the IAM / generated identity GCS bucket / AWS S3/ Azure
        - Set of allowed location    `STORAGE_ALLOWED_LOCATIONS`

Create terraform folder
    Added main.tf
        Added required provider 
            terraform {
                required_providers {
                    snowflake = {
                    source = "snowflakedb/snowflake"
                    }
                }
            }
        Executed terraform init
            installed snowflakedb/snowflake v2.22.0

            it created a file .terraform.lock.hcl  to record the provider selection

Created schema in warehouse `SNOWFLAKE_LEARNING_WH` and database `DE_CROSS_SKILLING_NYC_311`  
    - SUMANT_RAW  
    - SUMANT_CONSUME
    - SUMANT_CURATED

Created table in SUMANT_RAW
    SUMANT_DEY_RAW_NYC_311_DATA_TABLE

Created (using) GCS bucket 


Started airflow using docker compose

Added DAG GCS to GCS operator whichj uses google cloud platform connection
    ** note the key file path threw error, instead copied the json directly to key file json 
    ** for every update in a field, restarted the docker compose to persist the change
    