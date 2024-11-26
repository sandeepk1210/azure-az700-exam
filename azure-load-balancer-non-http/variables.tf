variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}

# Network
variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_space_name" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "subnet_name" {
  type        = map(string)
  description = "App subnets consists of subnet name and subnet range"
}

# Virtual Machine Variables
variable "vm_count" {
  type        = number
  description = "The number of virtual machines to create"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machines"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machines"
}
