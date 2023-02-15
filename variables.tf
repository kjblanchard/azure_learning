variable "billing" {
  type = object({
    default_emails = list(string)

    }
  )
  description = "All variables related to billing information should be stored here."
}


variable "virtual_networks" {
  type = map(object({
    name = string
    cidr = list(string)
    location = string
    subnets = map(string)
    tags = map(string)

  }))
  description = "All virtual networks/subnets that need to be created should be stored here."
}

