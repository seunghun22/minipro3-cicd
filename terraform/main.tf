provider "aws" {
  region = "us-east-2"
}

# EC2 IAM 역할
resource "aws_iam_role" "ec2_role" {
  name = "minipro3_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# EC2 IAM 인스턴스 프로파일
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "minipro3_ec2_profile"
  role = aws_iam_role.ec2_role.name
}

# 보안 그룹
resource "aws_security_group" "web_sg" {
  name        = "minipro3-web-sg"
  description = "Security group for web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 인스턴스
resource "aws_instance" "web" {
  ami           = "ami-024e6efaf93d85776"  # us-east-2 Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  
  tags = {
    Name = "minipro3-web"
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y ruby wget
              wget https://aws-codedeploy-us-east-2.s3.amazonaws.com/latest/install
              chmod +x ./install
              sudo ./install auto
              EOF
}
# CodeDeploy 역할
resource "aws_iam_role" "codedeploy_service_role" {
  name = "minipro3_codedeploy_service_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_service_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_service_role.name
}

# CodeDeploy 애플리케이션
resource "aws_codedeploy_app" "web_app" {
  name = "minipro3-app"
}

# CodeDeploy 배포 그룹
resource "aws_codedeploy_deployment_group" "web_deploy_group" {
  app_name               = aws_codedeploy_app.web_app.name
  deployment_group_name  = "minipro3-deploy-group"
  service_role_arn      = aws_iam_role.codedeploy_service_role.arn

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"  # 이 부분 수정
    deployment_type   = "IN_PLACE"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "minipro3-web"
    }
  }
}