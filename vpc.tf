resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames= true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "TerraformVPC"
  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "TerraformIGW"
  }
}

resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.main.id 
    cidr_block= "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    
    tags = {
        Name="TerraformPublicSubnet"
    }
}
resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.main.id 
    cidr_block= "10.0.2.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    
    tags = {
        Name="TerraformPrivateSubnet"
    }
}

resource "aws_route_table" "public_route_table"{
    vpc_id = aws_vpc.main.id 
    route{
    cidr_block= "0.0.0.0/0"
    gateway_id= aws_internet_gateway.internet_gateway.id
    }
    
    tags = {
        Name="TerraformPublicRT"
    }
}
resource "aws_route_table_association" "public_subnet_route_table_association" {
  subnet_id       = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "security_group" {
  name_prefix = "security_group"
  description = "Example security group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "dev"
  }
}