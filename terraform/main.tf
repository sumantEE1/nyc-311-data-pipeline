terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
    }
  }
}

provider "snowflake" {
    organization_name = var.organisation_name
    account_name      = var.account_name
    user              = var.snowflake_user
    role              = var.snowflake_role
    authenticator     = var.authenticator
    private_key       = file(var.private_key_path)

    # Enable the preview feature
    preview_features_enabled = ["snowflake_table_resource"]
}

# Define the RAW schema within that database
resource "snowflake_schema" "SUMANT_RAW" {
  database            = var.database_name
  name                = var.schema_name
  comment             = "Schema for raw  layers"
}

resource "snowflake_schema" "SUMANT_CURATED" {
  database            = var.database_name
  name                = var.schema_name_curated
  comment             = "Schema for curated layers"
}

resource "snowflake_schema" "SUMANT_CONSUME" {
  database            = var.database_name
  name                = var.schema_name_consume
  comment             = "Schema for consume layers "
}

resource "snowflake_table" "SUMANT_DEY_RAW_NYC_311_DATA_TABLE" {
  
  database = var.database_name
  schema   = var.schema_name
  name     = var.table_name
  comment  = "A table to store nyc practise raw data"

  # Define columns inside the table block
  column {
        name     = "UNIQUE_KEY"
        type     = "NUMBER(38,0)"
        nullable = true
    }
    column {
        name     = "CREATED_DATE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "CLOSED_DATE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "AGENCY"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "AGENCY_NAME"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "COMPLAINT_TYPE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }   
    column {
        name     = "DESCRIPTOR"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "LOCATION_TYPE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "INCIDENT_ZIP"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "INCIDENT_ADDRESS"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "STREET_NAME"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "CROSS_STREET_1"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "CROSS_STREET_2"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "INTERSECTION_STREET_1"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "INTERSECTION_STREET_2"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "ADDRESS_TYPE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "CITY"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "LANDMARK"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "FACILITY_TYPE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "STATUS"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "DUE_DATE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "RESOLUTION_DESCRIPTION"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "RESOLUTION_ACTION_UPDATED_DATE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "COMMUNITY_BOARD"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "BOROUGH"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "X_COORDINATE"
        type     = "NUMBER(38,0)"
        nullable = true
    }
    column {
        name     = "Y_COORDINATE"
        type     = "NUMBER(38,0)"
        nullable = true
    }
    column {
        name     = "PARK_FACILITY_NAME"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "PARK_BOROUGH"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "BBL"
        type     = "NUMBER(38,0)"
        nullable = true
    }
    column {
        name     = "OPEN_DATA_CHANNEL_TYPE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "VEHICLE_TYPE"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "TAXI_COMPANY_BOROUGH"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "TAXI_PICKUP_LOCATION"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "BRIDGE_HIGHWAY_NAME"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "BRIDGE_HIGHWAY_DIRECTION"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "ROAD_RAMP"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "BRIDGE_HIGHWAY_SEGMENT"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "LATITUDE"
        type     = "FLOAT"
        nullable = true
    }
    column {
        name     = "LONGITUDE"
        type     = "FLOAT"
        nullable = true
    }
    column {
        name     = "LOCATION"
        type     = "VARCHAR(16777216)"
        nullable = true
    }
    column {
        name     = "_loaded_at"
        type     = "TIMESTAMP_NTZ"
        default {
            constant = "CURRENT_TIMESTAMP()"
        }
    }
}