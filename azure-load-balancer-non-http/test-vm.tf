
# Windows Virtual Machines to the HUB network
resource "azurerm_windows_virtual_machine" "test-vm" {
  name                = "myTestVM"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = random_password.admin_password.result
  network_interface_ids = [
    azurerm_network_interface.test_vm_nic.id
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
resource "azurerm_network_interface" "test_vm_nic" {
  name                = "myVMnic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_app["myBackendSubnet"].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Associate the NSG with each NIC
resource "azurerm_network_interface_security_group_association" "testvm_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.test_vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
