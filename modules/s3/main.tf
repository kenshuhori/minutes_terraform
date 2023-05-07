resource "aws_s3_bucket" "template" {
  bucket = var.bucket_name

  tags = {
    Project     = "minutes"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "template" {
  bucket = aws_s3_bucket.template.id

  rule {
    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "template" {
  bucket = aws_s3_bucket.template.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "template" {
  bucket = aws_s3_bucket.template.id
}

resource "aws_s3_bucket_versioning" "template" {
  bucket = aws_s3_bucket.template.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "template" {
  bucket = aws_s3_bucket.template.id

  rule {
    id = "ExpiredObjectMarkerForMinutes"
    expiration {
      days                         = 14
      expired_object_delete_marker = false
    }
    status = "Enabled"
  }
  rule {
    id = "ExpiredObjectDeleterForMinutes"
    expiration {
      days                         = 0
      expired_object_delete_marker = true
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "template" {
  bucket = aws_s3_bucket.template.id
  policy = data.aws_iam_policy_document.template.json
}

data "aws_iam_policy_document" "template" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpce"
      values   = var.allow_vpces
    }

    resources = [
      "${aws_s3_bucket.template.arn}/*",
    ]
  }
}
