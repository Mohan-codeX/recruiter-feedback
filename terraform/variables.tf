variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  type        = string
  default     = "ap-south-2"
}

variable "vpc_cidr" {
  description = "The IP range for the entire AWS VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The IP range for the public subnet hosting the Kubernetes EC2 nodes."
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "The Availability Zone where the public subnet will be created."
  type        = string
  default     = "ap-south-2c"
}

variable "ami_id" {
  description = "The Ubuntu AMI ID used by the Kubernetes nodes."
  type        = string
}

variable "control_plane_instance_type" {
  description = "The EC2 instance type used for the Kubernetes control-plane node."
  type        = string
  default     = "c7i-flex.large"
}

variable "worker_instance_type" {
  description = "The EC2 instance type used for the Kubernetes worker nodes."
  type        = string
  default     = "t3.small"
}

variable "key_pair_name" {
  description = "The name of the SSH key pair registered in AWS for node access."
  type        = string
  default     = "recruiter-feedback-k8s"
}

variable "project_name" {
  description = "The naming prefix used for AWS resources and tags."
  type        = string
  default     = "recruiter-feedback"
}
