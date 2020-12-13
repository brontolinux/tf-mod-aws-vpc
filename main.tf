/*
* # tf-mod-aws-vpc
*
* This module creates a VPC in the given region, and one subnet pair (public/private) in the given availability zone.
*
* This is a very basic module that I created for a very specific context, and one of my first experiments in writing Terraform modules. It's probably neither useful enough nor good enough for general use.
*/

########################################################################
# Locals
locals {
  availability_zone = "${var.region}${var.az}"

  # Shorten the VPC's IPv6 block variable
  vpc_ipv6_cidr_block = aws_vpc.this.ipv6_cidr_block
  vpc_ipv4_cidr_block = aws_vpc.this.cidr_block

  # Use cidrsubnet to take the VPC's IPv6 block (a /56), extend it by 8 bits
  # (thus, a /64) and return the first subnet (0 index)
  public_subnet_ipv6_cidr_block = cidrsubnet(local.vpc_ipv6_cidr_block, 8, 0)

  # Subnets are /24 (/16 + 8 bits)
  public_subnet_ipv4_cidr_block  = cidrsubnet(local.vpc_ipv4_cidr_block, 8, 0)
  private_subnet_ipv4_cidr_block = cidrsubnet(local.vpc_ipv4_cidr_block, 8, 1)
}

########################################################################
# Personal VPC #########################################################

resource "aws_vpc" "this" {
  cidr_block                       = var.vpc_cidr_block
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}.gateway"
  }
}

# Subnets ##############################################################
module "subnet_pair" {
  source = "git@github.com:brontolinux/tf-mod-aws-subnet-pair.git?ref=v1.0.0"

  vpc_id = aws_vpc.this.id
  region = var.region
  az = var.az

  pub_subnet_ipv4_cidr_block = local.public_subnet_ipv4_cidr_block
  pub_subnet_ipv6_cidr_block = local.public_subnet_ipv6_cidr_block
  pub_subnet_name = "${var.vpc_name}.public.default.${local.availability_zone}"
  pub_route_table = aws_route_table.internet.id

  priv_subnet_ipv4_cidr_block = local.private_subnet_ipv4_cidr_block
  priv_subnet_name = "${var.vpc_name}.private.default.${local.availability_zone}"
}
# Routing tables #######################################################

# Routes to Internet
resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}.internet"
  }
}

resource "aws_route" "internet_ipv4" {
  route_table_id         = aws_route_table.internet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route" "internet_ipv6" {
  route_table_id              = aws_route_table.internet.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.this.id
}

# Main route table for the VPC
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}.main"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.main.id
}

