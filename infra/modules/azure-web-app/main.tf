resource "azurerm_resource_group" "main" {
  name     = "rg-${var.app}-${var.env}"
  location = var.region
  tags     = var.tags
}

resource "azurerm_application_insights" "main" {
  name                = "appi-${var.app}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  application_type    = "web"
}

resource "azurerm_app_service_plan" "main" {
  name                = "plan-${var.app}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "app-${var.app}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  
  site_config {
    always_on        = true
    app_command_line = ""
    linux_fx_version = "DOCKER|${var.docker_image}"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"      = azurerm_application_insights.main.instrumentation_key
    "DOCKER_ENABLE_CI"                    = "true"
    "DOCKER_REGISTRY_SERVER_URL"          = var.docker_registry
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}