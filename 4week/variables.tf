variable "vpc_cidr" {
  type = string
}
variable "company" {
  type        = string
  description = "company name"
}
variable "env" {
  type        = string
  description = "env"
}
variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "vpc enable dns hostnames"
}
variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "vpc enable dns support"
}
variable "tags" {
  default     = {}
  description = "Custom Tags"
}
variable "single_nat_gateway" {
  type = bool
}
variable "sbn_pub" {
  type = list(object({
    name                    = string
    zone                    = string
    cidr                    = string
    map_public_ip_on_launch = bool
  }))
}
variable "sbn_pri" {
  type = map(list(object({
    name                    = string
    zone                    = string
    cidr                    = string
    map_public_ip_on_launch = bool
  })))
}
