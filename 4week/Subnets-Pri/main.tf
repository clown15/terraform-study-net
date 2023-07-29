resource "aws_subnet" "subnets" {
  count             = length(var.subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets[count.index].cidr
  availability_zone = var.subnets[count.index].zone

  tags = merge({
    Name = "${var.company}-${var.env}-sbn-${var.subnets[count.index].name}"
  }, var.tags)
}

resource "aws_route_table" "rtb" {
  #count  = length(aws_subnet.subnets)
  count  = var.single_nat_gateway ? 1 : length(aws_subnet.subnets)
  vpc_id = var.vpc_id

  tags = merge({
    Name = "${var.company}-${var.env}-${var.subnets[count.index].name}-rtb"
  }, var.tags)
}

resource "aws_route_table_association" "this" {
  count          = length(aws_subnet.subnets)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rtb[var.single_nat_gateway ? 0 : count.index].id
}
