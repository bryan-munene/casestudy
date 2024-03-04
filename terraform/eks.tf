module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.5.0"

  cluster_name    = var.eks.name
  cluster_version = var.eks.version

  cluster_endpoint_public_access  = true # Should be switched to private endpoint for security

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids = [
    module.vpc.private_subnets[0], 
    module.vpc.private_subnets[1], 
  ]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.micro"]
  }

  eks_managed_node_groups = {
    base = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      instance_types = ["t2.micro"]

      capacity_type  = "ON_DEMAND"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true
  
  tags = var.tags
}