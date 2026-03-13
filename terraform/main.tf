secure-cloud-security-pipeline
│
├── terraform
│   ├── main.tf
│   ├── providers.tf
│   └── variables.tf
│
├── pipeline
│   └── github-actions.yml
│
├── security
│   ├── tfsec-scan.yml
│   └── iam-policies
│
├── monitoring
│   └── cloudwatch-alerts.tf
│
├── diagrams
│
└── README.md

resource "aws_s3_bucket" "secure_pipeline_logs" {
  bucket = "secure-pipeline-logs-demo-12345"

  tags = {
    Name        = "secure-pipeline-logs"
    Environment = "security-project"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_pipeline_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.secure_pipeline_logs.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
