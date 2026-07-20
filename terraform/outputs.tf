# 1. Control Plane Public IP
output "control_plane_public_ip" {
  description = "The public IPv4 address of the Kubernetes control plane node for SSH access."
  value       = aws_instance.control_plane.public_ip
}

# 2. Control Plane Private IP
output "control_plane_private_ip" {
  description = "The internal private IPv4 address of the control plane node for cluster communication."
  value       = aws_instance.control_plane.private_ip
}

# 3. Worker Public IPs (Splat Expression)
output "worker_public_ips" {
  description = "The list of public IPv4 addresses for the worker nodes for SSH access."
  value       = aws_instance.worker[*].public_ip
}

# 4. Worker Private IPs (Splat Expression)
output "worker_private_ips" {
  description = "The list of internal private IPv4 addresses for the worker nodes for cluster communication."
  value       = aws_instance.worker[*].private_ip
}
