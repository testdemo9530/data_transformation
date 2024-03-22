## Data Transformation
This entails a simple process to transform raw data into raw vault and business vault using dbt and automatedv.


### Logs
The logs folder consists of ```dbt.log``` file that stores the logs for the dbt models.


### Models
The models folder consists of the dbt models that helps in transformation. The ```mart``` folder within models folder consist of query to flatten raw data. The ```schema.yml``` file consists of table structure to execute dbt models and some generic tests like checking unique and not null in specific columns.


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

