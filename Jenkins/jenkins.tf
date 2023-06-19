terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
provider "aws" {
access_key= "enter the access key"
secret_key= "enter the secret key access"
region= "ap-south-1"
}

resource "aws_instance" "Jenkins" {
  ami           = "ami-id of the server"
  instance_type = "t2.micro"
key_name= "keypairname"
vpc_security_group_ids      = ["${aws_security_group.Jenkins_P.id}"]
provisioner "remote-exec"  {
    inline  = [
    "sudo yum update –y",
    "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
    "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
    "sudo yum upgrade",
    "sudo amazon-linux-extras install java-openjdk11 -y",
    "sudo yum install jenkins -y",
    "sudo systemctl enable jenkins",
    "sudo systemctl start jenkins",

  ]
}
connection {
    type         = "ssh"
        host         = self.public_ip
            user         = "ec2-user"
                private_key  = file("Pem key file path on terraform server" )
                   }
tags = {
"Name" = "Jenkins"
}
}

