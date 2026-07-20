resource "aws_key_pair" "deployer" {
  key_name   = var.key_pair_name
  public_key = file(pathexpand("~/.ssh/recruiter-feedback-k8s.pub"))

  tags = {
    Name = "${var.project_name}-key"
  }
}
