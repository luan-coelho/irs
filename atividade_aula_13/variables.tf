variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-0cdc2f24b2f67ea17"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key file for SSH"
  type        = string
}
