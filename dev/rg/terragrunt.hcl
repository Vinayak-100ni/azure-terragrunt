terraform {
source = "../../modules/rg"
}

include "root" {
path = find_in_parent_folders("root.hcl")
}

