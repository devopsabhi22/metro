terraform {
  backend "azurerm" {
    resource_group_name  = "testresourcegroup1"
    storage_account_name = "testaksterraform12"
    container_name       = "testtfstatedevops"
    key                  = "testtfstatedevops.tfstate"
  }
}
