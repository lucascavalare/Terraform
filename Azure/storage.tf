# Creating random ID
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${azurerm_resource_group.rg.name}"
    }
    
    byte_length = 8
}

# Creating storage account to store VM boot options
resource "azurerm_storage_account" "teststorageaccount" {
    name                = "diag${random_id.randomId.hex}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location            = "westeurope"
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags {
        environment = "terraform"
    }
}
