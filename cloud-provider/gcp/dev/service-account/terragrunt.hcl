//----------------------------------------------
// Terragrunt Configuration
//----------------------------------------------
include "root" {
  path = find_in_parent_folders()
}

//----------------------------------------------
// Module Configuration
//----------------------------------------------
terraform {
  source = "../../../..//modules/gcp/service-account"
}

//----------------------------------------------
// Variable Configuration
//----------------------------------------------
inputs = {
  service_accounts = yamldecode(file("../../../../config/gcp/service-account/dev.yaml"))
}
