from airflow.models.dag import DAG
from airflow.providers.google.cloud.transfers.gcs_to_gcs import GCSToGCSOperator

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
        source_bucket="{{ var.value.gcs_source_bucket }}",
        source_object="{{ var.value.gcs_source_object }}",
        destination_bucket="{{ var.value.gcs_destination_bucket }}",
        destination_object="{{ var.value.gcs_destination_object }}",
        gcp_conn_id="google_cloud_default"
    )

    copy_bucket