resource "azurerm_container_registry" "acr" {

for_each = var.create_acr
   name = "${var.environment}${each.key}"
      
  resource_group_name = var.rgname
  location            = var.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled
}