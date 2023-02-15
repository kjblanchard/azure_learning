locals {
  domain_name = data.azuread_domains.default.domains.0.domain_name
  users       = csvdecode(file("${path.module}/data/users.csv"))
}


resource "azuread_user" "users" {
  for_each = { for user in local.users : format("%s%s%s",user.first_name,user.last_name,user.job_title) => user }
  user_principal_name = format(
    "%s%s-%s@%s",
    substr(lower(each.value.first_name), 0, 1),
    lower(each.value.last_name),
    random_pet.suffix.id,
    local.domain_name
  )
  password              = random_password.password.result
  force_password_change = true
  display_name          = "${each.value.first_name} ${each.value.last_name}"
  department            = each.value.department
  job_title             = each.value.job_title
  lifecycle {
    ignore_changes = [
      password
    ]
  }
  depends_on = [
    random_password.password
  ]
}
