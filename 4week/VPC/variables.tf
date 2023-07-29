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
