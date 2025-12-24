include {
  path = find_in_parent_folders("root.hcl")
}

remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "vinayak-terraform"
    storage_account_name = "tfstagebackendvinayak"
    container_name       = "tfstate"
    key                  = "stage/terraform.tfstate"
  }
}

inputs = {
environment = "stage"
location    = "westus2"
address_space = ["10.10.0.0/16"]
subnet_prefix = ["10.10.1.0/24"]
}