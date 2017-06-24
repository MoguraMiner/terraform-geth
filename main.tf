provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

module "geth" {
  source = "./modules/geth"

  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
  availability_zone = "${var.availability_zone}"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  private_key_path = "${var.private_key_path}"
  ebs_size = "${var.ebs_size}"
  ebs_type = "${var.ebs_type}"
}

resource "aws_eip" "ip" {
  instance = "${module.geth.instance_id}"
}

output "eip"{
  value = "${aws_eip.ip.public_ip}"
}
