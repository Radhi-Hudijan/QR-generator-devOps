## create I AM policy for EKS service account

resource "aws_iam_policy" "qr_backend_s3_policy" {
  name        = "qr-backend-s3-policy"
  description = "Allow backend to upload and read QR codes from S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::qr-test-app-2222/*"
      }
    ]
  })
}

## create IAM role for EKS service account

resource "aws_iam_role" "qr_backend_pod_role" {
  name = "qr-backend-pod-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

## attach policy to role
resource "aws_iam_role_policy_attachment" "qr_backend_s3_policy_attachment" {
  role       = aws_iam_role.qr_backend_pod_role.name
  policy_arn = aws_iam_policy.qr_backend_s3_policy.arn
}

## Associate IAM role with EKS service account

resource "aws_eks_pod_identity_association" "qr_backend" {
  cluster_name    = module.eks.cluster_name
  namespace       = "qr-code-frontend-app"
  service_account = "qr-code-backend-service-account"
  role_arn        = aws_iam_role.qr_backend_pod_role.arn
}

