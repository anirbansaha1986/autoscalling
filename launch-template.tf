// see - https://www.terraform.io/docs/providers/aws/r/launch_template.html
resource "aws_launch_template" "etcd" {
  name = "etcd"

  block_device_mappings {
    device_name = "/dev/sdb"

    ebs {
      volume_size = 20
      delete_on_termination = true
      volume_type = "standard"
    }
  }

  disable_api_termination = true

  ebs_optimized = false

  image_id = var.etcd.ami

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.small"

  key_name = aws_key_pair.etcd.key_name

  monitoring {
    enabled = true
  }

/* see - https://github.com/terraform-providers/terraform-provider-aws/issues/4570 */
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.default.id]
    subnet_id                   = aws_subnet.subnet_2a.id
  }

  placement {
    group_name = aws_placement_group.etcd.name
  }
}
