terraform {
  backend "azurerm" {
    resource_group_name  = "testresourcegroup1"
    storage_account_name = "metro1243"
    container_name       = "test"
    key                  = "test.tfstate"
  }
}
