variable "peering_cidrs" {
  description = "The cidrs for the transit that will be peered here."
  type = map(object({
    name     = string
    cidr     = list(string)
    location = string
    subnets  = map(string)
    tags     = map(string)
  }))
}

variable "cidr" {
  description = "The cidrs for the transit that will be peered here."
  type = object({
    name     = string
    cidr     = list(string)
    location = string
    subnets  = map(string)
    tags     = map(string)
  })
}

variable "created_virtual_networks" {
  description = "The created virtual networks that should be peered."
}
