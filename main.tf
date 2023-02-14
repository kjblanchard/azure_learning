module "billing_setup" {
    source = "./modules/billing"
    default_emails = var.billing.default_emails
    providers = {
      azurerm = azurerm.core
     }

}