variable "eks_cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
}

variable "eks_cluster_version" {
  description = "Version of the EKS Cluster"
  type        = string
}

variable "addon_version" {
  description = "Version of the EKS Addon"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Tags to be applied to the EKS Addon"
  type        = map(string)
  default     = {}
}

variable "cpu_limit" {
  description = "CPU limit for the ADOT addon"
  type        = string
  default     = ""
}

variable "memory_limit" {
  description = "Memory limit for the ADOT addon"
  type        = string
  default     = ""
}

variable "cpu_request" {
  description = "CPU request for the ADOT addon"
  type        = string
  default     = ""
}

variable "memory_request" {
  description = "Memory request for the ADOT addon"
  type        = string
  default     = ""
}

variable "adot_replica_count" {
  description = "Number of replicas for the ADOT addon"
  type        = number
  default     = 1
}