resource "aws_s3_bucket" "madhatter_data_lake" {
  bucket = "madhatter-data-lake-bucket"
}

resource "aws_s3_bucket_acl" "madhatter_data_lake_acl" {
  bucket = aws_s3_bucket.madhatter_data_lake.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "madhatter_data_lake_versioning" {
  bucket = aws_s3_bucket.madhatter_data_lake.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "madhatter_data_lake_lifecycle" {
  bucket = aws_s3_bucket.madhatter_data_lake.id

  rule {
    id     = "noncurrent-version-expiration-rule"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
