resource "azuread_group" "c" {
  display_name     = "C-Suite"
  security_enabled = true
  timeouts {
    create = "10m"
  }
  #   Commented out due to license
  #   dynamic_membership {
  #     enabled = true
  #     rule    = "user.department -eq \"C\""
  #   }
}

# resource "azuread_group_member" "c" {
#   for_each         = { for user in local.users : format("%s%s%s", user.first_name, user.last_name, user.job_title) => user if user.department == "C" }
#   member_object_id = azuread_user.users[each.key].id
#   group_object_id  = azuread_group.c.id
# }

resource "azuread_group" "partners" {
  display_name     = "Partners"
  security_enabled = true
  timeouts {
    create = "10m"
  }
  #   Commented out due to license
  #   dynamic_membership {
  #     enabled = true
  #     rule    = "user.jobTitle -contains \"[Pp]artner\""
  #   }
}

# resource "azuread_group_member" "partners" {
#   for_each         = { for user in local.users : format("%s%s%s", user.first_name, user.last_name, user.job_title) => user if length(regexall("[Pp]artner", user.job_title)) > 0 }
#   member_object_id = azuread_user.users[each.key].id
#   group_object_id  = azuread_group.c.id
# }
