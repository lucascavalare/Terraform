resource "azurerm_subnet" "mytestsubnet" {
    name                 = "mysubnet"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.mytestnetwork.name}"
    address_prefix       = "10.0.2.0/24"
}
