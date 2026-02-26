# For Input variables

variable "project" {
  description = "Project name prefix"
  type        = string
  default     = "infra"
}
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}
