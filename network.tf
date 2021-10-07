
# VPC
resource "aws_vpc" "vpcappwriteiacdemo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc_appwriteiacdemo"
  }
}

# Public subnet
resource "aws_subnet" "publicsubnetappwriteiacdemo" {
  vpc_id                  = aws_vpc.vpcappwriteiacdemo.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

}


#IGW
resource "aws_internet_gateway" "igwappwriteiacdemo" {
  vpc_id = aws_vpc.vpcappwriteiacdemo.id
  tags = {
    "Name" = "igw_appwriteiacdemo"
  }
}

resource "aws_route_table" "crtpublicappwriteiacdemo" {
  vpc_id = aws_vpc.vpcappwriteiacdemo.id


  route {
    cidr_block = "0.0.0.0/0"
    # directs to IGW
    gateway_id = aws_internet_gateway.igwappwriteiacdemo.id
  }


  tags = {
    "Name" = "custom_public_route_table_appwriteiacdemo"
  }
}


resource "aws_route_table_association" "racappwriteiacdemo" {
  subnet_id      = aws_subnet.publicsubnetappwriteiacdemo.id
  route_table_id = aws_route_table.crtpublicappwriteiacdemo.id
}