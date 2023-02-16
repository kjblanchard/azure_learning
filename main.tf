module "billing_setup" {
  source         = "./modules/billing"
  default_emails = var.billing.default_emails
  providers = {
    azurerm = azurerm.core
  }

}

module "azure_ad_setup" {
  source = "./modules/azure_ad"
  providers = {
    azuread = azuread.core
  }

}

module "virtual_network_setup" {
  for_each = var.virtual_networks
  cidr     = each.value
  source   = "./modules/virtual_network"
  providers = {
    azurerm = azurerm.core
  }
}

module "transit_setup" {
  cidr          = var.transit_virtual_network
  peering_cidrs = var.virtual_networks
  created_virtual_networks = module.virtual_network_setup
  source        = "./modules/transit_network"
  providers = {
    azurerm = azurerm.core
  }
  depends_on = [
    module.virtual_network_setup
  ]
}


