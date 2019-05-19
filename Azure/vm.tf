resource "azurerm_virtual_machine" "testvm" {
    count                 = 3
    name                  = "myVM${count.index}"
    location              = "westeurope"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${element(azurerm_network_interface.testnic.*.id, count.index)}"]
    #vm_size               = "Standard_DS1_v2"
    vm_size                = "Standard_D2_v3" # Allow Nested VM.
    delete_data_disks_on_termination = true
    delete_os_disk_on_termination    = true
    
    storage_os_disk {
        count             = 3 
        name              = "myOsDisk${count.index}"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }
    
    os_profile {
        computer_name  = "myvm${count.index}"
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
