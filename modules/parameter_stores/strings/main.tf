resource "aws_ssm_parameter" "template" {
  for_each = var.parameters

  name  = each.key
  value = each.value
  type  = "String"
}
