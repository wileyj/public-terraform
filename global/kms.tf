module "global_kms_base" {
  source = "../modules/kms/"
  name = "Base"
  group = "Global"
  description = "Global/Base KMS asset"
}
