output "test_public_subnet" {
  value = aws_subnet.chizzy_public_subnet
}

output "allow_all" {
  value = aws_security_group.chizzy_Webserver-sg
}
