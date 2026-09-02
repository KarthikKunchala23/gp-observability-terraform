output "adot_addon_id" {
  description = "ADOT EKS Addon ID"
  value       = aws_eks_addon.adot.id
}

output "adot_addon_version" {
  description = "ADOT EKS Addon Version"
  value       = aws_eks_addon.adot.addon_version
}

output "prometheus_node_exporter_addon_id" {
  description = "Prometheus Node Exporter EKS Addon ID"
  value       = aws_eks_addon.prometheus_node_exporter.id
}

output "prometheus_node_exporter_addon_version" {
  description = "Prometheus Node Exporter EKS Addon Version"
  value       = aws_eks_addon.prometheus_node_exporter.addon_version
}

output "kube_state_metrics_addon_id" {
  description = "Kube State Metrics EKS Addon ID"
  value       = aws_eks_addon.kube_state_metrics.id
}

output "kube_state_metrics_version" {
  description = "Kube State Metrics EKS Addon Version"
  value       = aws_eks_addon.kube_state_metrics.addon_version
}