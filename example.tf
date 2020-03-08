provider "aws" {
  profile = "default"
  region  = "us-west-2"
  version = "~> 2.52"
}

resource "aws_key_pair" "example" {
    key_name   = "terraform"
    public_key = file("c:\\cygwin64\\home\\kazaa\\.ssh\\terraform.pub")
}

resource "aws_instance" "example" {
  ami                    = "ami-0b199ce4c7f1a6dd2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-00e4b365"]
  subnet_id              = "subnet-3fb46e48"
  key_name      = aws_key_pair.example.key_name
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("c:\\cygwin64\\home\\kazaa\\.ssh\\terraform")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}
