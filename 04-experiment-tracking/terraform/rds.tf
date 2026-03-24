provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "mlflow_db" {
  identifier = var.db_name
  username = var.db_username
  password = var.db_password
  instance_class = var.db_instance_class
  engine = "postgres"
  engine_version = "15"
  allocated_storage = 20
  publicly_accessible = true
  skip_final_snapshot = true

  tags = {
    Name = var.db_name
    Environment = "dev"
    ManagedBy = "terraform"
    terraform = "true"
  }
}