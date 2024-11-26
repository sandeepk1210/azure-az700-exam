variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}

# Network
variable "vnet_core_service" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_space_core_service" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "subet_core_service" {
  type        = map(string)
  description = "App subnets consists of subnet name and subnet range"
}

variable "location_core_service" {
  type = string
}

variable "location_manufacturing" {
  type = string
}

variable "vnet_manufacturing" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_space_manufacturing" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "subnet_manufacturing" {
  type        = map(string)
  description = "Hub subnets consists of subnet name and subnet range"
}

variable "vnet_research" {
  description = "Name of the Research Virtual Network"
  type        = string
}

variable "address_space_research" {
  description = "Address space for the Research Virtual Network"
  type        = list(string)
}

variable "location_research" {
  description = "Location for the Research Virtual Network"
  type        = string
}

variable "subnet_research" {
  description = "Subnets for the Research Virtual Network with their respective address spaces"
  type        = map(string)
}

# Virtual Machine Variables
variable "vm_name1" {
  type        = string
  description = "Name of the first virtual machine."
}

variable "nic_name1" {
  type        = string
  description = "Name of the network interface card (NIC) associated with the first virtual machine."
}

variable "vm_size1" {
  type        = string
  description = "Size of the virtual machines (e.g., Standard_DS1_v2)."
}

variable "admin_username1" {
  type        = string
  description = "Admin username for accessing the virtual machines."
}

variable "vm_name2" {
  type        = string
  description = "Name of the second virtual machine."
}

variable "nic_name2" {
  type        = string
  description = "Name of the network interface card (NIC) associated with the second virtual machine."
}

variable "vm_size2" {
  type        = string
  description = "Size of the virtual machines (e.g., Standard_DS1_v2)."
}

variable "admin_username2" {
  type        = string
  description = "Admin username for accessing the virtual machines."
}

# Virtual Network Gateway
variable "vpn_gateway_name" {
  type        = string
  description = "Name of the VPN gateway"
}

variable "gateway_sku" {
  type        = string
  description = "Gateway SKU"
}


variable "manufacturing_gateway_name" {
  type        = string
  description = "Name of the VPN gateway"
}

variable "manufacturing_gateway_sku" {
  type        = string
  description = "Gateway SKU"
}
