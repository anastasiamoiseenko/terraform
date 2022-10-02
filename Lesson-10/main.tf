provider "aws" {
    region = "eu-central-1"
}

data "aws_ami" "latest_ubuntu" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    }

resource "aws_instance" "my_webserver_ubuntu" {
    ami = data.aws_ami.latest_ubuntu.id
    instance_type = "t2.micro"
}

output "latest_ubuntu_ami_id" {
    value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
    value = data.aws_ami.latest_ubuntu.name
}