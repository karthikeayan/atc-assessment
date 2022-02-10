module "eks_additional_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-eks-additional"
  description = "Security group for EKS Cluster"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = [module.vpc.vpc_cidr_block]

#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 8080
#       to_port     = 8090
#       protocol    = "tcp"
#       description = "User-service ports"
#       cidr_blocks = "10.10.0.0/16"
#     },
#     {
#       rule        = "postgresql-tcp"
#       cidr_blocks = "0.0.0.0/0"
#     },
#   ]
}