environment   = "devVinayak"
location      = "westus2"
address_space = ["10.50.0.0/16"]

// create subnets

subnets = {
  app = {
    address_prefixes = ["10.50.1.0/24"]
    delegation       = true
  }

  aks = {
    address_prefixes = ["10.50.2.0/24"]
    delegation       = false
  }
}


// create ACR
create_acr = {
  acr = {
    sku           = "Premium"
    admin_enabled = false
  }
}

aks_clusters = {
  clusterOne = {
    aks_name       = "aksdev"
    service_cidr   = "10.50.4.0/22"
    dns_service_ip = "10.50.4.10"

    node_pools = {
      system = {
        vm_size    = "Standard_B2s"
        node_count = 1
        mode       = "System"
      }
    }
  }
}