resource "azurerm_network_interface" "testnic" {
    name                = "myNIC"
    location            = "westeurope"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.testsg.id}"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "${azurerm_subnet.testsubnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.testpublicip.id}"
    }

    tags {
        environment = "terraform"
    }
}
