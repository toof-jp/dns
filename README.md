# dns

Terraform configuration for managing toof.jp DNS records in AWS Route53.

## Current DNS Configuration

The domain currently has the following records:
- A records: GitHub Pages IPs (185.199.108-111.153)
- AAAA records: GitHub Pages IPv6 addresses
- MX records: Titan Email servers
- TXT records: ProtonMail verification and SPF record

## Backend Configuration

The backend configuration is commented out in `main.tf`. You can choose between:

1. **S3 Backend** (recommended for production):
   - Create an S3 bucket for state storage
   - Uncomment and configure the S3 backend section in `main.tf`

2. **Local Backend** (for testing):
   - Uncomment the local backend section in `main.tf`
   - Note: State will be stored locally in `terraform.tfstate`

3. **Custom HTTP Backend**:
   - If you have access to api.shisha.toof.jp, configure it with proper authentication

## Usage

1. **Check current DNS settings:**
   ```bash
   make dig
   ```

2. **Initialize Terraform:**
   ```bash
   make init
   ```

3. **Import existing Route53 resources:**
   ```bash
   # First, create a hosted zone in AWS Route53 for toof.jp
   # Then get the Zone ID and run:
   make import
   # Follow the instructions shown
   ```

4. **Plan changes:**
   ```bash
   make plan
   ```

5. **Apply changes:**
   ```bash
   make apply
   ```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- Access to AWS Route53

## Note

The current DNS is managed by muumuu-domain.com. To use this Terraform configuration:
1. Create a Route53 hosted zone
2. Update domain nameservers at your registrar to point to Route53
3. Import existing records using the import commands