# tf-mod-aws-vpc

This module creates a VPC in the given region, and one subnet pair (public/private) in the given availability zone.

This is a very basic module that I created for a very specific context, and one of my first experiments in writing Terraform modules. It's probably neither useful enough nor good enough for general use.

## Requirements

The following requirements are needed by this module:

- terraform (>= 0.13)

- aws (~> 3.15.0)

## Providers

The following providers are used by this module:

- aws (~> 3.15.0)

## Required Inputs

The following input variables are required:

### vpc\_name

Description: Name tag for the VPC

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### az

Description: AZ for the default subnets

Type: `string`

Default: `"a"`

### region

Description: AWS region for the VPC

Type: `string`

Default: `"eu-west-1"`

### vpc\_cidr\_block

Description: Private IP range for the VPC

Type: `string`

Default: `"10.0.0.0/16"`

## Outputs

The following outputs are exported:

### availability\_zone

Description: Availability zone (full name)

### az

Description: Availability zone (one letter)

### gateway\_id

Description: Id of the internet gateway for the VPC

### internet\_route\_table

Description: Id of the routing table (internet routing)

### main\_route\_table

Description: Id of the main routing table for the VPC

### private\_subnet\_id

Description: Id of the private subnet in this VPC

### private\_subnet\_ipv4\_range

Description: IPv4 address range of the private subnet in this VPC

### public\_subnet\_id

Description: Id of the public subnet in this VPC

### public\_subnet\_ipv4\_range

Description: IPv4 address range of the public subnet in this VPC

### public\_subnet\_ipv6\_range

Description: IPv6 address range of the public subnet in this VPC

### region

Description: Region in which the VPC will be created

### vpc\_id

Description: VPC id

### vpc\_ipv4\_cidr\_block

Description: IPv4 address range for the VPC in CIDR notation

### vpc\_ipv6\_cidr\_block

Description: IPv6 address range for the VPC in CIDR notation

### vpc\_name

Description: VPC name (value of the Name tag)

