output "acr_ids" {
  description = "ACR IDs"
  value = {
    for k, v in azurerm_container_registry.acr :
    k => v.id
  }
}

output "acr_logins" {
  description = "ACR login servers"
  value = {
    for k, v in azurerm_container_registry.acr :
    k => v.login_server
  }
}
