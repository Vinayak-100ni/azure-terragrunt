output "aks_subnet_id" {
  description = "The ID of the AKS subnet"
  value       = azurerm_subnet.subnets["aks"].id
}

output "mysql_subnet_id" {
  description = "The ID of the MySQL subnet"
  value       = azurerm_subnet.subnets["mysql"].id
}

output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}