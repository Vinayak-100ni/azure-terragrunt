terraform {
  source = "../../modules/aks"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "rg" {
  config_path = "../rg"
  mock_outputs = {
    rgname   = "devVinayak"
    location = "westus2"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    subnet_ids = {
      dev-aks = "00000000-0000-0000-0000-000000000000"
    }

    vnet_id = "00000000-0000-0000-0000-000000000000"
  }

 }

# dependency "acr" {
#   config_path = "../acr"

#   mock_outputs = {
#     acr_ids = {
#       acr = "00000000-0000-0000-0000-000000000000"
#     }
#   }
# }


dependency "acr" {
  config_path = "../acr"

  mock_outputs = {
    acr_ids = {
      acr = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mock-rg/providers/Microsoft.ContainerRegistry/registries/mockacr"
    }
  }

  mock_outputs_allowed_terraform_commands = ["plan"]
}



inputs = {
  rgname       = dependency.rg.outputs.rgname
  location     = dependency.rg.outputs.location
  acr_ids      = dependency.acr.outputs.acr_ids
  subnet_ids    = dependency.network.outputs.subnet_ids
}
