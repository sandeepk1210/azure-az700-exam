# Output the Virtual Network Name
output "vnet_name" {
  value       = azurerm_virtual_network.vnet_app.name
  description = "The name of the virtual network."
}

# Output the Subnet Names
output "subnet_names" {
  value       = [for subnet in azurerm_subnet.subnet_app : subnet.name]
  description = "List of subnet names."
}

# Output the Random Admin Password
output "admin_password" {
  value       = random_password.admin_password.result
  sensitive   = true
  description = "The randomly generated admin password."
}

# Output the Public IP Address for Bastion Host
output "bastion_public_ip" {
  value       = azurerm_public_ip.bastion_public_ip.ip_address
  description = "The public IP address for the bastion host."
}

# Output the Load Balancer Frontend IP Configuration
output "load_balancer_frontend_ip" {
  value       = azurerm_lb.app_lb.frontend_ip_configuration[0].private_ip_address
  description = "The frontend IP address of the load balancer."
}

# Output the Backend Pool Name
output "backend_pool_name" {
  value       = azurerm_lb_backend_address_pool.app_backend_pool.name
  description = "The name of the load balancer backend pool."
}

# Output the Load Balancer Rule Details
output "load_balancer_rule" {
  value       = azurerm_lb_rule.app_lb_rule.name
  description = "The load balancer rule for HTTP traffic."
}

# Output the Health Probe Details
output "health_probe" {
  value       = azurerm_lb_probe.app_health_probe.name
  description = "The health probe configuration for the load balancer."
}

# Output the Network Interface IDs associated with the VMs
output "vm_network_interface_ids" {
  value       = [azurerm_network_interface.nic[*].id]
  description = "List of network interface IDs associated with VMs."
}

# Output the Bastion Host Name
output "bastion_host_name" {
  value       = azurerm_bastion_host.bastion_core_service.name
  description = "The name of the bastion host."
}

# Output the Windows VMs Public IPs
output "vm_public_ips" {
  value       = [for vm in azurerm_windows_virtual_machine.vm : vm.public_ip_address]
  description = "List of public IP addresses for Windows VMs."
}


# Output for the Windows Virtual Machine
output "test_vm_name" {
  value       = azurerm_windows_virtual_machine.test-vm.name
  description = "The name of the test virtual machine."
}

output "test_vm_id" {
  value       = azurerm_windows_virtual_machine.test-vm.id
  description = "The ID of the test virtual machine."
}

output "test_vm_private_ip" {
  value       = azurerm_network_interface.test_vm_nic.private_ip_address
  description = "The private IP address of the test virtual machine."
}

output "test_vm_admin_username" {
  value       = azurerm_windows_virtual_machine.test-vm.admin_username
  description = "The admin username for the test virtual machine."
}

output "test_vm_nic_private_ip" {
  value       = azurerm_network_interface.test_vm_nic.private_ip_address
  description = "The private IP address associated with the test VM NIC."
}