resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}


module "vpc" {
  source = "./VPC"

  vpc_cidr             = var.vpc_cidr
  company              = var.company
  env                  = var.env
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = var.tags
}

module "sbn_pub" {
  source = "./Subnets-Pub"

  company = var.company
  vpc_id  = module.vpc.vpc_id
  env     = var.env
  subnets = var.sbn_pub
  tags    = var.tags
}

module "sbn_pri" {
  source   = "./Subnets-Pri"
  for_each = var.sbn_pri

  company            = var.company
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  single_nat_gateway = var.single_nat_gateway
  subnets            = var.sbn_pri[each.key]
  tags               = var.tags
}
