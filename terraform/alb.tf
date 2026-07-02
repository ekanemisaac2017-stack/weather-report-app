############################################
# APPLICATION LOAD BALANCER
############################################

resource "aws_lb" "weather_alb" {
  name               = "weather-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]

  subnets = [
    aws_subnet.public.id,
    aws_subnet.public_b.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "weather-alb"
  }
}

############################################
# TARGET GROUP (FOR ECS TASKS)
############################################

resource "aws_lb_target_group" "weather_tg" {
  name        = "weather-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "weather-tg"
  }
}

############################################
# LISTENER (HTTP :80)
############################################

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.weather_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.weather_tg.arn
  }
}

############################################
# SECURITY GROUP FOR ALB
############################################

resource "aws_security_group" "alb_sg" {
  name   = "weather-alb-sg"
  vpc_id = aws_vpc.main.id

  # Allow internet traffic to ALB
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "weather-alb-sg"
  }
}

############################################
# OUTPUT - ALB URL
############################################

output "alb_dns_name" {
  value = aws_lb.weather_alb.dns_name
}