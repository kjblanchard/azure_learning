# Configure the Microsoft Azure Provider, use az login to generate temporary credentials.
provider "azurerm" {
  features {}
  alias = "core"
}

# Configure the Microsoft Azure AD Provider, use az login to generate temporary credentials.
provider "azuread" {
  alias = "core"
}