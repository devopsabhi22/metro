terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.29.1"
    }
  }
}

provider "azurerm" {
  subscription_id = "8c025d2f-997e-48be-85fa-46c16fb17787"
  tenant_id = "f2dae003-d3ab-460f-8872-5434ebaf2fed"
  client_id = "f1b6cbb4-4021-4ba5-8512-0973d6013c1d"
  client_secret = "exv8Q~SCHrCdXWlArSqDVgrIzDG6ZbL3FPAQrdrZ"
features {
    }  
}

resource "azurerm_resource_group" "aksgroup" {
  name     = "aks-cluster1"
  location = "Central India"
}

resource "azurerm_container_registry" "acr" {
  name                = "testakscontainerRegistry"
  resource_group_name = azurerm_resource_group.aksgroup.name
  location            = azurerm_resource_group.aksgroup.location
  sku                 = "Premium"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "akscluster" {
  name                = "testcluster-aks"
  location            = azurerm_resource_group.aksgroup.location
  resource_group_name = azurerm_resource_group.aksgroup.name
  dns_prefix          = "exampleaks12"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Test"
  }
}



output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}
