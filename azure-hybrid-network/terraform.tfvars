resource_group_name = "ContosoResourceGroup"
location            = "eastus"

#Network1 as Core Service
vnet_core_service          = "CoreServicesVnet"
address_space_core_service = ["10.20.0.0/16"]
location_core_service      = "eastus"
subet_core_service = {
  "GatewaySubnet"          = "10.20.0.0/27"
  "SharedServicesSubnet"   = "10.20.10.0/24"
  "DatabaseSubnet"         = "10.20.20.0/24"
  "PublicWebServiceSubnet" = "10.20.30.0/24"
  "AzureBastionSubnet"     = "10.20.0.64/26"
}

#Network2 as Manufacturing
vnet_manufacturing          = "ManufacturingVnet"
address_space_manufacturing = ["10.30.0.0/16"]
location_manufacturing      = "northeurope"
subnet_manufacturing = {
  "GatewaySubnet"             = "10.30.0.0/27"
  "ManufacturingSystemSubnet" = "10.30.10.0/24"
  "SensorSubnet1"             = "10.30.20.0/24"
  "SensorSubnet2"             = "10.30.21.0/24"
  "SensorSubnet3"             = "10.30.22.0/24"
}

#Network3 as Research
vnet_research          = "ResearchVnet"
address_space_research = ["10.40.0.0/16"]
location_research      = "southeastasia"
subnet_research = {
  "ResearchSystemSubnet" = "10.40.0.0/24"
}

# VM for Core Services
vm_name1        = "CoreServicesVM"
nic_name1       = "CoreServicesVM-nic"
vm_size1        = "Standard_DS1_v2"
admin_username1 = "TestUser"

# VM for Manufacturing
vm_name2        = "ManufacturingVM"
nic_name2       = "ManufacturingVM-nic"
vm_size2        = "Standard_D2as_v5"
admin_username2 = "TestUser"

# Virtual Network Gateway
vpn_gateway_name = "CoreServicesVnetGateway"
gateway_sku      = "VpnGw1" # Options: Basic, VpnGw1, VpnGw2, etc.

manufacturing_gateway_name = "ManufacturingVnetGateway"
manufacturing_gateway_sku  = "VpnGw1" # Options: Basic, VpnGw1, VpnGw2, etc.
