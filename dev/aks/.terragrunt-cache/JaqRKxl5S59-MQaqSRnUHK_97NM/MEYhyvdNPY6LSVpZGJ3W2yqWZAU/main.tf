module "aks" {
  for_each = var.aks_clusters

  source  = "Azure/aks/azurerm"
  version = "11.0.0"
  # insert the 2 required variables here
  
  resource_group_name = var.rgname
  location = var.location
  cluster_name  = each.value.aks_name
  prefix              = each.key
  

  # PRIVATE AKS
  private_cluster_enabled = true

  # Required for private cluster
  private_dns_zone_id = null

  
  network_plugin            = "azure"
  net_profile_service_cidr  = each.value.service_cidr
  net_profile_dns_service_ip     = each.value.dns_service_ip



  agents_pool_name = "system"
  agents_size = each.value.node_pools["system"].vm_size
  agents_count = each.value.node_pools["system"].node_count
  agents_type = "VirtualMachineScaleSets"
  identity_type = "SystemAssigned"
}


resource "azurerm_kubernetes_cluster_node_pool" "user_pools" {

  for_each = {
    for item in flatten([
      for cluster, cfg in var.aks_clusters : [
        for pool, pool_cfg in cfg.node_pools : {
          key       = "${cluster}-${pool}"
          cluster   = cluster
          pool_name = pool
          cfg       = pool_cfg
        }
        if pool != "system"
      ]
    ]) : item.key => item
  }

  kubernetes_cluster_id = module.aks[each.value.cluster].aks_id
  name                  = each.value.pool_name
  vm_size               = each.value.cfg.vm_size
  node_count            = each.value.cfg.node_count
  mode                  = each.value.cfg.mode
  vnet_subnet_id        = var.subnet_ids["${var.environment}-aks"]
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  for_each = module.aks

  principal_id = each.value.kubelet_identity[0].object_id

  role_definition_name = "AcrPull"
  scope                = var.acr_ids["acr"]
}

 


