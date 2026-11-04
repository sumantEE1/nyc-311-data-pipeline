with service_requests as (
    select * from {{ source('SUMANT_RAW','SUMANT_NYC_311_DATA_TABLE')}}
)
select * from service_requests