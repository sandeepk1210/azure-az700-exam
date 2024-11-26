# Virtual Network as Core Service
resource "azurerm_virtual_network" "vnet_core_service" {
  name                = var.vnet_core_service
  location            = var.location_core_service
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space_core_service

  tags = local.common_tags
}

#  Subnet
resource "azurerm_subnet" "subet_core_service" {
  for_each             = var.subet_core_service
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_core_service.name
  address_prefixes     = [each.value]
  # Controls whether network policies (like NSGs or routing rules) are applied to private endpoints in the subnet.
  # When deploying Azure Private Endpoints (e.g., for secure communication to services like Azure Storage or SQL Database), 
  #  network policies must be disabled to allow the private endpoint to function correctly.
  # Set to "Enabled" if the subnet isn't intended to host private endpoints or if policies should apply
  private_endpoint_network_policies = "Enabled"
  # Determines whether network policies are enforced on private link services hosted in the subnet.
  # When hosting a Private Link Service (e.g., to expose an internal service securely), 
  #  network policies need to be disabled to ensure proper functionality.
  # Set to "Enabled" if the subnet does not host a private link service.
  private_link_service_network_policies_enabled = true
}

# Virtual Network as Manufacturing
resource "azurerm_virtual_network" "vnet_manufacturing" {
  name                = var.vnet_manufacturing
  location            = var.location_manufacturing
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space_manufacturing

  tags = local.common_tags
}

# Subnet
resource "azurerm_subnet" "subnet_manufacturing" {
  for_each                                      = var.subnet_manufacturing
  name                                          = each.key
  resource_group_name                           = azurerm_resource_group.rg.name
  virtual_network_name                          = azurerm_virtual_network.vnet_manufacturing.name
  address_prefixes                              = [each.value]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
}

# Virtual Network as Research
resource "azurerm_virtual_network" "vnet_research" {
  name                = var.vnet_research
  location            = var.location_research
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space_research

  tags = local.common_tags
}

# Subnet
resource "azurerm_subnet" "subnet_research" {
  for_each                                      = var.subnet_research
  name                                          = each.key
  resource_group_name                           = azurerm_resource_group.rg.name
  virtual_network_name                          = azurerm_virtual_network.vnet_research.name
  address_prefixes                              = [each.value]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
}
