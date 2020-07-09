# Integrations.Rebound
This repo contains code for workshops and examples.

## Setup

### Requirements
- terraform cli - `choco install -y terraform`
- azure cli - `choco install -y azure-cli`

### Configuration
``` bash
az login
az account set -s "Funda Dev/Test - Playground"
``` 

## Examples
The examples have their own readme and instructions, just follow the links :) It is recommended to copy the examples and use different variables to avoid affecting others.

- [azure-echo-api](./infra/examples/azure-echo-api)
This is a simple Azure Web App deployment of a containerized app. It includes App Insights.
