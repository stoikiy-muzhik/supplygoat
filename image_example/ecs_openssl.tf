resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "ubuntu:jammy"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  tags = {
    git_org   = "stoikiy-muzhik"
    yor_trace = "61af7b08-891c-4575-95ea-7449b23f98c6"
  }
}
