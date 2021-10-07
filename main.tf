resource "aws_instance" "appwrite-demo" {
  ami           = "ami-09e67e426f25ce0d7" # ubuntu 20 image
  instance_type = "t2.small"
  tags          = { Name : "appwrite-ec2" }
  key_name               = "awseducateiacdemo"
  vpc_security_group_ids = [aws_security_group.sg_allow_all_egress_appwriteicademo.id,
  aws_security_group.sg_allow_http_ingress_appwriteicademo.id ,
  aws_security_group.sg_allow_https_ingress_appwriteicademo.id,
  aws_security_group.sg_allow_ssh_ingress_appwriteicademo.id
  ]
  subnet_id              = aws_subnet.publicsubnetappwriteiacdemo.id
}


# log public-ip after privisioning
output "public-ip" {
  value = aws_instance.appwrite-demo.public_ip
}