provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "tamops"
  location = "Central India"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "akscontainerRegistry1thanos"
  resource_group_name = azurerm_resource_group.default.name
  location            = "Central India"
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "akscluster1" {
  name                = "cluster-aks1233"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "exampleaks12"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
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
