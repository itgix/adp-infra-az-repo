locals {
  null_source = "${get_repo_root()}/_null"

  # ---- Tenant-wide constants ----
  tenant_id                = "35e55793-1d03-4bb1-99a3-4888c2cda0e0"
  root_management_group_id = "Contoso"

  default_tags = {
    ManagedBy = "terragrunt"
    IaCRepo   = "alz-contoso-adp-infra"
  }

  enable_telemetry = false

  # ---- Dynamic lookups (safe to fail when read from catalog context) ----
  subscription_vars = try(read_terragrunt_config(find_in_parent_folders("subscription.hcl")), { locals = {} })
  region_vars       = try(read_terragrunt_config(find_in_parent_folders("region.hcl")), { locals = {} })

  location        = try(local.region_vars.locals.location, "")
  subscription_id = try(local.subscription_vars.locals.subscription_id, "")
}

generate "versions" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = "~> 4.57"
        }
      }
    }

    provider "azurerm" {
        features {}
        subscription_id      = "${local.subscription_id}"
        tenant_id            = "${local.tenant_id}"
        use_oidc             = true
        storage_use_azuread  = true
    }
EOF
}

remote_state {
  backend = "azurerm"
  config = {
    subscription_id      = "f7f8b016-64ca-4d42-afad-de91b2eae685"
    resource_group_name  = "rg-managed-dev-swedencentral"
    storage_account_name = "stcontosodevsc"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  try(local.subscription_vars.locals, {}),
  try(local.region_vars.locals, {}),
)
