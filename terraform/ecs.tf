resource "aws_ecs_cluster" "main" {
  name = "weather-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "weather-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "weather-app"
      image = "${aws_ecr_repository.weather.repository_url}:latest"

      portMappings = [
        {
          containerPort = 5000
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "weather-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets          = [aws_subnet.public.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  # ⭐ THIS IS THE MISSING PIECE (CRITICAL FIX)
  load_balancer {
    target_group_arn = aws_lb_target_group.weather_tg.arn
    container_name   = "weather-app"
    container_port   = 5000
  }

  depends_on = [
    aws_lb_listener.http
  ]
}

resource "aws_security_group" "ecs_sg" {
  name   = "weather-ecs-sg"
  vpc_id = aws_vpc.main.id

  # allow traffic FROM ALB only
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "weather-ecs-sg"
  }
}