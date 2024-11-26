# Virtual Network as Core Service
resource "azurerm_virtual_network" "vnet_app" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space_name

  tags = local.common_tags
}

#  Subnet
resource "azurerm_subnet" "subnet_app" {
  for_each             = var.subnet_name
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_app.name
  address_prefixes     = [each.value]
}
