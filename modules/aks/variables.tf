variable "create_aks" {
  description = "Map of AKS clusters to create"
  type = map(object({
    dns_prefix = string
    node_count = number
    vm_size    = string
  }))
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "rgname" {
  type = string
}

variable "acr_id" {
  type        = string
  description = "ACR ID for AcrPull role assignment"
}
