resource "aws_security_group" "kubernetes" {
  name        = "${var.project_name}-cluster-sg"
  description = "Security group for kubeadm Kubernetes cluster nodes"
  vpc_id      = aws_vpc.main.id

  # 1. Secure SSH Access (Restricted to your IP)
  ingress {
    description = "SSH administration"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.50.200.242/32"]
  }

  # 2. Secure Kubernetes API Server (Restricted to your IP)
  ingress {
    description = "Kubernetes API Server access"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["157.50.200.242/32"]
  }

  # 3. NGINX Ingress HTTP NodePort (Restricted to your IP)
  ingress {
    description = "NGINX Ingress HTTP access"
    from_port   = 31584
    to_port     = 31584
    protocol    = "tcp"
    cidr_blocks = ["157.50.200.242/32"]
  }

  # 4. Full Internal Communication (Intra-cluster traffic)
  ingress {
    description = "Allow all internal traffic between cluster nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # 5. Outbound Internet Access (Egress)
  egress {
    description = "Allow all outbound traffic for packages, updates, and images"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-cluster-sg"
  }
}