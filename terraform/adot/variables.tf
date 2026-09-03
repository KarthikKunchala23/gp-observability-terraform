variable "eks_cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = data.aws_eks_cluster.this.name
}

variable "eks_cluster_version" {
  description = "Version of the EKS Cluster"
  type        = string
  default     = data.aws_eks_cluster.this.version
}

variable "addon_version" {
  description = "Version of the EKS Addon"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Tags to be applied to the EKS Addon"
  type        = map(string)
  default     = local.tags
}

variable "cpu_limit" {
  description = "CPU limit for the ADOT addon"
  type        = string
  default     = "500m"
}

variable "memory_limit" {
  description = "Memory limit for the ADOT addon"
  type        = string
  default     = "512Mi"
}

variable "cpu_request" {
  description = "CPU request for the ADOT addon"
  type        = string
  default     = "250m"
}

variable "memory_request" {
  description = "Memory request for the ADOT addon"
  type        = string
  default     = "512Mi"
}

variable "adot_replica_count" {
  description = "Number of replicas for the ADOT addon"
  type        = number
  default     = 1
}