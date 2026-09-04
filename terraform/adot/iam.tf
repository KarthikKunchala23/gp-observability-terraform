data "aws_iam_policy_document" "adot_collector_assume" {
  statement {
    sid = "PodIdentity"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "adot_collector_policy" {
    name = "gp-adot-collector-policy_dev_platform"
}

resource "aws_iam_role" "adot_collector" {
  name = "${data.aws_eks_cluster.this.name}-adot-collector-role"
  assume_role_policy = data.aws_iam_policy_document.adot_collector_assume.json
}

resource "aws_iam_role_policy_attachment" "adot_collector_policy_attachment" {
  role       = aws_iam_role.adot_collector.name
  policy_arn = data.aws_iam_policy.adot_collector_policy.arn
}