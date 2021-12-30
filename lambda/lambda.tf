data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.source_path
  output_path = "${var.source_path}.zip"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = "lambda"
  runtime = "nodejs12.x"
  handler = "lambda.handler"
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)
  filename         = data.archive_file.lambda.output_path
  role = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "1"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
