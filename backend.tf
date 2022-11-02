terraform {
  backend "azurerm" {
    resource_group_name  = "testresourcegroup1"
    storage_account_name = "testasgardaksterraformthanos"
    container_name       = "testtfstatedevops"
    key                  = "testtfstatedevops.tfstate"
  }
}
