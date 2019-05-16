resource "azurerm_subnet" "testsubnet" {
    name                 = "mysubnet"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.testnetwork.name}"
    address_prefix       = "10.0.2.0/24"
}
