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

resource "aws_instance" "server1" {
	ami = "ami-0a457777ab864ed6f"
	instance_type = "t2.micro"

	tags = {
		Name = "ai-analizer"
    Project = "AI_Analizer"
	}
}
