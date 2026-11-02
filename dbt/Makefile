PYTHON ?= python3
VENV ?= .venv
DBT := $(VENV)/bin/dbt
SQLFLUFF := $(VENV)/bin/sqlfluff
PRE_COMMIT := $(VENV)/bin/pre-commit

.PHONY: help install deps debug seed run test unit-test docs lint format pre-commit ci clean

help:
	@echo "install      Create venv and install pinned tools"
	@echo "deps         Install dbt packages"
	@echo "debug        Validate ClickHouse connection"
	@echo "seed         Load reference seed"
	@echo "run          Build staging and all six marts"
	@echo "test         Run generic, singular and unit tests"
	@echo "unit-test    Run dbt 1.8+ unit tests only"
	@echo "docs         Generate dbt Docs"
	@echo "lint         Lint SQL through the dbt templater"
	@echo "format       Apply SQLFluff fixes"
	@echo "ci           Install packages, lint, seed, build and test"

install:
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r requirements.txt

deps:
	$(DBT) deps --profiles-dir .

debug:
	$(DBT) debug --profiles-dir .

seed:
	$(DBT) seed --profiles-dir .

run:
	$(DBT) run --profiles-dir .

test:
	$(DBT) test --profiles-dir .

unit-test:
	$(DBT) test --profiles-dir . --select test_type:unit

docs:
	$(DBT) docs generate --profiles-dir .

lint:
	$(SQLFLUFF) lint models tests macros

format:
	$(SQLFLUFF) fix models tests macros

pre-commit:
	$(PRE_COMMIT) run --all-files

ci: deps lint seed run test docs

clean:
	$(DBT) clean
