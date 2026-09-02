variable "grafana_workspace_alias" {
  description = "Alias for the Grafana Workspace"
  type        = string
}

variable "grafana_workspace_role_arn" {
  description = "Role ARN for the Grafana Workspace"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the AMG Workspace"
  type        = map(string)
  default     = {}
}