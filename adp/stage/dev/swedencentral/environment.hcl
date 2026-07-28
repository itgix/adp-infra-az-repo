locals {
  environment = "stage"

  tags = {
    Environment = "stage"
    Criticality = "medium"
  }

  features = {
    aks        = true
    sql        = true
    lz_vending = true
  }
}
