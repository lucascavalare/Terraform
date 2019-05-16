# Setting up Azure Provider
provider "azurerm" {
  version = "->1.5"
}

# Provisioning with Terraform IAC
terrarofm {
  backend "azurerm" {}
}

