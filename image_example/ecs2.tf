resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "ubuntu@sha256:dda6886d8d153a2d86f046c9335123c6151d83fd63e446b752ed8d9da261205d"
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
    yor_trace = "17567ede-4af2-4785-80ce-0bd1c8167ea2"
  }
}
