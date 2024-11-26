# Public IPs
resource "azurerm_public_ip" "manufacturing-pip2" {
  name                = "manufacturingvm2-pip"
  location            = var.location_manufacturing
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Security Groups
resource "azurerm_network_security_group" "manufacturing-nsg2" {
  name                = "manufacturingvm2-nsg"
  location            = var.location_manufacturing
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
resource "azurerm_network_interface" "manufacturing-nic2" {
  name                = var.nic_name2
  location            = var.location_manufacturing
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.subnet_manufacturing["ManufacturingSystemSubnet"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.manufacturing-pip2.id
  }
}

# Associate the NSG with each NIC
resource "azurerm_network_interface_security_group_association" "nic2_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.manufacturing-nic2.id
  network_security_group_id = azurerm_network_security_group.manufacturing-nsg2.id
}

# Virtual Machines
resource "azurerm_windows_virtual_machine" "vm2" {
  name                              = var.vm_name2
  location                          = var.location_manufacturing
  resource_group_name               = azurerm_resource_group.rg.name
  size                              = var.vm_size2
  admin_username                    = var.admin_username2
  admin_password                    = random_password.admin_password.result
  network_interface_ids             = [azurerm_network_interface.manufacturing-nic2.id]
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
