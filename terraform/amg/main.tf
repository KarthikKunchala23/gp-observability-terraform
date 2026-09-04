# AMAZON MANAGED GRAFANA WORKSPACE
resource "aws_grafana_workspace" "main" {
  name                     = "${var.grafana_workspace_alias}-amg"
  description              = "Grafana workspace for ${var.grafana_workspace_alias} EKS cluster monitoring"
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]  # AWS Identity Center
  permission_type          = "CUSTOMER_MANAGED"
  role_arn                 = aws_iam_role.amg.arn

  # Data sources that Grafana can query
  data_sources = ["PROMETHEUS", "CLOUDWATCH", "XRAY"]
  region = local.region

  # Notification destinations
  notification_destinations = ["SNS"]


  vpc_configuration {
    subnet_ids = ["subnet-0a7ac9aa78fb1ee4a", "subnet-01c4a6cf319c2625d"]
    security_group_ids = ["sg-0faec10167c2a64d2"]
  }

  # Workspace configuration
  configuration = jsonencode({
    plugins = {
      pluginAdminEnabled = true
    }
    unifiedAlerting = {
      enabled = true
    }
  })
  tags = local.tags
}