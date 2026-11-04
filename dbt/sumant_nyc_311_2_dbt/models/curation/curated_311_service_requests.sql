{{ config(materialized='table', dist='unique_key') }}
with service_requests as (
    select YEAR(created_date) as created_year ,
        MONTH(created_date) as created_month,
        CASE
            WHEN status = 'Closed' 
                THEN TRUE
            ELSE FALSE
        END as is_closed,
        CASE
            WHEN created_date is not null and closed_date is not null 
                THEN DATEDIFF(hour,created_date,closed_date)
            ELSE NULL
        END as resolution_Hours,
        CURRENT_TIMESTAMP(2) as _ingested_at,
        unique_key,
        agency,
        agency_name,
        borough,
        complaint_type,
        descriptor,
        status,
        created_date,
        closed_date,
        resolution_action_updated_date,
        open_data_channel_type,
        "_loaded_at"
    from {{ref('sumant_nyc_311_2_dbt','stg_311_service_requests')}}
)

select * from service_requests