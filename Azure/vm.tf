resource "azurerm_virtual_machine" "testvm" {
    name                  = "myVM"
    location              = "westeurope"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.testnic.id}"]
    #vm_size               = "Standard_DS1_v2"
    vm_size                = "Standard_D2_v3" # Allow Nested VM.

    storage_os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_SSD"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }
    
    os_profile {
        computer_name  = "myvm"
        admin_username = "azureuser"
        admin_password = "Password1234!"
    }
    
    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.teststorageaccount.primary_blob_endpoint}"
    }

    tags {
        environment = "terraform"
    }
    
    provisioner "local-exec" {
        command = "./install-kubectl.sh"
        
        environment {
          resource_group_name = "${azurerm_resource_group.rg.name}"
          virtual_network_name = "${azurerm_virtual_network.testnetwork.name}"
        }
    }
}
