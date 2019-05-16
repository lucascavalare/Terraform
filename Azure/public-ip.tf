resource "azurerm_public_ip" "testpublicip" {
    name                         = "mypublicIP"
    location                     = "eastus"
    resource_group_name          = "${azurerm_resource_group.rg.name}"
    allocation_method            = "Dynamic"

    tags {
        environment = "terraform"
    }
}
