variable "prometheus_workspace_alias" {
  description = "Alias for the Prometheus Workspace"
  type        = string
  default     = "gp-workspace" 
}

# variable "tags" {
#   description = "Tags to be applied to the AMP Workspace"
#   type        = map(string)
#   default     = local.tags
# }