// see - https://www.terraform.io/docs/providers/aws/r/launch_template.html
resource "aws_launch_template" "etcd" {
  name = "etcd"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count = 4
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = true

  ebs_optimized = true

/*
  elastic_gpu_specifications {
    type = "test"
  }

  elastic_inference_accelerator {
    type = "eia1.medium"
  }

  // interesting, come back to this.  I don't think this is needed for this use case
  iam_instance_profile {
    name = "test"
  }
*/

  image_id = var.etcd.ami

  instance_initiated_shutdown_behavior = "terminate"

/*
  instance_market_options {
    market_type = "spot"
  }
*/

  instance_type = "t2.small"

  // definitely don't care about aki; would be leery if I did.  imagining weird scenario where I need to build a custom kernel for an application. :thinking_face:
//  kernel_id = "test"

  key_name = aws_key_pair.etcd.key_name

/* I do not want to be *that guy*
  license_specification {
    license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
  }
*/

  monitoring {
    enabled = true
  }

/* see - https://github.com/terraform-providers/terraform-provider-aws/issues/4570 */
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.kubernetes.id]
    subnet_id                   = aws_subnet.etcd.id
  }

  placement {
    availability_zone = "us-west-2a"
  }

  // really ... don't care
//  ram_disk_id = "test"

/* see - https://github.com/terraform-providers/terraform-provider-aws/issues/4570 */
//  vpc_security_group_ids = [aws_security_group.kubernetes.id]

/* don't really care about here; would tag for environments or departments, not for personal.
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }
*/

  // don't have any user_data, per se
//  user_data = filebase64("${path.module}/example.sh")
}
