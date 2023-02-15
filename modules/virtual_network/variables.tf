
variable "cidr" {
  description = "The cidr for the vnet, and it's subnets"
  type = object({
    name     = string
    cidr     = list(string)
    location = string
    subnets  = map(string)
    tags     = map(string)

  })

}
