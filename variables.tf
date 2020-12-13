variable "region" {
  default     = "eu-west-1"
  description = "AWS region for the VPC"
}

variable "az" {
  default     = "a"
  description = "AZ for the default subnets"
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "Private IP range for the VPC"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type = string
}

