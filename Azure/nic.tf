resource "azurerm_network_interface" "testnic" {
    count               = 3
    name                = "myNIC${count.index}"
    location            = "westeurope"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.testsg.id}"

    ip_configuration {
        name                          = "myNicConfiguration${count.index}"
        subnet_id                     = "${azurerm_subnet.testsubnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = ["${element(azurerm_public_ip.testpublicip.*.id, count.index)}"]
    }

    tags {
        environment = "terraform"
    }
}
