terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.42.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}



data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }



  filter {
    name   = "state"
    values = ["available"]
  }

}

resource "aws_instance" "data-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}

output "ami" {
  description = "value"
  value       = aws_instance.data-server.public_ip
}