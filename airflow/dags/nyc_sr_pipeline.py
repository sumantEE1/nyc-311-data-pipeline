from airflow.models.dag import DAG
from airflow.providers.google.cloud.transfers.gcs_to_gcs import GCSToGCSOperator
from airflow.providers.snowflake.operators.snowflake import SQLExecuteQueryOperator


with DAG(
    dag_id="nyc_sr_pipeline",
    default_args={
        "owner": "airflow",
        "depends_on_past": False,
        "email_on_failure": False,
        "email_on_retry": False,
        "retries": 1,
    },
    catchup=False,
) as dag:
    
    copy_bucket = GCSToGCSOperator(
        task_id="copy_gcs_buckets",
        source_bucket="nyc-311-dataset",
        source_object="/",
        destination_bucket="sumant_nyc311",
        destination_object="/",
        gcp_conn_id="google_cloud_default"
    )

    snowflake_query = SQLExecuteQueryOperator(
        task_id="copy_nyc_service_requests",
        conn_id="{{ var.value.snowflake_conn_id }}",
        sql = "COPY INTO {{ var.value.database_name }}.{{ var.value.schema_name }}.{{ var.value.table_name }} \
      (UNIQUE_KEY, CREATED_DATE, CLOSED_DATE, AGENCY, AGENCY_NAME, COMPLAINT_TYPE, DESCRIPTOR, LOCATION_TYPE, INCIDENT_ZIP, INCIDENT_ADDRESS, STREET_NAME, CROSS_STREET_1, CROSS_STREET_2, INTERSECTION_STREET_1, INTERSECTION_STREET_2, ADDRESS_TYPE, CITY, LANDMARK, FACILITY_TYPE, STATUS, DUE_DATE, RESOLUTION_DESCRIPTION, RESOLUTION_ACTION_UPDATED_DATE, COMMUNITY_BOARD, BOROUGH, X_COORDINATE, Y_COORDINATE, PARK_FACILITY_NAME, PARK_BOROUGH, BBL, OPEN_DATA_CHANNEL_TYPE, VEHICLE_TYPE, TAXI_COMPANY_BOROUGH, TAXI_PICKUP_LOCATION, BRIDGE_HIGHWAY_NAME, BRIDGE_HIGHWAY_DIRECTION, ROAD_RAMP, BRIDGE_HIGHWAY_SEGMENT, LATITUDE, LONGITUDE, LOCATION) \
      FROM @{{ var.value.database_name }}.{{ var.value.schema_name }}.{{ var.value.snowflake_stage_name }} \
      FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1) \
      ON_ERROR = 'CONTINUE'"
    )

    copy_bucket >> snowflake_query