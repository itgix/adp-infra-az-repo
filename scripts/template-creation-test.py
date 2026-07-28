import json
from cookiecutter.main import cookiecutter

test_context = {
    "project_slug":          "alz-test-adp-infra",
    "client_name":           "test",
    "tenant_id":             "11111111-0000-0000-0000-000000000000",
    "subscription_id":       "22222222-0000-0000-0000-000000000000",
    "state_resource_group":  "rg-test-state",
    "state_storage_account": "sttest",
    "state_container":       "tfstate",
    "env_to_region_map": json.dumps({
        "dev": {
            "swedencentral": {
                "location_short":            "sc",
                "create_lz_vending":         True,
                "create_aks":                True,
                "create_postgres":           True,
                "create_azure_policy":       True,
                "vpa_enabled":               True,
                "address_space":             "10.20.0.0/16",
                "aks_subnet_cidr":           "10.20.0.0/22",
                "kubernetes_version":        "1.35.5",
                "aks_node_vm_size":          "Standard_D2s_v3",
                "aks_node_min_count":        "2",
                "aks_node_max_count":        "5",
                "aks_private_dns_zone":      "",
                "aks_admin_group_object_id": "33333333-0000-0000-0000-000000000000",
                "aks_private_cluster":       False,
                "aad_enable_azure_rbac":     True,
                "aad_managed":               True,
                "network_plugin":            "azure",
                "network_plugin_mode":       "overlay",
                "sku_tier":                  "Free",
            }
        },
        "prod": {
            "swedencentral": {
                "location_short":            "sc",
                "create_lz_vending":         False,
                "create_aks":                False,
                "create_postgres":           False,
                "create_azure_policy":       False,
                "vpa_enabled":               False,
                "address_space":             "10.30.0.0/16",
                "aks_subnet_cidr":           "10.30.0.0/22",
                "kubernetes_version":        "1.35.5",
                "aks_node_vm_size":          "Standard_D4s_v3",
                "aks_node_min_count":        "3",
                "aks_node_max_count":        "10",
                "aks_private_dns_zone":      "",
                "aks_admin_group_object_id": "44444444-0000-0000-0000-000000000000",
                "aks_private_cluster":       False,
                "aad_enable_azure_rbac":     False,
                "aad_managed":               False,
            }
        }
    })
}

output_dir = "./cookiecutter-test"

cookiecutter(
    "../../adp-az-tf-envtemplate-standard",
    no_input=True,
    extra_context=test_context,
    output_dir=output_dir,
    overwrite_if_exists=True,
)

print(f"Generated at {output_dir}/alz-test-adp-infra")
