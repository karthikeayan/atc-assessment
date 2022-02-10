module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = local.name
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  # Refer the VPC and Subnets created with VPC Module
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    disk_size              = 50
    instance_types         = ["t3.small"]
    vpc_security_group_ids = [module.eks_additional_sg.security_group_id]
  }

  # Setting it to smaller size to save AWS billing
  eks_managed_node_groups = {
    atc-node-app = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"

      labels = {
          Environment = "atc-assessment"
          GithubRepo  = "terraform-aws-eks"
          GithubOrg   = "terraform-aws-modules"
      }

      tags = local.tags
    }
  }

  tags = local.tags
}