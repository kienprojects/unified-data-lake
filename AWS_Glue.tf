resource "aws_glue_catalog_database" "madhatter-database" {
  name = "madhatter_glue_database"
}

resource "aws_glue_crawler" "madhatter-crawler" {
  name          = "madhatter_crawler"
  role          = aws_iam_role.madhatter-glue_role.arn
  database_name = aws_glue_catalog_database.madhatter-database.name
  s3_target {
    path = "s3://${aws_s3_bucket.madhatter_data_lake.bucket}/"
  }
}

resource "aws_glue_job" "job" {
  name     = "my_etl_job"
  role_arn = aws_iam_role.madhatter-glue_role.arn
  command {
    // WYOF.
    script_location = "s3://${aws_s3_bucket.madhatter_data_lake.bucket}/scripts/my_etl_script.py"
    python_version  = "3"
  }
}

resource "aws_iam_role" "madhatter-glue_role" {
  name = "madhatter-glue-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "madhatter-glue_policy_attachment" {
  name       = "madhatter-glue-policy-attachment"
  roles      = [aws_iam_role.madhatter-glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
