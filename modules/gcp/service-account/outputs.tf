//----------------------------------------------
// Service Account Emails
//----------------------------------------------
output "service_account_emails" {
  description = "Email of the created service accounts"
  value       = { for key, value in google_service_account.account : key => value.email }
}

//----------------------------------------------
// Service Account Keys
//----------------------------------------------
output "service_account_keys" {
  description = "Email of the created service accounts"
  value       = { for key, value in google_service_account_key.key : key => value.private_key }
  sensitive   = true
}