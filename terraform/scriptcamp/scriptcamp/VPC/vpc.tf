# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "my-vpc"
  }
}

# Subnets
resource "aws_subnet" "Public-subnet-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "Public-subnet-01"
  }
}

resource "aws_subnet" "Public-subnet-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "Public-subnet-02"
  }
}

resource "aws_subnet" "Public-subnet-03" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "Public-subnet-03"
  }
}

resource "aws_subnet" "App-subnet-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "App-subnet-01"
  }
}

resource "aws_subnet" "App-subnet-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "App-subnet-02"
  }
}

resource "aws_subnet" "App-subnet-03" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "App-subnet-03"
  }
}

resource "aws_subnet" "DB-Ssubnet-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.7.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "DB-Ssubnet-01"
  }
}

resource "aws_subnet" "DB-Ssubnet-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.8.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "DB-Ssubnet-02"
  }
}

resource "aws_subnet" "DB-Ssubnet-03" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.9.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "DB-Ssubnet-03"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public"
  }
}

# route associations public
resource "aws_route_table_association" "Public-route-01" {
  subnet_id      = aws_subnet.Public-subnet-01.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "Public-route-02" {
  subnet_id      = aws_subnet.Public-subnet-02.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "Public-route-03" {
  subnet_id      = aws_subnet.Public-subnet-03.id
  route_table_id = aws_route_table.main-public.id
}

