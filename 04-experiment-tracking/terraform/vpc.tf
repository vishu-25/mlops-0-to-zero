data "aws_availability_zones" "available" {}

resource "aws_vpc" "mlflow_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "mlflow-vpc"
    Environment = "dev"
    ManagedBy = "terraform"
    terraform = "true"
  }
}