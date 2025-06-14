# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository manages DNS configuration for toof.jp using Terraform and AWS Route53. The Terraform state is stored in an HTTP backend at api.shisha.toof.jp.

## Common Commands

### Terraform Commands
- `terraform init` - Initialize Terraform working directory
- `terraform plan` - Show planned infrastructure changes
- `terraform apply` - Apply infrastructure changes
- `terraform import` - Import existing infrastructure into Terraform state
- `terraform fmt` - Format Terraform files to canonical format
- `terraform validate` - Validate Terraform configuration

### DNS Verification
- `dig toof.jp` - Query DNS records for the domain
- `dig +short toof.jp` - Show concise DNS query results
- `dig @8.8.8.8 toof.jp` - Query using specific DNS server

## Project Structure

- `main.tf` - Main Terraform configuration for Route53 hosted zone and DNS records
- `variables.tf` - Input variables for the Terraform configuration
- `outputs.tf` - Output values from Terraform
- `terraform.tfvars` - Variable values (should not contain sensitive data)
- `Makefile` - Build automation and common tasks

## Import Process

When importing existing Route53 resources:
1. First query current DNS settings using `dig`
2. Create corresponding Terraform resources
3. Import using: `terraform import aws_route53_zone.main <ZONE_ID>`
4. Import records using: `terraform import aws_route53_record.<name> <ZONE_ID>_<RECORD_NAME>_<TYPE>_<SET_IDENTIFIER>`