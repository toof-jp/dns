terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend configuration
  # Uncomment and configure one of the following backends:

  # Option 1: S3 backend (recommended for AWS)
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "dns/terraform.tfstate"
  #   region = "us-east-1"
  # }

  # Option 2: Local backend (for testing)
  # backend "local" {
  #   path = "terraform.tfstate"
  # }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_route53_zone" "main" {
  name = "toof.jp"

  tags = {
    Name        = "toof.jp"
    Environment = "production"
  }
}

resource "aws_route53_record" "a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "toof.jp"
  type    = "A"
  ttl     = 3600
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}

resource "aws_route53_record" "aaaa" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "toof.jp"
  type    = "AAAA"
  ttl     = 459
  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153"
  ]
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "toof.jp"
  type    = "MX"
  ttl     = 3600
  records = [
    "10 mx1.titan.email",
    "20 mx2.titan.email"
  ]
}

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "toof.jp"
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 include:spf.titan.email ~all"
  ]
}

resource "aws_route53_record" "s_cname" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "s.toof.jp"
  type    = "CNAME"
  ttl     = 3600
  records = ["s-toof-jp.pages.dev"]
}

resource "aws_route53_record" "portfolio_cname" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "portfolio.toof.jp"
  type    = "CNAME"
  ttl     = 3600
  records = ["portfolio-c1v.pages.dev"]
}

resource "aws_route53_record" "blog_cname" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "blog.toof.jp"
  type    = "CNAME"
  ttl     = 3600
  records = ["blog-hugo-89n.pages.dev"]
}

resource "aws_route53_record" "titan1_domainkey" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "titan1._domainkey.toof.jp"
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCmaAY0hGACDm16ayq8wWpo9jDOwbdieDCQvOW32KWm0/SFeNFKaxosxTn//4ffnPE9/x00Cxun8sBsQj4eXVNRtwm0oykLgMcm38JJ8SggYn/XL5G10J7knGCFwgjlhWGvebSzZQ8gUH2gOPW47BCvoqo5zcQ2X97V8muJFm1YLwIDAQAB"
  ]
}
