resource_group_name = "ContosoResourceGrouplod46079288"
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
}

#Network2 as Manufacturing
vnet_manufacturing          = "ManufacturingVnet"
address_space_manufacturing = ["10.30.0.0/16"]
location_manufacturing      = "westeurope"
subnet_manufacturing = {
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

# DNS
dns_name = "Contoso.com"

# VM
vm_name1       = "testvm1"
nic_name1      = "testvm1-nic"
vm_name2       = "testvm2"
nic_name2      = "testvm2-nic"
vm_size        = "Standard_DS1_v2"
admin_username = "TestUser"
