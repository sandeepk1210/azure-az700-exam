# Output the resource group name
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# Output the name of the virtual network
output "vnet_core_service_name" {
  description = "Name of the Virtual Network for Core Service"
  value       = azurerm_virtual_network.vnet_core_service.name
}

# Output the address space of the virtual network
output "vnet_core_service_address_space" {
  description = "Address space of the Virtual Network for Core Service"
  value       = join(",", azurerm_virtual_network.vnet_core_service.address_space)
}

# Output the names and address prefixes of the subnets
output "subnets_core_service" {
  description = "Subnets within the Core Service Virtual Network"
  value = {
    for name, subnet in azurerm_subnet.subet_core_service :
    name => join(",", subnet.address_prefixes)
  }
}

# Output the name of the virtual network
output "vnet_manufacturing_name" {
  description = "Name of the Virtual Network for Manufacturing"
  value       = azurerm_virtual_network.vnet_manufacturing.name
}

# Output the address space of the virtual network
output "vnet_manufacturing_address_space" {
  description = "Address space of the Virtual Network for Manufacturing"
  value       = join(",", azurerm_virtual_network.vnet_manufacturing.address_space)
}

# Output the names and address prefixes of the subnets
output "subnets_manufacturing" {
  description = "Subnets within the Manufacturing Virtual Network"
  value = {
    for name, subnet in azurerm_subnet.subnet_manufacturing :
    name => join(",", subnet.address_prefixes)
  }
}


# Output the name of the virtual network
output "vnet_research_name" {
  description = "Name of the Virtual Network for Research"
  value       = azurerm_virtual_network.vnet_research.name
}

# Output the address space of the virtual network
output "vnet_research_address_space" {
  description = "Address space of the Virtual Network for Research"
  value       = join(",", azurerm_virtual_network.vnet_research.address_space)
}

# Output the names and address prefixes of the subnets
output "subnets_research" {
  description = "Subnets within the Research Virtual Network"
  value = {
    for name, subnet in azurerm_subnet.subnet_research :
    name => join(",", subnet.address_prefixes)
  }
}

# Output the randomly generated admin password
output "admin_password" {
  description = "Randomly generated admin password for the virtual machines."
  value       = random_password.admin_password.result
  sensitive   = true
}

# Output the public IPs for the virtual machines
output "vm1_public_ip" {
  description = "Public IP address of the first virtual machine."
  value       = azurerm_public_ip.core-pip1.ip_address
}

output "vm2_public_ip" {
  description = "Public IP address of the second virtual machine."
  value       = azurerm_public_ip.manufacturing-pip2.ip_address
}

# Output the virtual machine names
output "vm1_name" {
  description = "Name of the first virtual machine."
  value       = azurerm_windows_virtual_machine.vm1.name
}

output "vm2_name" {
  description = "Name of the second virtual machine."
  value       = azurerm_windows_virtual_machine.vm2.name
}

# Output the virtual machine IDs
output "vm1_id" {
  description = "Resource ID of the first virtual machine."
  value       = azurerm_windows_virtual_machine.vm1.id
}

output "vm2_id" {
  description = "Resource ID of the first virtual machine."
  value       = azurerm_windows_virtual_machine.vm2.id
}

output "vpn_gateway_ip" {
  description = "Public IP address of the Core Services VNet Gateway"
  value       = azurerm_public_ip.vpn_gateway_ip.ip_address
}

output "vpn_gateway_id" {
  description = "Resource ID of the Core Services Virtual Network Gateway"
  value       = azurerm_virtual_network_gateway.vpn_gateway.id
}

output "manufacturing_gateway_ip" {
  description = "Public IP address of the Manufacturing VNet Gateway"
  value       = azurerm_public_ip.manufacturing_gateway_ip.ip_address
}

output "manufacturing_gateway_id" {
  description = "Resource ID of the Manufacturing Virtual Network Gateway"
  value       = azurerm_virtual_network_gateway.manufacturing_gateway.id
}

output "core_to_manufacturing_connection_status" {
  description = "Connection status of the CoreServicesVnet to ManufacturingVnet"
  value       = azurerm_virtual_network_gateway_connection.core_to_manufacturing.connection_status
}

output "manufacturing_to_core_connection_status" {
  description = "Connection status of the ManufacturingVnet to CoreServicesVnet"
  value       = azurerm_virtual_network_gateway_connection.manufacturing_to_core.connection_status
}

output "core_to_manufacturing_shared_key" {
  description = "Pre-shared key used for CoreServicesVnet to ManufacturingVnet connection"
  value       = azurerm_virtual_network_gateway_connection.core_to_manufacturing.shared_key
  sensitive   = true
}

output "manufacturing_to_core_shared_key" {
  description = "Pre-shared key used for ManufacturingVnet to CoreServicesVnet connection"
  value       = azurerm_virtual_network_gateway_connection.manufacturing_to_core.shared_key
  sensitive   = true
}
