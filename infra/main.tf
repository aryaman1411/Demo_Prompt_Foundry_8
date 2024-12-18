Here is a basic example of how you can define these resources using Terraform. Please note that you will need to replace the placeholders with your actual values.

```hcl
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "<resource_group_name>"
  location = "<location>"
}

# Create an App Service Plan
resource "azurerm_app_service_plan" "plan" {
  name                = "<app_service_plan_name>"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create an App Service
resource "azurerm_app_service" "app" {
  name                = "<app_service_name>"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}

# Create an Azure SQL Database
resource "azurerm_sql_server" "server" {
  name                         = "<sql_server_name>"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "<admin_login>"
  administrator_login_password = "<admin_password>"
}

resource "azurerm_sql_database" "db" {
  name                = "<sql_database_name>"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.server.name
  location            = azurerm_resource_group.rg.location
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_bytes      = "1073741824"
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "<storage_account_name>"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Create an Azure CDN Profile
resource "azurerm_cdn_profile" "cdn" {
  name                = "<cdn_profile_name>"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

# Create an Azure CDN Endpoint
resource "azurerm_cdn_endpoint" "endpoint" {
  name                = "<cdn_endpoint_name>"
  profile_name        = azurerm_cdn_profile.cdn.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  origin_host_header  = azurerm_storage_account.storage.primary_blob_host
}

# Create an Azure Active Directory
resource "azuread_application" "app" {
  name = "<aad_app_name>"
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
}
```

This is a basic setup and you may need to adjust it according to your specific needs. For example, you may need to add more configurations to the resources, add more resources, or even remove some of the resources if they are not needed.