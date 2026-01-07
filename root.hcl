locals {
  environment = basename(dirname(get_original_terragrunt_dir()))

  subscription_id = "f3d203d7-a878-4a98-889d-3db57315cfce"

  backend_rg = "vinayak-terraform"

  backend_storage_accounts = {
    dev   = "tfdevbackendvinayak"
    stage = "tfstagebackendvinayak"
  }
}

remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = local.backend_rg
    storage_account_name = local.backend_storage_accounts[local.environment]
    container_name       = "tfstate"
    key                  = "${local.environment}/${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
  provider "azurerm" {
  features {}
  subscription_id = var.subscriptionId
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
EOF
}

terraform {
  extra_arguments "tfvars" {
    commands = ["plan", "apply", "destroy"]

    arguments = [
      "-var-file=${dirname(get_original_terragrunt_dir())}/${local.environment}.tfvars"
      "-var=client_id=${get_env("CLIENT_ID")}",
      "-var=client_secret=${get_env("CLIENT_SECRET")}",
      "-var=tenant_id=${get_env("TENANT_ID")}",
      "-var=subscription_id=${get_env("SUBSCRIPTION_ID")}"
    ]
  }
}


# locals {
#   # Detect environment from folder name
#   environment = basename(dirname(get_terragrunt_dir()))

#   subscription_id = "f3d203d7-a878-4a98-889d-3db57315cfce"

#   backend_rg = "vinayak-terraform"

#   backend_storage_accounts = {
#     dev   = "tfdevbackendvinayak"
#     stage = "tfstagebackendvinayak"
#   }
# }

# remote_state {
#   backend = "azurerm"

#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }

#   config = {
#     resource_group_name  = local.backend_rg
#     storage_account_name = local.backend_storage_accounts[local.environment]
#     container_name       = "tfstate"
#     key                  = "${local.environment}/${path_relative_to_include()}/terraform.tfstate"
#   }
# }

# generate "providers" {
#   path      = "providers.tf"
#   if_exists = "overwrite_terragrunt"

#   contents = <<EOF
# provider "azurerm" {
#   features {}
#   subscription_id = "${local.subscription_id}"
# }
# EOF
# }


# terraform {
# extra_arguments "tfvars" {
#   commands = ["plan", "apply", "destroy"]

#   # Dynamically detect tfvars based on environment
#   arguments = [
#     "-var-file=${dirname(get_terragrunt_dir())}/${local.environment}.tfvars"
#   ]
# }

# }

