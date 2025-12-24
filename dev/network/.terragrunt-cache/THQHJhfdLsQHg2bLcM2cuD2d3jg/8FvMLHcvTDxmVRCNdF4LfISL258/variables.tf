variable "environment" {
  description = "The environment for the Resource Group"
  type        = string
}

variable "subnets" {
  description = "Map of subnets and their CIDRs"
  type = map(object({
    address_prefixes = list(string)
    delegation       = optional(bool, false)
  }))
}


variable "location" {
  description = "The location of the Resource Group"
  type        = string
}

variable "rgname" {
  type = string
}

variable "address_space" {
  type = list(string)
}


