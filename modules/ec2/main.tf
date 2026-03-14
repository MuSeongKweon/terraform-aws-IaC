# ec2 instance config

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "public_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = var.public_subnet_id //aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.public_sg.id]

  iam_instance_profile = var.instance_profile_name //aws_iam_instance_profile.ssm_profile.name

  associate_public_ip_address = true

  tags = {
    Name = "${var.project}-public-ec2"
  }
}

resource "aws_instance" "private_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = var.private_subnet_id //aws_subnet.private.id

  vpc_security_group_ids = [aws_security_group.private_sg.id]

  iam_instance_profile = var.instance_profile_name //aws_iam_instance_profile.ssm_profile.name

  associate_public_ip_address = false

  tags = {
    Name = "${var.project}-private-ec2"
  }
}

# Security group
resource "aws_security_group" "public_sg" {
  name        = "public-ec2-sg"
  description = "Allow ssh and http"
  vpc_id      = var.vpc_id //aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private-ec2-sg"
  description = "Allow internet traffic"
  vpc_id      = var.vpc_id //aws_vpc.main.id

  ingress {
    description = "Internet VPC traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}

