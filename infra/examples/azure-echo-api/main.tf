terraform {
  backend "azurerm" {
    resource_group_name  = "rg-workshop-terraform-state"
    storage_account_name = "fundaworkshoptf"
    container_name       = "azure-echo-api"
    key                  = "dev.terraform.tfstate"
    tenant_id             = "3a40f900-9165-459e-9aea-7eaf0d933d38"
  }
}

provider "azurerm" {
  subscription_id = "075254db-75bd-4d17-b2a8-9fa8cdff9f65"
  features {}
}

locals {
  app           = "echo-api"
  docker_image  = "hasandries/echo-api:latest"
  env           = "dev"
  team          = "platform"
}
locals {
  tags = {
    app     = local.app
    env     = local.env
    team    = local.team
  }
}


module "azure-web-app" {
  source    = "../../modules/azure-web-app"

  app           = local.app
  docker_image  = local.docker_image
  env           = local.env
  tags          = local.tags
}