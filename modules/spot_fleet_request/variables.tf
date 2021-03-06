variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "availability_zone" {
  default = "a"
}
variable "spot_price" {
  default = "0.32"
}

variable "capacity" {
  default = "1"
}

variable "allocation_strategy" {
  default = "diversified"
}

variable "instance_type"{
  default = "p2.xlarge"
}

variable "ami"{
  default = "ami-2ecdf838"
}
