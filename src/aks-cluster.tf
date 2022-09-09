resource "azurerm_kubernetes_cluster" "aks_cluster" {
  dns_prefix = "${azurerm_resource_group.aks_rg.name}"
  location = azurerm_resource_group.aks_rg.location
  name = "${azurerm_resource_group.aks_rg.name}-cluster"
  resource_group_name = azurerm_resource_group.aks_rg.name
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"

  default_node_pool {
    name = "systempool"
    vm_size = "Standard_DS2_v2"
    orquestration_version = data.azurerm_kubernetes_service_versions.current.latest_version
    availability_zones = [1, 2, 3]
    enable_auto_scaling = true
    max_count = 3
    min_count = 1
    os_disk_size_gb = 30
    type = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "environment" = var.environment
      "nodepoolos" = "linux"
      "app" = "system-apps"
    }
    tags = {
      "nodepool-type" = "system"
      "environment" = var.environment
      "nodepoolos" = "linux"
      "app" = "system-apps"
    }
  }
}