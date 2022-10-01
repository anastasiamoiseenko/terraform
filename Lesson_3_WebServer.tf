#---------------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#---------------------------------------------


provider "aws" {
    region = "eu-central-1"
}


resource "aws_instance" "my_webserver" {
    ami = "ami-05ff5eaef6149df49" #Amazon Linux AMI
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data = file("user_data.sh")
tags = {
    Name = "WebServer build by Terraform"
}
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First Security Group"

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0 #all ports
    to_port          = 0
    protocol         = "-1" #all protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "WebServer SecurityGroup"
  }
}