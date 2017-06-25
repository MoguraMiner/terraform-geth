provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

data "aws_iam_policy_document" "spot-fleet-assume-role-policy" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "spot_fleet_role" {
  name = "spot_fleet_role"
  path = "/system/"
  assume_role_policy = "${data.aws_iam_policy_document.spot-fleet-assume-role-policy.json}"
}

resource "aws_security_group" "ethminer-security-group" {
  name = "ethminer-security-group"
  description = "Allow SSH and JSON-RPC traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8545
    to_port = 8545
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 8545
    to_port = 8545
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8545
    to_port = 8545
    protocol = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 8545
    to_port = 8545
    protocol = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_spot_fleet_request" "ethminers" {
#   iam_fleet_role = "${aws_iam_role.spot_fleet_role.arn}"
#   spot_price = "${var.spot_price}"
#   allocation_strategy = "${var.allocation_strategy}"
#   target_capacity = "${var.capacity}"
#
#   launch_specification {
#     instance_type = "${var.instance_type}"
#     ami = "${var.ami}"
#     key_name = "personal-key"
#     user_data = "${file("${path.module}/mine.sh")}"
#     vpc_security_group_ids = ["${aws_security_group.ethminer-security-group.id}"]
#   }
# }
