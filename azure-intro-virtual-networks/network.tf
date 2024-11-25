# Virtual Network as Core Service
resource "azurerm_virtual_network" "vnet_core_service" {
  name                = var.vnet_core_service
  location            = var.location_core_service
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space_core_service

  tags = local.common_tags
}

#  Subnet
resource "azurerm_subnet" "subet_core_service" {
  for_each             = var.subet_core_service
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_core_service.name
  address_prefixes     = [each.value]
}

# Virtual Network as Manufacturing
resource "azurerm_virtual_network" "vnet_manufacturing" {
  name                = var.vnet_manufacturing
  location            = var.location_manufacturing
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space_manufacturing

  tags = local.common_tags
}

# Subnet
resource "azurerm_subnet" "subnet_manufacturing" {
  for_each             = var.subnet_manufacturing
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_manufacturing.name
  address_prefixes     = [each.value]
}

# Virtual Network as Research
resource "azurerm_virtual_network" "vnet_research" {
  name                = var.vnet_research
  location            = var.location_research
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space_research

  tags = local.common_tags
}

# Subnet
resource "azurerm_subnet" "subnet_research" {
  for_each             = var.subnet_research
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_research.name
  address_prefixes     = [each.value]
}

# Define the peering from vnet-spokeB to hub-vnet
# It enables to seamlessly connect two or more Virtual Networks in Azure.
resource "azurerm_virtual_network_peering" "CoreServicesVnet_to_ManufacturingVnet" {
  name                      = "CoreServicesVnet-to-ManufacturingVnet"
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_core_service.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_manufacturing.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# Define the peering from hub-vnet to vnet-spokeB
resource "azurerm_virtual_network_peering" "ManufacturingVnet_to_CoreServicesVnet" {
  name                      = "ManufacturingVnet-to-CoreServicesVnet"
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_manufacturing.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_core_service.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}
