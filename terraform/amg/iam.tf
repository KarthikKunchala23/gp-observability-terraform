data "aws_iam_policy" "xray_readonly" {
  arn = "arn:aws:iam::aws:policy/AWSXrayReadOnlyAccess"
}

data "aws_iam_policy" "prometheus_policy" {
  name = "gp-grafana-policy_dev_platform"
}

resource "aws_iam_role" "amg" {
  name = "${var.grafana_workspace_alias}-amg-service-role"
  description = "IAM role for AMG service"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "amg.amazonaws.com"
        }
      },
    ]
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "xray_readonly_policy_attachment" {
  role       = aws_iam_role.amg.name
  policy_arn = data.aws_iam_policy.xray_readonly.arn
}

resource "aws_iam_role_policy_attachment" "prometheus_sns_policy_attachment" {
  role       = aws_iam_role.amg.name
  policy_arn = data.aws_iam_policy.prometheus_policy.arn
}