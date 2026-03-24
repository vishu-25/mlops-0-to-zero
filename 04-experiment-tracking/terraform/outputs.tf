output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.mlflow.id
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.mlflow.endpoint
}

output "rds_db_name" {
  description = "MLflow database name"
  value       = aws_db_instance.mlflow.db_name
}

output "rds_username" {
  description = "MLflow DB username"
  value       = aws_db_instance.mlflow.username
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.mlflow.name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = aws_eks_cluster.mlflow.endpoint
}

output "eks_cluster_ca" {
  description = "EKS cluster certificate authority"
  value       = aws_eks_cluster.mlflow.certificate_authority[0].data
  sensitive   = true
}