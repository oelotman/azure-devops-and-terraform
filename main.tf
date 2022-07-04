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
}

provider "azurerm" {
    features {}
    use_msi = true
  # Configuration options
  backend "azurerm" {
    storage_account_name = "oelotmanstg01"
    container_name       = "blob01"
    key                  = "prod.terraform.tfstate"
    subscription_id      = "d9461c87-de3b-401c-9a99-0cfa3fabee67"
    tenant_id            = "76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61"
  }
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