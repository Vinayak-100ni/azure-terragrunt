variable "create_acr" {
  description = "Map to control ACR creation"
  type = map(object({
    sku             = string
    admin_enabled   = bool
  }))
  default = {}
}

variable "environment" {
  type = string
}

variable "rgname" {
  type = string
}

variable "location" {
  type = string
}
