# Datasource: To get default EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "cert_manager_default" {
  addon_name         = "cert-manager"
  kubernetes_version = var.eks_cluster_version
}

# Datasource: To get latest EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "cert_manager_latest" {
  addon_name         = "cert-manager"
  kubernetes_version = var.eks_cluster_version
  most_recent        = true
}

# Datasource: To get default EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "prometheus_node_exporter_default" {
  addon_name         = "prometheus-node-exporter"
  kubernetes_version = var.eks_cluster_version
}

# Datasource: To get latest EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "prometheus_node_exporter_latest" {
  addon_name         = "prometheus-node-exporter"
  kubernetes_version = var.eks_cluster_version
  most_recent        = true
}

# Datasource: To get default EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "adot_default" {
  addon_name         = "adot"
  kubernetes_version = var.eks_cluster_version
}

# Datasource: To get latest EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "adot_latest" {
  addon_name         = "adot"
  kubernetes_version = var.eks_cluster_version
  most_recent        = true
}

# Datasource: To get default EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "kube_state_metrics_default" {
  addon_name         = "kube-state-metrics"
  kubernetes_version = var.eks_cluster_version
}

# Datasource: To get latest EKS addon version compatible with EKS cluster version
data "aws_eks_addon_version" "kube_state_metrics_latest" {
  addon_name         = "kube-state-metrics"
  kubernetes_version = var.eks_cluster_version
  most_recent        = true
}

# cert-manager EKS Addon (Prerequisite for ADOT)
resource "aws_eks_addon" "cert_manager" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "cert-manager"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version               = var.addon_version == "latest" ? data.aws_eks_addon_version.cert_manager_latest.version : data.aws_eks_addon_version.cert_manager_default.version
  tags = var.tags
}

# EKS Add-on: AWS Distro for OpenTelemetry (ADOT)
resource "aws_eks_addon" "adot" {
  # Cert Manager should be installed and ready before adot eks addon
  depends_on = [aws_eks_addon.cert_manager]  
  cluster_name  = var.eks_cluster_name
  addon_name    = "adot"
  addon_version = var.addon_version == "latest" ? data.aws_eks_addon_version.adot_latest.version : data.aws_eks_addon_version.adot_default.version
  
  # Configuration for the addon
  configuration_values = jsonencode({
    manager = {
      resources = {
        limits = {
          cpu    = var.cpu_limit != "" ? var.cpu_limit : "500m"
          memory = var.memory_limit != "" ? var.memory_limit : "256Mi"
        }
        requests = {
          cpu    = var.cpu_request != "" ? var.cpu_request : "250m"
          memory = var.memory_request != "" ? var.memory_request : "128Mi"
        }
      }
    }
    replicaCount = var.adot_replica_count != "" ? var.adot_replica_count : 1
  })
  
  # Conflict resolution
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags = var.tags
}


# EKS Add-on: Prometheus Node Exporter 
resource "aws_eks_addon" "prometheus_node_exporter" {
  cluster_name  = var.eks_cluster_name
  addon_name    = "prometheus-node-exporter"
  addon_version = var.addon_version == "latest" ? data.aws_eks_addon_version.prometheus_node_exporter_latest.version : data.aws_eks_addon_version.prometheus_node_exporter_default.version
  # Conflict resolution
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags = var.tags
}

# EKS Add-on: Kube State Metrics
resource "aws_eks_addon" "kube_state_metrics" {
  cluster_name  = var.eks_cluster_name
  addon_name    = "kube-state-metrics"
  addon_version = var.addon_version == "latest" ? data.aws_eks_addon_version.kube_state_metrics_latest.version : data.aws_eks_addon_version.kube_state_metrics_default.version
  # Conflict resolution
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags = var.tags
}