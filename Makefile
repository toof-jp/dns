.PHONY: help init plan apply destroy fmt validate dig import clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize Terraform
	terraform init

plan: ## Show planned changes
	terraform plan

apply: ## Apply changes
	terraform apply

destroy: ## Destroy infrastructure
	terraform destroy

fmt: ## Format Terraform files
	terraform fmt -recursive

validate: ## Validate Terraform configuration
	terraform validate

dig: ## Check current DNS settings
	@echo "=== A Records ==="
	@dig +short toof.jp A
	@echo ""
	@echo "=== AAAA Records ==="
	@dig +short toof.jp AAAA
	@echo ""
	@echo "=== MX Records ==="
	@dig +short toof.jp MX
	@echo ""
	@echo "=== TXT Records ==="
	@dig +short toof.jp TXT
	@echo ""
	@echo "=== NS Records ==="
	@dig +short toof.jp NS

import: ## Import existing Route53 resources
	@echo "To import existing resources, run:"
	@echo "1. First create the hosted zone in AWS Route53 if it doesn't exist"
	@echo "2. Get the Zone ID from AWS Console or CLI"
	@echo "3. Run: terraform import aws_route53_zone.main <ZONE_ID>"
	@echo "4. For each record, run: terraform import aws_route53_record.<name> <ZONE_ID>_<RECORD_NAME>_<TYPE>"
	@echo ""
	@echo "Example:"
	@echo "  terraform import aws_route53_zone.main Z123456789ABC"
	@echo "  terraform import aws_route53_record.a Z123456789ABC_toof.jp_A"
	@echo "  terraform import aws_route53_record.aaaa Z123456789ABC_toof.jp_AAAA"
	@echo "  terraform import aws_route53_record.mx Z123456789ABC_toof.jp_MX"
	@echo "  terraform import aws_route53_record.txt Z123456789ABC_toof.jp_TXT"
	@echo "  terraform import aws_route53_record.shisha Z123456789ABC_shisha.toof.jp_A"
	@echo "  terraform import aws_route53_record.api_shisha Z123456789ABC_api.shisha.toof.jp_CNAME"

clean: ## Clean up Terraform files
	rm -rf .terraform .terraform.lock.hcl terraform.tfstate*