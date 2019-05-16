
# Creating Azure Resource group.  
resource "azurerm_resource_group" "rg" {
  name = "testResourceGroup"
  location = "westeurope"
  
  tags {
    environment = "terraform"
    }
}
 
