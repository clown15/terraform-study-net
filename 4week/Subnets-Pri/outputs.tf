output "subnets_ids" {
  value = aws_subnet.subnets.*.id
}
output "rtb_id" {
  value = aws_route_table.rtb
}
