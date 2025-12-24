environment = "devVinayak"
location    = "westus2"
address_space = ["10.50.0.0/16"]

// create subnets

subnets = {
    aks = {
      address_prefixes = ["10.50.1.0/24"]
      delegation       = false
    }
    mysql = {
      address_prefixes = ["10.50.2.0/24"]
      delegation       = true
    }
  }

// create ACR
  create_acr = {
  acr = {
    sku           = "Premium"
    admin_enabled = false
  }
}