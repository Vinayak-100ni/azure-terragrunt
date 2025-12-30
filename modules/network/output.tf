output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value = {
    for key, subnet in azurerm_subnet.subnets :
    "${var.environment}-${key}" => subnet.id
  }
}


output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}
