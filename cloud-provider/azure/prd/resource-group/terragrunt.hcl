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
  source = "../../../..//modules/azure/resource-group"
}

//----------------------------------------------
// Variable Configuration
//----------------------------------------------
inputs = {
  resource_groups = yamldecode(file("../../../../config/azure/resource-group/prd.yaml"))
}
