provider "aws" {}


resource "aws_instance" "my_Ubuntu" {
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
  
  tags = {
        Name = "My Ubuntu Server"
        Owner = "Anastasiia Moiseienko"
        Project = "Terraform Lessons"
    }
}

resource "aws_instance" "my_Amazon_Linux" {
    ami = "ami-05ff5eaef6149df49"
    instance_type = "t2.micro"
    
    tags = {
        Name = "My Amazon Server"
        Owner = "Anastasiia Moiseienko"
        Project = "Terraform Lessons"
    }
}