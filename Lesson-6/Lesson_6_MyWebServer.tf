#---------------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#---------------------------------------------


provider "aws" {
    region = "eu-central-1"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}

resource "aws_instance" "my_webserver" {
    ami = "ami-05ff5eaef6149df49" #Amazon Linux AMI
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data = templatefile("user_data.sh.tpl", {
      f_name = "Anastasiia"
      l_name = "Moiseienko"
      names = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
    })
    
tags = {
    Name = "WebServer build by Terraform"
}

lifecycle {
  create_before_destroy = true
}
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First Security Group"


dynamic "ingress" {
  for_each = ["80", "443"]
  content {
   from_port        = ingress.value
   to_port          = ingress.value
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"] 
  }
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

