# Random password
resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

# Public IPs
resource "azurerm_public_ip" "core-pip1" {
  name                = "corevm1-pip"
  location            = var.location_core_service
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Security Groups
resource "azurerm_network_security_group" "core-nsg1" {
  name                = "corevm1-nsg"
  location            = var.location_core_service
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "default-allow-rdp"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Network Interfaces
resource "azurerm_network_interface" "core-nic1" {
  name                = var.nic_name1
  location            = var.location_core_service
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subet_core_service["DatabaseSubnet"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.core-pip1.id
  }
}

# Associate the NSG with each NIC
resource "azurerm_network_interface_security_group_association" "nic1_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.core-nic1.id
  network_security_group_id = azurerm_network_security_group.core-nsg1.id
}

# Virtual Machines
resource "azurerm_windows_virtual_machine" "vm1" {
  name                              = var.vm_name1
  location                          = var.location_core_service
  resource_group_name               = azurerm_resource_group.rg.name
  size                              = var.vm_size1
  admin_username                    = var.admin_username1
  admin_password                    = random_password.admin_password.result
  network_interface_ids             = [azurerm_network_interface.core-nic1.id]
  vm_agent_platform_updates_enabled = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Bastion Host
# resource "azurerm_bastion_host" "bastion_core_service" {
#   name                = "core-service-bastion"
#   location            = var.location_core_service
#   resource_group_name = azurerm_resource_group.rg.name
#   sku                 = "Developer"
#   virtual_network_id  = azurerm_virtual_network.vnet_core_service.id

#   ip_configuration {
#     name                 = "ipconfig_bastion1"
#     subnet_id            = azurerm_subnet.subet_core_service["AzureBastionSubnet"].id
#     public_ip_address_id = azurerm_public_ip.core-pip1.id
#   }

#   tags = local.common_tags
# }