
# Folder Description
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


### schema.yml
Source for the transformation is defined here.


# Pre-requisites:

 

**Make for windows**
  1. Install chocos first 

  Run this command in powershell (requires admin access)

  `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`

  2. Install make

  `chocos install make`

**Python (version 3.8.10 or above):**

Python is a programming language widely used in various applications.</br>
Download and install Python from the official website: [Python Downloads](https://www.python.org/downloads/)
  
# How to run

1. Change the configuration of database in data_transformation/profiles.yml
2. Change source information in data_transformation/models/schema.yml
2. Use make command

    `make`


## For Github Actions

Change the branch name in .github/workflows/upload_to_s3.yml 

Note: Branch should be merged to main for github actions 

## Working Mechanism Of Github Actions

1. Add aws access key, secret key and region in github repo settings -> security -> secrets and variables -> actions -> repository secrets.
`AWS_ACCESS_KEY_ID`: `<your aws access key>`
`AWS_SECRET_ACCESS_KEY`: `<your aws secret access key>`
`AWS_REGION`: `<your aws region>`

2. Everytime we push local commits to remote, the corresponding actions will be executed that generates tar file of current dbt project and loads it into s3 with versioning.
           