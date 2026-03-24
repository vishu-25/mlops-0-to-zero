variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "aws_region" {
  description = "AWS Region to deploy resources in"
  type = string
  default = "us-east-1"
}

variable "db_name" {
  description = "Database Name"
  type = string
  default = "vismay-mlflow-demo"
}

variable "db_username" {
  description = "Database username"
  type = string
  default = "admin"
}

variable "db_password" {
  description = "Database password"
  type = string
  sensitive = true
}

variable "db_instance_class" {
  description = "RDS instance type"
  type = string
  default = "db.t3.micro"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "mlflow-eks"
}

variable "node_instance_type" {
  description = "EKS worker node instance type"
  type        = string
  default     = "t3.medium"
}

variable "desired_nodes" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}