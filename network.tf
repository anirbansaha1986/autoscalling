resource "aws_vpc" "kubernetes" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
}
resource "aws_subnet" "etcd" {
  vpc_id     = aws_vpc.kubernetes.id
  cidr_block = "10.0.1.0/24"
}
resource "aws_subnet" "kubernetes" {
  vpc_id     = aws_vpc.kubernetes.id
  cidr_block = "10.0.2.0/24"
}
resource "aws_security_group" "kubernetes" {
  name = "kubernetes-sg"
  description = "allow inbound ssh"
  vpc_id = aws_vpc.kubernetes.id

  ingress {
    description = "ssh into vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.kubernetes.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
