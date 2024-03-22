# Variables
DBT=dbt
DBT_PROFILE=data_transformation
DBT_ENV=dev

# Targets
.PHONY: all run_tests seed run_models

all: run_tests seed run_models

run_tests:
	$(DBT) test --profile $(DBT_PROFILE) --target $(DBT_ENV)

seed:
	$(DBT) seed --full-refresh --profile $(DBT_PROFILE) --target $(DBT_ENV)

run_models:
	$(DBT) run --profile $(DBT_PROFILE) --target $(DBT_ENV)