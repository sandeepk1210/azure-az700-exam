# Define a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name # Name of the resource group
  location = var.location            # Location of the resource group
}
