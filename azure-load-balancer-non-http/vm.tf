# Random password
resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

# Public IPs
resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastion_public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Bastion Host
resource "azurerm_bastion_host" "bastion_core_service" {
  name                = "core-service-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  ip_configuration {
    name                 = "ipconfig_bastion"
    subnet_id            = azurerm_subnet.subnet_app["AzureBastionSubnet"].id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }

  tags = local.common_tags
}

# Windows Virtual Machines
resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "myVM${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = random_password.admin_password.result
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]
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

# Network Interface
resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "myVMnic${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_app["myBackendSubnet"].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "vm-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-rdp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the NSG with each NIC
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  count                     = var.vm_count
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Custom Script Extension to install IIS and create Default.html
resource "azurerm_virtual_machine_extension" "iis_extension" {
  count                = var.vm_count
  name                 = "iis-extension-${count.index + 1}"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  protected_settings = jsonencode({
    commandToExecute = "powershell -command \"Install-WindowsFeature -name Web-Server; New-Item -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -ItemType File -Force; Add-Content -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -Value '<html><body><h1>Hello from VM ${(count.index + 1)}</h1></body></html>'\""
  })

  depends_on = [azurerm_windows_virtual_machine.vm]
}
