data "azurerm_subscription" "current" {}

locals {
  billing_emails = concat(var.additional_emails, var.default_emails)
}

resource "azurerm_consumption_budget_subscription" "example" {
  name            = "MainBillingAlert"
  subscription_id = data.azurerm_subscription.current.id

  amount     = 10
  time_grain = "Monthly"

  time_period {
    start_date = "2023-02-01T00:00:00Z"
    end_date   = "2025-02-01T00:00:00Z"
  }


  notification {
    enabled   = true
    threshold = 10.0
    operator  = "EqualTo"

    contact_emails = local.billing_emails

    contact_roles = [
      "Owner",
    ]
  }

  notification {
    enabled        = true
    threshold      = 10.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = local.billing_emails
  }
}
