resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "tg" {
  name        = "app-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

   health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"  # Adjust this based on your application
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "target_1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.private_instance_1_id
  port             = 80

}

resource "aws_lb_target_group_attachment" "target_2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.private_instance_2_id
  port             = 80
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
