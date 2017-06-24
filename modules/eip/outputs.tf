output "eip"{
  value = "${aws_eip.ip.public_ip}"
}
