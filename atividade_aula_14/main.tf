provider "aws" {
  alias  = "sa-east-1a"
  region = "sa-east-1"
}

provider "aws" {
  alias  = "sa-east-1b"
  region = "sa-east-1"
}

provider "aws" {
  alias  = "sa-east-1c"
  region = "sa-east-1"
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
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
    Name = "web-sg"
  }
}

resource "aws_instance" "frontend" {
  provider          = aws.sa-east-1a
  ami               = "ami-04716897be83e3f04"
  instance_type     = "t2.micro"
  availability_zone = "sa-east-1a"
  key_name        = "aeros-elite"
  security_groups   = [aws_security_group.web_sg.name]

  tags = {
    Name = "frontend"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.public_ip} >> private_ips.txt",
      "sudo apt-get -y update",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "sudo apt install -y curl",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository -y 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'",
      "sudo apt-get -y update",
      "sudo apt install -y docker-ce",
      "sudo usermod -aG docker ubuntu",
      "newgrp docker"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./aeros-elite.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_eip" "frontend" {
  instance = aws_instance.frontend.id
}

resource "aws_instance" "node" {
  provider          = aws.sa-east-1a
  ami               = "ami-04716897be83e3f04"
  instance_type     = "t2.micro"
  availability_zone = "sa-east-1a"
  key_name        = "aeros-elite"
  security_groups   = [aws_security_group.web_sg.name]

  tags = {
    Name = "node"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.public_ip} >> private_ips.txt",
      "sudo apt-get -y update",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "sudo apt install -y curl",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository -y 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'",
      "sudo apt-get -y update",
      "sudo apt install -y docker-ce",
      "sudo usermod -aG docker ubuntu",
      "newgrp docker"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./aeros-elite.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_eip" "node" {
  instance = aws_instance.node.id
}

resource "aws_instance" "mongodb" {
  provider          = aws.sa-east-1c
  ami               = "ami-04716897be83e3f04"
  instance_type     = "t2.micro"
  availability_zone = "sa-east-1c"
  key_name        = "aeros-elite"
  security_groups   = [aws_security_group.web_sg.name]

  tags = {
    Name = "mongodb"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.public_ip} >> private_ips.txt",
      "sudo apt-get -y update",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "sudo apt install -y curl",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository -y 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'",
      "sudo apt-get -y update",
      "sudo apt install -y docker-ce",
      "sudo usermod -aG docker ubuntu",
      "newgrp docker"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./aeros-elite.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_eip" "mongodb" {
  instance = aws_instance.mongodb.id
}

output "mongodb_instance_id" {
  value = aws_instance.mongodb.id
}

output "node_instance_id" {
  value = aws_instance.node.id
}

output "frontend_instance_id" {
  value = aws_instance.frontend.id
}

output "mongodb_public_ip" {
  value = aws_instance.mongodb.public_ip
}

output "node_public_ip" {
  value = aws_instance.node.public_ip
}

output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}
