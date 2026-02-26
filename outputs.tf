# For Output variables

data "aws_region" "current" {}

output "provider_region" {
  value = data.aws_region.current.name
}
