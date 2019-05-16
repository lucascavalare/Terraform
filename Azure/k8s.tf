/*
# Creating Azure Resource group.
resource "azurerm_resource_group" "k8s" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}
*/
  
resource "azurerm_resource_group" "rg" {
  name = "testResourceGroup"
  location = "westeurope"
}
 
