# Gets the default tenant from our credentials
data "azuread_domains" "default" {
  only_initial = true
}

resource "random_pet" "suffix" {
  length = 2
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}