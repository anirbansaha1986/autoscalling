resource "aws_subnet" "subnet_2a" {
  assign_ipv6_address_on_creation = false
  availability_zone = "us-west-2a"
  cidr_block = "172.31.32.0/20"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.default.id
}
resource "aws_subnet" "subnet_2b" {
  assign_ipv6_address_on_creation = false
  availability_zone = "us-west-2b"
  cidr_block = "172.31.16.0/20"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.default.id
}
resource "aws_subnet" "subnet_2c" {
  assign_ipv6_address_on_creation = false
  availability_zone = "us-west-2c"
  cidr_block = "172.31.0.0/20"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.default.id
}
resource "aws_subnet" "subnet_2d" {
  assign_ipv6_address_on_creation = false
  availability_zone = "us-west-2d"
  cidr_block = "172.31.48.0/20"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.default.id
}
resource "aws_network_acl" "default" {
  egress {
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    icmp_code = 0
    icmp_type = 0
    protocol = "-1"
    rule_no = 100
    to_port = 0
  }
  ingress {
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    icmp_code = 0
    icmp_type = 0
    ipv6_cidr_block = ""
    protocol = "-1"
    rule_no = 100
    to_port = 0
  }
  subnet_ids = [
    aws_subnet.subnet_2a.id,
    aws_subnet.subnet_2b.id,
    aws_subnet.subnet_2c.id,
    aws_subnet.subnet_2d.id
  ]
  vpc_id = aws_vpc.default.id
}
resource "aws_internet_gateway" "default" {
}
resource "aws_route_table" "default" {
  route {
    cidr_block = "0.0.0.0/0"
    egress_only_gateway_id = ""
    gateway_id = aws_internet_gateway.default.id
    instance_id = ""
    ipv6_cidr_block = ""
    nat_gateway_id = ""
    network_interface_id = ""
    transit_gateway_id = ""
    vpc_peering_connection_id = ""
  }
  vpc_id = aws_vpc.default.id
}
resource "aws_security_group" "default" {
  description = "default VPC security group"
  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    description = ""
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  }
  ingress {
    cidr_blocks = [
      "73.181.16.223/32"
    ]
    description = ""
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 22
  }
  ingress {
    cidr_blocks = [
      "73.181.16.223/32"
    ]
    description = ""
    from_port = 443
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 443
  }
  ingress {
    cidr_blocks = [
      "73.181.16.223/32"
    ]
    description = ""
    from_port = 80
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 80
  }
  ingress {
    cidr_blocks = []
    description = ""
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = [ aws_security_group.default.id ]
    self = true
    to_port = 0
  }
  revoke_rules_on_delete = false
  timeouts {
    create = null
    delete = null
  }
  vpc_id = aws_vpc.default.id
}
resource "aws_vpc_dhcp_options" "default" {
  domain_name = "us-west-2.compute.internal"
  domain_name_servers = [ "AmazonProvidedDNS" ]
  netbios_name_servers = null
  netbios_node_type = null
  ntp_servers = null
}
resource "aws_vpc" "default" {
  assign_generated_ipv6_cidr_block = false
  cidr_block = "172.31.0.0/16"
//  default_network_acl_id = aws_network_acl.default.id
//  default_route_table_id = aws_route_table.default.id
//  default_security_group_id = aws_security_group.default.id
//  dhcp_options_id = aws_vpc_dhcp_options.default.id
  enable_classiclink = false
  enable_classiclink_dns_support = false
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
//  main_route_table_id = aws_route_table.default.id
}
