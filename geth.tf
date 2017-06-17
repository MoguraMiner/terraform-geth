provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"

}

resource "aws_instance" "mogura-geth" {
  ami = "ami-01341617"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.region}${var.availability_zone}"
}

resource "aws_ebs_volume" "mogura-geth-hdd"{
   size = "500"
   type = "st1"
   availability_zone = "${var.region}${var.availability_zone}"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name="/dev/sdf"
  volume_id = "${aws_ebs_volume.mogura-geth-hdd.id}"
  instance_id = "${aws_instance.mogura-geth.id}"
  skip_destroy = true
}
