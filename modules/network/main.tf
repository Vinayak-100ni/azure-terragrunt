resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rgname
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = "${var.environment}-${each.key}"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.delegation ? [1] : []

    content {
      name = "delegation"

      service_delegation {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
        ]
      }
    }
  }
}
