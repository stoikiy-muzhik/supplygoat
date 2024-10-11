resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group for SSH access"

  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Env       = "prod"
    git_org   = "stoikiy-muzhik"
    yor_trace = "be1cda1a-392a-4bb4-9222-c88d015dda57"
  }
}

