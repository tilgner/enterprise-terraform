//----------------------------------------------
// Locals
//----------------------------------------------
locals {
  member = flatten([
    for _, value in var.service_accounts : [
      for _, v in value.roles : {
        account_id    = value.account_id,
        display_name  = value.display_name,
        role          = v,
        friendly_role = replace(lower(split("/", v)[length(split("/", v)) - 1]), ".", "-"),
  }]])
  service_accounts = [
    for _, value in var.service_accounts : value if value.create_key == true
  ]
}

//----------------------------------------------
// Service Account
//----------------------------------------------
resource "google_service_account" "account" {
  for_each     = var.service_accounts
  project      = var.project
  account_id   = each.value.account_id
  display_name = each.value.display_name
}

//----------------------------------------------
// Service Account Key
//----------------------------------------------
resource "google_service_account_key" "key" {
  for_each = {
    for _, value in local.service_accounts : value.account_id => value
  }
  service_account_id = google_service_account.account[each.value.account_id].name
}

//----------------------------------------------
// IAM Role Binding
//----------------------------------------------
resource "google_project_iam_member" "member" {
  for_each = {
    for _, v in local.member : format("%s-%s", v.account_id, v.friendly_role) => v
  }
  project = var.project
  member  = format("serviceAccount:%s", google_service_account.account[each.value.account_id].email)
  role    = each.value.role
}