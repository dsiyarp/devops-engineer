provider "aws" {
  region = "us-east-1" # Cambiar según la región deseada
}

# EC2 Instances
resource "aws_instance" "t3_large_instances" {
  count         = 3
  ami           = "ami-0c02fb55956c7d316" # AMI de Amazon Linux 2, cambiar según la región
  instance_type = "t3.large"

  root_block_device {
    volume_size = 500
  }

  tags = {
    Name = "t3_large_instance_${count.index + 1}"
  }
}

# EBS Snapshots
resource "aws_ebs_volume" "ebs_volume" {
  count        = 3
  availability_zone = "us-east-1a" # Cambiar según la zona de la región
  size         = 500
  tags = {
    Name = "ebs_volume_${count.index + 1}"
  }
}

resource "aws_ebs_snapshot" "ebs_snapshot" {
  count  = 3
  volume_id = aws_ebs_volume.ebs_volume[count.index].id
  tags = {
    Name = "ebs_snapshot_${count.index + 1}"
  }
}

# S3 Buckets
resource "aws_s3_bucket" "standard_bucket" {
  bucket = "my-standard-bucket"
  acl    = "private"
}

resource "aws_s3_bucket" "glacier_bucket" {
  bucket = "my-glacier-bucket"
  acl    = "private"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "cf_distribution" {
  origin {
    domain_name = aws_s3_bucket.standard_bucket.bucket_domain_name
    origin_id   = "S3Origin"
  }

  enabled             = true
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 100
  engine               = "mysql"
  instance_class       = "db.t3.medium"
  name                 = "mydatabase"
  username             = "admin"
  password             = "password123"
  publicly_accessible  = false
  skip_final_snapshot  = true
  storage_type         = "gp2"
}

# DynamoDB Table
resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "my-dynamodb-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 100
  write_capacity = 100
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Environment = "Production"
  }
}

