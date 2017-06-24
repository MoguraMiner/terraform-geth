provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_security_group" "mogura-geth-security-group" {
  name        = "mogura-geth-security-group"
  description = "Allow SSH, HTTP/HTTPS, JSON-RPC and Ethereum traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8545
    to_port     = 8545
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 8545
    to_port     = 8545
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mogura-geth" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.region}${var.availability_zone}"
  key_name = "personal-key"
  security_groups =["${aws_security_group.mogura-geth-security-group.name}"]
  user_data = "${file("${path.module}/bootstrap.sh")}"

  tags {
    Name = "Mogura-Geth Node"
  }
}

resource "aws_ebs_volume" "mogura-geth-hdd"{
   size = "${var.ebs_size}"
   type = "${var.ebs_type}"
   availability_zone = "${var.region}${var.availability_zone}"
   tags{
     Name = "Mogura-Geth Data Volume"
   }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name="/dev/sdf"
  volume_id = "${aws_ebs_volume.mogura-geth-hdd.id}"
  instance_id = "${aws_instance.mogura-geth.id}"
  skip_destroy = true
}
