# we need an ip to use with the nat
resource "aws_eip" "nat-ip" {
  #Elastic IP should be allocated for use within a VPC 
#    instance = aws_instance.web.id
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id     = var.subnet_id
  depends_on    = [aws_eip.nat-ip]
  tags = {
    Name = var.nat_name
  }
}
