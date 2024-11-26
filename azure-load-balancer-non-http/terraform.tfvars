resource_group_name = "IntLB-RG"
location            = "eastus"

#Network1 as Core Service
vnet_name          = "IntLB-VNet"
address_space_name = ["10.1.0.0/16"]
subnet_name = {
  "myBackendSubnet"    = "10.1.0.0/24"
  "myFrontEndSubnet"   = "10.1.2.0/24"
  "AzureBastionSubnet" = "10.1.1.0/26"
}

# VM
vm_count       = 3 # Identity how many VMs to be created
admin_username = "TestUser"
vm_size        = "Standard_DS1_v2"
