resource "azurerm_resource_group" "virtual_network_resource_group" {
  name     = format("%s-resource-group", var.cidr.name)
  location = var.cidr.location
}

resource "azurerm_network_security_group" "virtual_network_security_group" {
  name                = format("%s-security-group", var.cidr.name)
  location            = var.cidr.location
  resource_group_name = azurerm_resource_group.virtual_network_resource_group.name
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = format("%s-virtual-network", var.cidr.name)
  location            = var.cidr.location
  resource_group_name = azurerm_resource_group.virtual_network_resource_group.name
  address_space       = var.cidr.cidr

  dynamic "subnet" {
    for_each = var.cidr.subnets
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }
  tags = merge(var.cidr.tags, {
    createdBy = "terraform"
    owner     = "core"
  })
}


# var.cidrs

# prod = {
#   cidr     = ["10.10.10.0/24"]
#   location = "us-east"
#   subnets = {
#     PrivateA = "10.10.10.0/26"
#     PrivateB = "10.10.10.64/26"
#     PublicA  = "10.10.10.128/26"
#     PublicB  = "10.10.10.190/26"
#   }
#   tags = {
#     environment = "prod"
#     superman    = "nou"
#   }
# }
