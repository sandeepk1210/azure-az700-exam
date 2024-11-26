# Given the HUB will require a virtual network gateway so that traffic can be routed between the spoke
# Public IP for the Virtual Network Gateway
resource "azurerm_public_ip" "vpn_gateway_ip" {
  name                = "CoreServicesVnetGateway-ip"
  location            = var.location_core_service
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

# Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.vpn_gateway_name
  location            = var.location_core_service
  resource_group_name = azurerm_resource_group.rg.name
  type                = "Vpn"        # Options: Vpn, ExpressRoute
  vpn_type            = "RouteBased" # Options: PolicyBased, RouteBased
  sku                 = var.gateway_sku
  active_active       = false
  enable_bgp          = false #Border Gateway Protocol

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.vpn_gateway_ip.id
    subnet_id            = azurerm_subnet.subet_core_service["GatewaySubnet"].id
  }

  tags = local.common_tags
}

# Public IP for the Virtual Network Gateway
resource "azurerm_public_ip" "manufacturing_gateway_ip" {
  name                = "ManufacturingVnetGateway-ip"
  location            = var.location_manufacturing
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

# Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "manufacturing_gateway" {
  name                = var.manufacturing_gateway_name
  location            = var.location_manufacturing
  resource_group_name = azurerm_resource_group.rg.name
  type                = "Vpn"        # Options: Vpn, ExpressRoute
  vpn_type            = "RouteBased" # Options: PolicyBased, RouteBased
  sku                 = var.manufacturing_gateway_sku
  active_active       = false
  enable_bgp          = false #Border Gateway Protocol

  ip_configuration {
    name                 = "manufacturingGatewayConfig"
    public_ip_address_id = azurerm_public_ip.manufacturing_gateway_ip.id
    subnet_id            = azurerm_subnet.subnet_manufacturing["GatewaySubnet"].id
  }

  tags = local.common_tags
}

# VNet-to-VNet Connection - Connect CoreServicesVnet to ManufacturingVnet
resource "azurerm_virtual_network_gateway_connection" "core_to_manufacturing" {
  name                            = "CoreServicesGW-to-ManufacturingGW"
  location                        = var.location_core_service
  resource_group_name             = azurerm_resource_group.rg.name
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpn_gateway.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.manufacturing_gateway.id
  type                            = "Vnet2Vnet"
  shared_key                      = "abc123" # Pre-shared key

  # Optional: IPsec Policy
  ipsec_policy {
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    dh_group         = "DHGroup14"
    ipsec_encryption = "AES256" # Required attribute
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS14"
  }
}

# VNet-to-VNet Connection - Connect ManufacturingVnet to CoreServicesVnet
resource "azurerm_virtual_network_gateway_connection" "manufacturing_to_core" {
  name                            = "ManufacturingGW-to-CoreServicesGW"
  location                        = var.location_manufacturing
  resource_group_name             = azurerm_resource_group.rg.name
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.manufacturing_gateway.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway.id
  type                            = "Vnet2Vnet"
  shared_key                      = "abc123" # Pre-shared key

  # Optional: IPsec Policy
  ipsec_policy {
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    dh_group         = "DHGroup14"
    ipsec_encryption = "AES256" # Required attribute
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS14"
  }
}
