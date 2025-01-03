data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault_ci_cd_sample" {
  name                          = "kvcicdsample"
  location                      = azurerm_resource_group.key_vault_ci_cd_sample.location
  resource_group_name           = azurerm_resource_group.key_vault_ci_cd_sample.name
  enabled_for_disk_encryption   = true
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  enable_rbac_authorization     = true

  sku_name = "standard"


  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = ["5.198.70.47"]
  }
}

resource "azurerm_role_assignment" "key_vault_ci_cd_sample" {
    scope                = azurerm_key_vault.key_vault_ci_cd_sample.id
    role_definition_name = "Key Vault Administrator"
    principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_key" "key_vault_ci_cd_sample" {
  name         = "kv-ci-cd-sample-key"
  key_vault_id = azurerm_key_vault.key_vault_ci_cd_sample.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P31D"
  }

  depends_on = [ azurerm_role_assignment.key_vault_ci_cd_sample ]
}