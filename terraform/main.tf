terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "web_sg" {
  name        = "ai-analizer-sg"
  description = "Allow inbound traffic on port 8000"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ai-analizer-sg"
  }
}

resource "aws_instance" "server1" {
  ami = "ami-0a457777ab864ed6f"
  instance_type = "t2.nano"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
  #!/bin/bash

  sudo yum update -y
  sudo yum install -y git python3 python3-pip
  DIR=/home/ec2-user/ai-analizer
  git clone https://github.com/gchalakovmmi/ai-analizer.git $DIR
  cd $DIR/app
  sudo chmod u+x run.sh
  ./run.sh
  EOF

  tags = {
    Name = "ai-analizer"
    Project = "AI_Analizer"
  }
}

output "public_ip" {
  value = aws_instance.server1.public_ip
}
