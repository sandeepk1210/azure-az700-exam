# Create Private DNS Zone
resource "azurerm_private_dns_zone" "services_private_dns" {
  name                = var.dns_name
  resource_group_name = data.azurerm_resource_group.rg.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "core_service_dns_virtual_network_link" {
  name                  = "CoreServicesVnetLink"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.services_private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet_core_service.id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "manufacturing_dns_virtual_network_link" {
  name                  = "ManufacturingVnetLink"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.services_private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet_manufacturing.id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "research_dns_virtual_network_link" {
  name                  = "ResearchVnetLink"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.services_private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet_research.id
  registration_enabled  = true
}
