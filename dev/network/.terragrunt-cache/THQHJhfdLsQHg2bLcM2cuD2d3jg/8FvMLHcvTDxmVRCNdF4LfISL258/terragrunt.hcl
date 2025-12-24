terraform {
source = "../../modules/network"
}

include "root" {
path = find_in_parent_folders("root.hcl")
}

dependency "rg" {
  config_path = "../rg"

  # allows plan before apply
  mock_outputs = {
    rgname   = "dev-vinayak"
    location = "westus2"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
rgname  = dependency.rg.outputs.rgname
location = dependency.rg.outputs.location
}