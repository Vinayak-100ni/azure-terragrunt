environment = "dev-vinayak"
location    = "westus2"
address_space = ["10.50.0.0/16"]
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