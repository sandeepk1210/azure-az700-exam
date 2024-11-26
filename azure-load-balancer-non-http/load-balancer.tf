# Load Balancer
# Create an internal Standard SKU load balancer
resource "azurerm_lb" "app_lb" {
  name                = "myIntLoadBalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard" # Options Standard & Gateway
  sku_tier            = "Regional" # Options Regional & Global

  # A public or private IP address associated with the load balancer to receive incoming traffic.
  frontend_ip_configuration {
    name = "LoadBalancerFrontEnd"
    #public_ip_address_id = azurerm_public_ip.app_lb_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_app["myFrontEndSubnet"].id
  }
}

# Load Balancer Backend Address Pool
#   A collection of virtual machines or network interfaces that the load balancer will distribute traffic to.
resource "azurerm_lb_backend_address_pool" "app_backend_pool" {
  name            = "myBackendPool"
  loadbalancer_id = azurerm_lb.app_lb.id
}

# Associate NIC with Load Balancer Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association" {
  count                   = var.vm_count
  ip_configuration_name   = "internal"
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.app_backend_pool.id
}

# Load Balancer Health Probe
#    These determine the health of the instances in the backend pool and help the load balancer decide where to route traffic.
resource "azurerm_lb_probe" "app_health_probe" {
  name                = "myHealthProbe"
  loadbalancer_id     = azurerm_lb.app_lb.id
  protocol            = "Http"
  port                = 80
  interval_in_seconds = 15
  request_path        = "/" # Required if protocol is set to Http or Https. Otherwise, it is not allowed.
}

# Load Balancer Rule
#    Define how incoming traffic is distributed to the backend pool.
resource "azurerm_lb_rule" "app_lb_rule" {
  name            = "myHTTPRule"
  loadbalancer_id = azurerm_lb.app_lb.id
  protocol        = "Tcp"
  frontend_port   = 80
  backend_port    = 80
  #frontend_ip_configuration_id = azurerm_lb.app_lb.frontend_ip_configuration[0].id
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app_backend_pool.id]
  probe_id                       = azurerm_lb_probe.app_health_probe.id
  idle_timeout_in_minutes        = 15
  enable_floating_ip             = false
}
