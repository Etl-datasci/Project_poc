resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_role_july"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_lambda_function" "my_lambda_function" {
  filename         = "${path.module}/../python/hello_lambda.zip"
  function_name    = "hello-tmdb_api_lambda_function"
  description      = "Lambda Fucntion for ingestion of tmdb api"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "hello_lambda.lambda_handler"
  runtime          = "python3.8"
}

