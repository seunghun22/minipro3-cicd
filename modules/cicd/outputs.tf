output "pipeline_name" {
  description = "CodePipeline 이름"
  value       = aws_codepipeline.pipeline.name
}

output "pipeline_url" {
  description = "CodePipeline 콘솔 URL"
  value       = "https://console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.pipeline.name}/view"
}

output "github_connection_arn" {
  description = "GitHub 연결 ARN"
  value       = aws_codestarconnections_connection.github.arn
}