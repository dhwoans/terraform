output "vpc_arn" {
  description = "The ARN of the VPC"
  value       =  aws_vpc.*.arn
}