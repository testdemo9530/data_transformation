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
    VENV_ACTIVATE := $(VENV)\Scripts\activate
    PYTHON_ENV := $(PYTHON)
    ACTIVATE_CMD :=
else
    VENV_ACTIVATE := $(VENV)/bin/activate
    PYTHON_ENV := $(PYTHON)3
    ACTIVATE_CMD := .
endif

all: venv install install_dbt_packages seed run_tests run_models

venv:
	$(PYTHON_ENV) -m venv $(VENV)

install:
	$(ACTIVATE_CMD) $(VENV_ACTIVATE) && pip install -r requirements.txt

install_dbt_packages:
	$(ACTIVATE_CMD) $(VENV_ACTIVATE) && cd data_transformation && $(DBT) deps

run_tests:
	$(ACTIVATE_CMD) $(VENV_ACTIVATE) && cd data_transformation && $(DBT) test --profile $(DBT_PROFILE) --target $(DBT_ENV)

seed:
	$(ACTIVATE_CMD) $(VENV_ACTIVATE) && cd data_transformation && $(DBT) seed --full-refresh --profile $(DBT_PROFILE) --target $(DBT_ENV)

run_models:
	$(ACTIVATE_CMD) $(VENV_ACTIVATE) && cd data_transformation && $(DBT) run --profile $(DBT_PROFILE) --target $(DBT_ENV)