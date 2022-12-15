//----------------------------------------------
// General
//----------------------------------------------
variable "project" {
  description = "Project ID"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
}

//----------------------------------------------
// Service Account
//----------------------------------------------
variable "service_accounts" {
  description = <<EOF
    account_id   (Required) - Stable and unique service account ID
    display_name (Optional) - Display name for the service account 
    create_key   (Optional) - Whether to create a key for the service account
    role         (Optional) - IAM Role to be assigned to the service account
  EOF
  type = map(object({
    account_id   = string
    display_name = string
    create_key   = bool
    roles        = list(string)
  }))
}