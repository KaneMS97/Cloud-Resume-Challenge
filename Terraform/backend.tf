resource "aws_dynamodb_table" "count_table" {
  name         = "visitors"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_apigatewayv2_api" "cloud_resume_challenge" {
  name          = "cloud-resume-challenge"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = [ "https://kanestephens.com", ]
    allow_methods = [ "POST", ]
    allow_headers = [ "Content-Type" ]
  }
}

resource "aws_apigatewayv2_integration" "cloud_resume_api_integration" {
  api_id               = aws_apigatewayv2_api.cloud_resume_challenge.id
  integration_type     = "AWS_PROXY"
  connection_type      = "INTERNET"
  description          = "Lambda Function"
  integration_uri      = aws_lambda_function.visitor_counter.invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "counter_gateway_route" {
  api_id    = aws_apigatewayv2_api.cloud_resume_challenge.id
  route_key = "POST /visitors"
  target    = "integrations/${aws_apigatewayv2_integration.cloud_resume_api_integration.id}"
}

resource "aws_apigatewayv2_stage" "counter_gateway_stage" {
  api_id      = aws_apigatewayv2_api.cloud_resume_challenge.id
  name        = "counter-stage"
  auto_deploy = true
}



