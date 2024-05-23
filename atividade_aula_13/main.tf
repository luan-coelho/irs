provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  ami             = "ami-0cdc2f24b2f67ea17"
  instance_type   = "t2.micro"
  key_name        = "aeros-elite"
  security_groups = [aws_security_group.web_sg.name]

  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./aeros-elite.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository -y 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'",
      "sudo apt update",
      "sudo apt install -y docker-ce",
      "sudo apt install -y docker-compose",
      "sudo usermod -aG docker ubuntu",
      "newgrp docker",
      "docker-compose -f /home/ubuntu/docker-compose.yml up"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./aeros-elite.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "docker-compose-instance"
  }
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

output "instance_id" {
  value = aws_instance.web.id
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
