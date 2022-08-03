# provider "azurerm" {
#   # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
#   version = "=2.5.0"
#   features {}
# }
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.92.0"
    }
  }
   backend "azurerm" {
    resource_group_name = "rg_stat01"
    storage_account_name = "oelotmanstg02"
    container_name       = "blob02"
    key                  = "prod.terraform.tfstate"
    subscription_id      = "bac50807-6856-4963-a21f-181763093c18"
    tenant_id            = "49308f78-54b6-4e99-b47a-f03d84bdd855"
  }
}

provider "azurerm" {
    features {}
    use_msi = true
  # Configuration options
}
resource "azurerm_resource_group" "tf_test" {
  name     = "rg_test"
  location = "West Europe"
}

resource "azurerm_container_group" "tfcg_test" {
  name                = "weatherapi01"
  location            = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name
  ip_address_type     = "public"
  dns_name_label      = "weatherapi01oeo"
  os_type             = "Linux"

  container {
    name   = "ct001"
    image  = "otmane1990/weatherapi"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}
output "aaaaa" {
  value = azurerm_resource_group.tf_test.location #  type de ressource . Nom ressource terraform . paramettre rechrché 
}