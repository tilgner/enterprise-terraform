//------------------------------------
// Key Vault
//------------------------------------
variable "key_vaults" {
  description = <<EOF
    name                          (Required) - Name of the key vault
    location                      (Required) - Location of the key vault
    resource_group_name           (Required) - Name of the key vault's resource group
    tenant_id                     (Required) - Azure Active Directory tenant ID
    enabled_for_disk_encryption   (Optional) - Whether Azure Disk Encryption is permitted to retrieve secrets
    sku_name                      (Required) - SKU to use for the key vault (e.g. 'standard')
    soft_delete_retention_days    (Optional) - Number of days items should be retained once soft-deleted (e.g. 7 - 90)
    purge_protection_enabled      (Optional) - Whether to enable purge protection
    public_network_access_enabled (Optional) - Whether to enable public network access
    tags                          (Optional) - Tags to attach to the key vault
    access                        (Optional) - Object IDs (i.e. principals) to include in the key vault's access policy
      object_id                   (Required) - Principal object ID
      key_permissions             (Optional) - Principal key permissions
      secret_permissions          (Optional) - Principal secret permissions
      certificate_permissions     (Optional) - Principal certificate permissions
  EOF
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    tenant_id                     = string
    enabled_for_disk_encryption   = bool
    sku_name                      = string
    soft_delete_retention_days    = string
    purge_protection_enabled      = bool
    public_network_access_enabled = bool
    access = list(object({
      object_id               = string
      key_permissions         = list(string)
      secret_permissions      = list(string)
      certificate_permissions = list(string)
    }))
    tags = map(string)
  }))
}