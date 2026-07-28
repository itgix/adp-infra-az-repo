locals {
  environment = "dev"

  tags = {
    Environment = "dev"
    Criticality = "low"
  }

  features = {
    aks          = true
    sql          = true
    azure_policy = true
    lz_vending   = true
  }
}
