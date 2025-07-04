output "zone_id" {
  description = "The Hosted Zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "name_servers" {
  description = "A list of name servers in associated (or default) delegation set"
  value       = aws_route53_zone.main.name_servers
}

output "domain_name" {
  description = "The domain name"
  value       = aws_route53_zone.main.name
}