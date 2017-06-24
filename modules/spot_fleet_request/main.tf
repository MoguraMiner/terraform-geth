provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_spot_fleet_request" "ethminers" {
  iam_fleet_role ="arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
  spot_price = "${var.spot_price}"
  allocation_strategy = "${var.allocation_strategy}"
  target_capacity = "${var.capacity}"

  launch_specification {
    instance_type = "${var.instance_type}"
    ami = "${var.ami}"
    key_name = "personal-key"
    user_data = "${file("${path.module}/mine.sh")}"
  }
}
