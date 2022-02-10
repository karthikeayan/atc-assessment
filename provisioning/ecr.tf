resource "aws_ecr_repository" "atc_nod_app" {
  name                 = "atc-node-app"
  image_tag_mutability = "IMMUTABLE"
}