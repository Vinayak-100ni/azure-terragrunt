variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "rgname" {
  type = string
}


variable "subnet_ids" {
  type = map(string)
}

variable "acr_ids" {
  type        = map(string)
  description = "ACR IDs passed from Terragrunt"
}


variable "aks_clusters" {
  type = map(object({
    aks_name        = string
    service_cidr   = string
    dns_service_ip = string

    node_pools = map(object({
      vm_size    = string
      node_count = number
      mode       = string
    }))
  }))
}
