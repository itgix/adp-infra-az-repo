locals {
  environment = "prod"

  tags = {
    Environment = "prod"
    Criticality = "high"
  }

  features = {
    aks        = true
    sql        = true
    lz_vending = true
  }
}
