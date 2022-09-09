resource "azurerm_resource_group" "aks_rg" {
  name = "${var.resource_group_name}-${var.environment}"
  location = var.location
}

data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.aks_rg.location
  include_preview = false
}

resource "azurerm_log_analytics_workspace" "insights" {
  name = "${var.environment}-logs-${random_pet.aksrandom.id}"
  location = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  retention_in_days = 30
}

resource "azuread_group" "aks_administrators" {
  display_name = "${azurerm_resource_group.aks_rg.name}-${var.environment}-administrators"
  description = "Azure AKS administrators for the ${azurerm_resource_group.aks_rg.name}-${var.environment} cluster"
  security_enabled = true
}