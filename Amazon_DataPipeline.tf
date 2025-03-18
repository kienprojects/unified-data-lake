resource "aws_datapipeline_pipeline" "madhatter-pipeline" {
  name        = "madhatter_data_pipeline"
  description = "A pipeline to automate MadHatter's data movement."
}

resource "aws_datapipeline_pipeline_definition" "my_data_pipeline" {
  pipeline_id = "madhatter-data-pipeline-id"

  pipeline_object {
    field {
      key = "Company"

    }
    id   = "madhatter-object"
    name = aws_s3_bucket.madhatter_data_lake.arn

  }
}
