# Variables
DBT=dbt
DBT_PROFILE=data_transformation
DBT_ENV=dev
REQUIREMENT_FILE=./requirements.txt
VENV=venv
PYTHON=python

.PHONY: venv install install_dbt_packages seed run_tests run_models
# Detect the operating system
ifeq ($(OS),Windows_NT)
    PYTHON_ENV := $(PYTHON)
    VENV_ACTIVATE := $(VENV)\Scripts\activate
    
else
    VENV_ACTIVATE := $(VENV)/bin/activate
    PYTHON_ENV := $(PYTHON)3
endif

all: venv install install_dbt_packages seed run_tests run_models

venv:
	$(PYTHON_ENV) -m venv $(VENV)

install:
	$(VENV_ACTIVATE) && pip install -r requirements.txt

install_dbt_packages:
	$(VENV_ACTIVATE) && cd data_transformation && $(DBT) deps

run_tests:
	$(VENV_ACTIVATE) && cd data_transformation && $(DBT) test --profile $(DBT_PROFILE) --target $(DBT_ENV)

seed:
	$(VENV_ACTIVATE) && cd data_transformation && $(DBT) seed --full-refresh --profile $(DBT_PROFILE) --target $(DBT_ENV)

run_models:
	$(VENV_ACTIVATE) && cd data_transformation && $(DBT) run --profile $(DBT_PROFILE) --target $(DBT_ENV)