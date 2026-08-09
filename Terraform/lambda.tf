data "archive_file" "visitor_counter_zip" {
  type        = "zip"
  source_file = "${path.module}/../Resume/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "visitor_counter" {
  filename         = data.archive_file.visitor_counter_zip.output_path
  source_code_hash = data.archive_file.visitor_counter_zip.output_base64sha256
  function_name    = "increment_visitor_count"
  role             = aws_iam_role.visitor_lambda_role.arn
  handler          = "lambda_function.lambda_handler"

  runtime = "python3.14"


  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.count_table.name
    }
  }
}

resource "aws_lambda_permission" "counter_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.visitor_counter.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.cloud_resume_challenge.execution_arn}/*/*"
}