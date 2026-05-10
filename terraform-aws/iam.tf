module "table_default_policies" {
  source = "github.com/SthoreH/shd-terraform-aws-iam?ref=v1.1.2"

  policies = [
    {
      name        = "${local.table_name}-ro-policy"
      description = "Policy for read only access"
      document    = templatefile("${path.module}/iam_templates/policies/ro_policy.tftpl", local.template_variables)
    },
    {
      name        = "${local.table_name}-rw-policy"
      description = "Policy for read and write access"
      document    = templatefile("${path.module}/iam_templates/policies/rw_policy.tftpl", local.template_variables)
    }
  ]

  tags = local.tags
}
