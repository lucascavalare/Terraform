resource "azurerm_public_ip" "testpublicip" {
    #count                        = 3
    name                         = "myPublicIP${count.index}"
    location                     = "westeurope"
    resource_group_name          = "${azurerm_resource_group.rg.name}"
    allocation_method            = "Dynamic"
    #depends_on                   = ["azurerm_virtual_machine.testvm"]
    
    tags {
        environment = "terraform"
    }
}
