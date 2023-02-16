locals {
  location            = var.cidr.location
  resource_group_name = "transit_resources"
  transit_name        = "supergoon-transit"
}
resource "azurerm_resource_group" "transit_resource_group" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_wan" "transit_virtual_wan" {
  name                = local.transit_name
  resource_group_name = azurerm_resource_group.transit_resource_group.name
  location            = local.location
}

resource "azurerm_virtual_hub" "virtual_hub" {
  name                = format("%s-virtualhub", local.transit_name)
  resource_group_name = azurerm_resource_group.transit_resource_group.name
  location            = local.location
  virtual_wan_id      = azurerm_virtual_wan.transit_virtual_wan.id
  address_prefix      = var.cidr.cidr[0]
}


resource "azurerm_virtual_hub_connection" "hub_connection" {
  for_each                  = var.created_virtual_networks
  name                      = format("%s-transit-connection", each.value.network.name)
  virtual_hub_id            = azurerm_virtual_hub.virtual_hub.id
  remote_virtual_network_id = each.value.network.id
}

resource "azurerm_virtual_hub_route_table" "example" {
  name           = format("%s-route-table", local.transit_name)
  virtual_hub_id = azurerm_virtual_hub.virtual_hub.id
  labels         = ["label1"]

  dynamic "route" {
    for_each = var.created_virtual_networks
    content {
      name              = format("%s-route", route.key)
      destinations_type = "CIDR"
      destinations      = route.value.network.address_space
      next_hop_type     = "ResourceId"
      next_hop          = azurerm_virtual_hub_connection.hub_connection[route.key].id
    }
  }
}
