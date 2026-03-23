output "bucket_id" {
  description = "The name / ID of the S3 bucket"
  value       = aws_s3_bucket.data.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.data.arn
}

output "bucket_region" {
  description = "The AWS region the bucket was created in"
  value       = aws_s3_bucket.data.region
}

output "bucket_domain_name" {
  description = "The bucket domain name (bucket.s3.amazonaws.com)"
  value       = aws_s3_bucket.data.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Region-specific domain name (for path-style access)"
  value       = aws_s3_bucket.data.bucket_regional_domain_name
}