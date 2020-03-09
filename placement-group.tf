resource "aws_placement_group" "etcd" {
  name = "etcd"
  strategy = "partition"
}
