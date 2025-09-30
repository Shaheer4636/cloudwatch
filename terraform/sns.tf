module "sns-subtopic" {
  source         = "../sns-subtopic"
  application    = var.appname
  environment    = var.env
  create_topics  = true
  tags           = local.tags
}
