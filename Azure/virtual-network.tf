resource "azurerm_virtual_network" "testnetwork" {
    name                = "myTestNet"
    address_space       = ["10.0.0.0/16"]
    location            = "westeurope"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    tags {
        environment = "terraform"
    }
}
