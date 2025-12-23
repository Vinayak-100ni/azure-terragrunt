variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"
}

variable "vnet" {
type = object({
name = string 
address_space = list(string)
subnets = map(object({
  name           = string
  address_prefix = string
}