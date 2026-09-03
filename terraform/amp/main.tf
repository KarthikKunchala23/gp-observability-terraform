# Amazon Managed Service for Prometheus Workspace
resource "aws_prometheus_workspace" "amp" {
  alias = "${var.prometheus_workspace_alias}-amp"  
  tags = var.tags
}