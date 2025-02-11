resource "aws_eip" "eip" {
  count = var.az_cnt
  vpc = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.eip_tag}-${count.index}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = var.az_cnt
  allocation_id = element(aws_eip.eip.*.id, count.index)
  subnet_id     = element(aws_subnet.pub.*.id, count.index)
  depends_on    = [aws_eip.eip]

  tags = {
    Name = "${var.nat_tag}-${count.index}"
  }
}
