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

variable "dns_name" {
  type = string
}

# Variables
variable "vm_name1" {
  type = string
}

variable "nic_name1" {
  type = string
}

variable "vm_name2" {
  type = string
}

variable "nic_name2" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}
