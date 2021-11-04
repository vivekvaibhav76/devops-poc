resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Public-subnet-01.id
  depends_on    = [aws_internet_gateway.main-gw]
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "Private-1"
  }
}

resource "aws_route_table_association" "Private-1-a" {
  subnet_id      = aws_subnet.App-subnet-01.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "Private-2-a" {
  subnet_id      = aws_subnet.App-subnet-02.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "Private-3-a" {
  subnet_id      = aws_subnet.App-subnet-03.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "Private-4-a" {
  subnet_id      = aws_subnet.DB-Ssubnet-01.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "Private-5-a" {
  subnet_id      = aws_subnet.DB-Ssubnet-02.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "Private-6-a" {
  subnet_id      = aws_subnet.DB-Ssubnet-03.id
  route_table_id = aws_route_table.main-private.id
}
