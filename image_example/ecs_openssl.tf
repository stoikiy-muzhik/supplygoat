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
    Env       = "prod"
    git_org   = "stoikiy-muzhik"
    yor_trace = "94133120-cb5a-491b-a147-49f852e40bb7"
  }
}
