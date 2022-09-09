resource "azurerm_kubernetes_cluster" "aks_cluster" {
  dns_prefix = "${azurerm_resource_group.aks_rg.name}"
  location = azurerm_resource_group.aks_rg.location
  name = "${azurerm_resource_group.aks_rg.name}-cluster"
  resource_group_name = azurerm_resource_group.aks_rg.name
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"
}