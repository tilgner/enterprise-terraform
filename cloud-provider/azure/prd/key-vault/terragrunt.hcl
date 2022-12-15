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
  source = "../../../..//modules/azure/key-vault"
}

//----------------------------------------------
// Variable Configuration
//----------------------------------------------
inputs = {
  key_vaults = yamldecode(file("../../../../config/azure/key-vault/key-vaults.yaml"))
}
