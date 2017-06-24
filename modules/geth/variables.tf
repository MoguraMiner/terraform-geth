variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "availability_zone" {
  default = "a"
}
variable "instance_type"{
  default = "t2.micro"
}
variable "ami"{
  default = "ami-2b06283d"
}
variable "private_key_path"{
  default = "~/.ssh/id_rsa"
}
