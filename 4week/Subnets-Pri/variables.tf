variable "company" {
  type        = string
  description = "company name"
}
variable "env" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "single_nat_gateway" {
  type = bool
}
variable "subnets" {
  type = list(object({
    name                    = string
    zone                    = string
    cidr                    = string
    map_public_ip_on_launch = bool
  }))
}
variable "tags" {
  default     = {}
  description = "Cuntom Tags"
}
