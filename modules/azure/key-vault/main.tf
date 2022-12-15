//------------------------------------
// Locals
//------------------------------------
locals {
  key_vault_access_policy = {
    for _, value in flatten([
      for key, value in var.key_vaults : [
        for _, v in value.access : {
          tenant_id               = value.tenant_id,
          key_vault_id            = key,
          object_id               = v.object_id,
          key_permissions         = v.key_permissions,
          secret_permissions      = v.secret_permissions,
          certificate_permissions = v.certificate_permissions
    }]]) : value.object_id => value
  }
}

//------------------------------------
// Key Vault
//------------------------------------
resource "azurerm_key_vault" "key_vault" {
  for_each                      = var.key_vaults
  name                          = each.value.name
  location                      = each.value.location
  resource_group_name           = each.value.resource_group_name
  tenant_id                     = each.value.tenant_id
  enabled_for_disk_encryption   = each.value.enabled_for_disk_encryption
  sku_name                      = each.value.sku_name
  soft_delete_retention_days    = each.value.soft_delete_retention_days
  purge_protection_enabled      = each.value.purge_protection_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  tags                          = each.value.tags
}

//------------------------------------
// Key Vault Access Policy
//------------------------------------
resource "azurerm_key_vault_access_policy" "access_policy" {
  for_each                = local.key_vault_access_policy
  key_vault_id            = azurerm_key_vault.key_vault[each.value.key_vault_id].id
  tenant_id               = each.value.tenant_id
  object_id               = each.value.object_id
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
}