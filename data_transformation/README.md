
# Folder Description
## Data Transformation
This entails a simple process to transform raw data into raw vault and business vault using dbt and automatedv.


### Logs
The logs folder consists of ```dbt.log``` file that stores the logs for the dbt models.


### Models
The models folder consists of the dbt models that helps in transformation. The ```raw``` folder within models folder consist of query to flatten raw data. The ```stage``` folder within models folder contains query to aid the creation tof stage table. The ```raw_vault``` folder consists of query to generate hubs, satellites and links table. The ```schema.yml``` file consists of table structure to execute dbt models and some generic tests like checking unique and not null in specific columns. The ```stage_external_sources.yml``` facilitates in the creation of snowflake external table from snowflake external stage.


### Target
The target folder is generated each time after dbt run.


### Tests
All the custom dbt tests can be defined within test folder.


### dbt_project.yml
All the dbt configurations are defined in this file.


### Makefile
The makefile includes commands to execute dbt tests, seeds and runs.


### packages.yml
All the necessary packages for transformation like dbt and automatedv are defined here.


### profiles.yml
The target database configuration is defined here.

# How to run
=======
# UH-DataTransformation
Unveil Health Data Transformation library which is powered using DBT


## How to run


1. Go to working directory
`cd data_transformation`

2. Create virtual environment
`python -m venv .venv`

3. Activate the virtual environment
`venv\Scripts\activate`

4. Install the requirements 
`pip install -r requirements.txt`

## Optional steps (If using other destination except dremio)
5. `dbt deps`

Note: You should use dbt-packages that is pushed to the repository if using dremio as it have required changes in macros.

6. Edit the configuration in profiles.yml

```
data_transformation:
  outputs:
    dev:

      type: snowflake
      account: hmb88115.us-east-1 # account
      user: username
      password: password
      role: ACCOUNTADMIN
      database: AIRBYTE_DB
      warehouse: COMPUTE_WH
      schema: Sc #schema_name
      threads: 4
      client_session_keep_alive: true
  target: dev


```

7. To run the models
`dbt run`

8. To test the models
`dbt test`

9. To run and test at once
`dbt build`

10. You can test the dbt project with Makefile as well.
10.1 `make all` # To test and run
10.2 `make run_tests` # It will run test cases
10.3 `make run_models` # It will run models 


`AWS_ACCESS_KEY_ID`: `<your aws access key>`
## Working Mechanism Of Github Actions
=======

1. Add aws access key, secret key and region in github repo settings -> security -> secrets and variables -> actions -> repository secrets.
`AWS_ACCESS_KEY_ID`: `<your aws access key>`
`AWS_SECRET_ACCESS_KEY`: `<your aws secret access key>`
`AWS_REGION`: `<your aws region>`

2. Everytime we push local commits to remote, the corresponding actions will be executed that generates tar file of current dbt project and loads it into s3 with versioning.
          