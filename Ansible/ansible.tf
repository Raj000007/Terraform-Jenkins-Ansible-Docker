terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
provider "aws" {
access_key= "enter the access key"
secret_key= "enter the secret access key"
region= "ap-south-1"
}

resource "aws_instance" "Ansible" {
  ami           = "ami id of the server"
  instance_type = "t2.micro"
key_name= "keypair name"
vpc_security_group_ids      = ["${aws_security_group.ansible_sg.id}"]
provisioner "remote-exec"  {
    inline  = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install ansible2 -y",
      "ansible --version",
    ]
    }
connection {
    type         = "ssh"
        host         = self.public_ip
            user         = "ec2-user"
                private_key  = file("pem key path in the server" )
                   }
  tags = {
    "Name" = "Ansible"
  }
}

