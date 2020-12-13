# Global information
output "region" {
  description = "Region in which the VPC will be created"
  value = var.region
}

output "az" {
  description = "Availability zone (one letter)"
  value = var.az
}

output "availability_zone" {
  description = "Availability zone (full name)"
  value = local.availability_zone
}

# VPC information
output "vpc_id" {
  description = "VPC id"
  value = aws_vpc.this.id
}

output "vpc_name" {
  description = "VPC name (value of the Name tag)"
  value = var.vpc_name
}

output "vpc_ipv4_cidr_block" {
  description = "IPv4 address range for the VPC in CIDR notation"
  value = local.vpc_ipv4_cidr_block
}

output "vpc_ipv6_cidr_block" {
  description = "IPv6 address range for the VPC in CIDR notation"
  value = local.vpc_ipv6_cidr_block
}

output "gateway_id" {
  description = "Id of the internet gateway for the VPC"
  value = aws_internet_gateway.this.id
}

output "main_route_table" {
  description = "Id of the main routing table for the VPC"
  value = aws_route_table.main.id
}

output "internet_route_table" {
  description = "Id of the routing table (internet routing)"
  value = aws_route_table.internet.id
}

# Subnets information
output "public_subnet_id" {
  description = "Id of the public subnet in this VPC"
  value = module.subnet_pair.public_subnet_id
}

output "public_subnet_ipv4_range" {
  description = "IPv4 address range of the public subnet in this VPC"
  value = module.subnet_pair.public_subnet_ipv4_range
}

output "public_subnet_ipv6_range" {
  description = "IPv6 address range of the public subnet in this VPC"
  value = module.subnet_pair.public_subnet_ipv6_range
}

output "private_subnet_id" {
  description = "Id of the private subnet in this VPC"
  value = module.subnet_pair.private_subnet_id
}

output "private_subnet_ipv4_range" {
  description = "IPv4 address range of the private subnet in this VPC"
  value = module.subnet_pair.private_subnet_ipv4_range
}

