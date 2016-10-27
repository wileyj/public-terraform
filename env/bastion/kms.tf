module "kms" {
  source = "../../modules/kms/"
  name = "${var.name}"
  group = "VPC"
  description = "VPC/${var.name} KMS asset"
}
