provider "aws" {
  region = "sa-east-1"  # Região de São Paulo
}

resource "aws_instance" "example" {
  ami           = "ami-0cdc2f24b2f67ea17"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}