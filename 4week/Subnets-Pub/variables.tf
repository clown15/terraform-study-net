variable "company" {
  type        = string
  description = "company name"
}
variable "vpc_id" {
  type = string
}
variable "env" {
  type        = string
  description = "environment"
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
  description = "Custom Tags"
}
