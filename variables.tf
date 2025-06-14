variable "aws_region" {
  description = "AWS region for Route53"
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "The domain name to manage"
  type        = string
  default     = "toof.jp"
}