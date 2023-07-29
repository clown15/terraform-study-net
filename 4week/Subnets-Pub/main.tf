resource "aws_subnet" "subnets" {
  count             = length(var.subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets[count.index].cidr
  availability_zone = var.subnets[count.index].zone

  tags = merge({
    Name = "${var.company}-${var.env}-sbn-${var.subnets[count.index].name}"
  }, var.tags)

}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge({
    Name = "${var.company}-${var.env}-IGW"
  }, var.tags)
}

resource "aws_route_table" "rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "${var.company}-${var.env}-PUB-RTB"
  }, var.tags)
}

resource "aws_route_table_association" "this" {
  count          = length(aws_subnet.subnets)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rtb.id
}
