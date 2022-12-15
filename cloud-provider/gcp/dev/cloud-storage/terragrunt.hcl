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
  source = "../../../..//modules/gcp/cloud-storage"
}

//----------------------------------------------
// Variable Configuration
//----------------------------------------------
inputs = {
  buckets = yamldecode(file("../../../../config/gcp/cloud-storage/buckets.yaml"))
}
