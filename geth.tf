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
}

resource "aws_instance" "mogura-geth" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.region}${var.availability_zone}"
  key_name = "personal-key"
  security_groups =["${aws_security_group.mogura-geth-security-group.name}"]
  tags {
    Name = "Mogura-Geth Node"
  }

   provisioner "remote-exec" {
     inline = ["sudo docker run -p 8545:8545 -p 30303:30303 iknowhtml/mogura-geth:latest"]
     connection {
            user = "ubuntu"
            private_key = "${file("${var.private_key_path}")}"
            host = "${self.public_ip}"
    }
  }
}

resource "aws_ebs_volume" "mogura-geth-hdd"{
   size = "500"
   type = "st1"
   availability_zone = "${var.region}${var.availability_zone}"
   tags{
     Name = "Mogura-Geth HDD Volume"
   }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name="/dev/sdf"
  volume_id = "${aws_ebs_volume.mogura-geth-hdd.id}"
  instance_id = "${aws_instance.mogura-geth.id}"
  skip_destroy = true
}
