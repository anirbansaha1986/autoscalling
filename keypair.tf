resource "aws_key_pair" "etcd" {
  key_name   = "etcd"
  public_key = file("c:\\cygwin64\\home\\kazaa\\.ssh\\terraform.pub")
}
