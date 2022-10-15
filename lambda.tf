data "archive_file" "hello_artefact" {
  output_path = "files/hello-artefact.zip"
  type = "zip"
  source_file = "${path.module}/lambdas/index.js"
}

resource "aws_lambda_function" "hello" {
  function_name = "hello"
  handler = "index.handler"
  role = aws_iam_role.api_lambda.arn
  runtime = "nodejs16.x"

  filename = data.archive_file.hello_artefact.output_path
  source_code_hash = data.archive_file.hello_artefact.output_base64sha256

  timeout = 5
  memory_size = 128
}