import os
from dotenv import load_dotenv
import yaml
# Load environment variables from .env file
load_dotenv()

# Accessing environment variables
snowflake_account = os.getenv("SNOWFLAKE_ACCOUNT")
snowflake_user = os.getenv("SNOWFLAKE_USER")
snowflake_password = os.getenv("SNOWFLAKE_PASSWORD")
snowflake_role = os.getenv("SNOWFLAKE_ROLE")
snowflake_database = os.getenv("SNOWFLAKE_DATABASE")
snowflake_warehouse = os.getenv("SNOWFLAKE_WAREHOUSE")
snowflake_schema = os.getenv("SNOWFLAKE_RAW_VAULT_SCHEMA")
snowflake_lnd_schema = os.getenv("SNOWFLAKE_LANDING_SCHEMA")
lnd_patient_table = os.getenv("PATIENT_LANDING_TABLE")


# Creating the data transformation dictionary
data_transformation = {
   "data_transformation":{
    "outputs": {
        "dev": {
            "type": "snowflake",
            "account": snowflake_account,
            "user": snowflake_user,
            "password": snowflake_password,
            "role": snowflake_role,
            "database": snowflake_database,
            "warehouse": snowflake_warehouse,
            "schema": snowflake_schema,
            "threads": 4,
            "client_session_keep_alive": True
        }
    },
    "target": "dev"
}
}

config = {
    'sources': [
        {
            'name': 'airbyte_raw_patient',
            'database': snowflake_database,
            'schema': snowflake_lnd_schema,
            'tables': [
                {
                    'name': lnd_patient_table,
                    'columns': [
                        {
                            'name': '_airbyte_ab_id',
                            'description': 'ID',
                            'tests': ['unique', 'not_null']
                        }
                    ]
                }
            ]
        }
    ]
}


with open("profiles.yml", "w") as yaml_file:
    yaml.dump(data_transformation, yaml_file, default_flow_style=False)


with open("models/schema.yml", "w") as yamls_file:
    yaml.dump(config, yamls_file)