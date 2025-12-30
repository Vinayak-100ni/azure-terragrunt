output "aks_ids" {
  description = "AKS cluster IDs"
  value = {
    for k, v in module.aks :
    k => v.aks_id
  }
}
