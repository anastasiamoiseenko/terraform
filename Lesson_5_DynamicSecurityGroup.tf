#---------------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#---------------------------------------------


provider "aws" {
    region = "eu-central-1"
}


resource "aws_security_group" "my_webserver" {
  name        = "Dynamic Security Group"


dynamic "ingress" {
  for_each = ["80", "443", "8080", "1541", "9092"]
  content {
   from_port        = ingress.value
   to_port          = ingress.value
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"] 
  }
}

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0 #all ports
    to_port          = 0
    protocol         = "-1" #all protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "DynamicSecurityGroup"
  }
}