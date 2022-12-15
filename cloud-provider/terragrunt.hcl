//----------------------------------------------
// Locals
//----------------------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

//----------------------------------------------
// Backend Configuration
//----------------------------------------------
remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    project              = "enterprise-terraform-project"
    location             = "eu"
    bucket               = "enterprise-terraform-remote-state"
    prefix               = "${path_relative_to_include()}/terraform.tfstate"
    skip_bucket_creation = true
  }
}

//----------------------------------------------
// Provider Configuration
//----------------------------------------------
generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
    provider "google" {
      region  = "europe-west3"
      project = var.project
    }
    provider "azurerm" {
      features {}
   }
  EOF
}

//----------------------------------------------
// Version Configuration
//----------------------------------------------
generate "version" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        google = {
          source  = "hashicorp/google"
          version = "~>4"
        }
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "~>3"
        }
      }
    } 
  EOF
}

//----------------------------------------------
// Variable Configuration
//----------------------------------------------
inputs = {
  labels = {
    "managed_by" = "terraform"
  }
  location    = "europe-west3"
  project     = local.env_vars.locals.project
  environment = local.env_vars.locals.environment
}
