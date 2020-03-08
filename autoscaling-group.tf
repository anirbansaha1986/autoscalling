provider "aws" {
  profile = "default"
  region  = "us-west-2"
  version = "~> 2.52"
}

/*
resource "aws_launch_template" "large" {
  name_prefix = "large"
  image_id = "${data.aws_ami.example.id}"
  instance_type = "t2.large"
}
resource "aws_launch_template" "medium" {
  name_prefix = "medium"
  image_id = "${data.aws_ami.example.id}"
  instance_type = "t2.medium"
}
resource "aws_launch_template" "small" {
  name_prefix = "small"
  image_id = "${data.aws_ami.example.id}"
  instance_type = "t2.small"
}
*/
resource "aws_placement_group" "etcd" {
  name     = "etcd_placement_group"
  strategy = "partition"
}
resource "aws_autoscaling_group" "etcd" {
  availability_zones = var.availability_zones
  desired_capacity   = var.etcd.desired
  max_size           = var.etcd.max
  min_size           = var.etcd.min

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.etcd.id
        version = aws_launch_template.etcd.latest_version
      }

      override {
        instance_type = "t2.medium"
        weighted_capacity = "2"
      }

      override {
        instance_type = "t2.large"
        weighted_capacity = "3"
      }

    }

    instances_distribution {
      on_demand_base_capacity = 3
    }
  }
}
