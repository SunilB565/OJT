provider "aws" {
  region = "us-west-2" # Change this to your desired AWS region
}

variable "base_ami" {}

resource "aws_launch_configuration" "OJT_launch_config" {
  name = "OJT-launch-config"
  
  image_id = var.base_ami
  instance_type = "t2.micro" # Choose an appropriate instance type

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "OJT_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier = ["subnet-0e2cad195d4b5c679"] # Replace with your subnet ID(s)

  launch_configuration = aws_launch_configuration.OJT_launch_config.id
}

resource "aws_lb" "OJT_lb" {
  name               = "OJT-lb"
  internal           = false
  load_balancer_type = "application"
  enable_deletion_protection = false # Set to true if you want to enable deletion protection

  enable_cross_zone_load_balancing = true
  enable_http2                     = true
  idle_timeout                      = 60

  security_groups = ["sg-026f6354e95857378"] # Replace with your security group ID(s)

  subnets = ["subnet-0e2cad195d4b5c679"] # Replace with your subnet ID(s)
}

resource "aws_lb_target_group" "OJT_target_group" {
  name     = "OJT-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0464f2a5e1f0e724f" # Replace with your VPC ID
}

resource "aws_lb_listener" "OJT_lb_listener" {
  load_balancer_arn = aws_lb.OJT_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.OJT_target_group.arn
  }
}

resource "aws_autoscaling_attachment" "OJT_asg_attachment" {
  alb_target_group_arn  = aws_lb_target_group.OJT_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.OJT_asg.name
}
