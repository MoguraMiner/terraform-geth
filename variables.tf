variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "availability_zone" {
  default = "a"
}
variable "instance_type"{
  default = "t2.medium"
}
variable "ami"{
  default = "ami-5dc2f74b"
}
variable "private_key_path"{
  default = "~/.ssh/id_rsa"
}

variable "ebs_size"{
  default = "100"
}

variable "ebs_type"{
  default = "gp2"
}
