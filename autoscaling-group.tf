resource "aws_autoscaling_group" "etcd" {
  name = "etcd"
  availability_zones = [ "us-west-2a" ]
  default_cooldown = 300
  desired_capacity = 3
  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingCapacity",
    "GroupPendingInstances",
    "GroupStandbyCapacity",
    "GroupStandbyInstances",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "GroupTotalInstances"
  ]
  health_check_grace_period = 300
  health_check_type = "EC2"
  max_size = 5
  metrics_granularity = "1Minute"
  min_size = 3
  mixed_instances_policy {
    instances_distribution {
      on_demand_allocation_strategy = "prioritized"
      on_demand_percentage_above_base_capacity = 70
      spot_allocation_strategy = "lowest-price"
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.etcd.id
        version = "$Latest"
      }
      override {
        instance_type = "t2.small"
        weighted_capacity = "1"
      }
      override {
        instance_type = "t2.medium"
        weighted_capacity = "2"
      }
    }
  }
  protect_from_scale_in = false
  vpc_zone_identifier = [ "subnet-aa880ccf" ]
}
