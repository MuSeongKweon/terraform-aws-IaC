# ec2 instance config

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "public_ec2" {
  ami = data.aws_ami.amazon_linux.id 
  instance_type = "t3.micro"
  
  subnet_id = aws_subnet.public.id
  
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  associate_public_ip_address = true
  
  tags = {
    Name = "${var.project}-public-ec2"
  }
}

resource "aws_instance" "private_ec2" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  
  subnet_id = aws_subnet.private.id
  
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  associate_public_ip_address = false
  
  tags = {
    Name = "${var.project}-private-ec2"
  }
}

