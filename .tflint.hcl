config {
    plugin_dir = "./.tflint.d/plugins"

    module = true
    force = false
    disabled_by_default = false
}

plugin "aws" {
    enabled = true
    version = "0.21.2"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_deprecated_index" {
    enabled = true
}

rule "terraform_deprecated_interpolation" {
    enabled = true
}

rule "terraform_empty_list_equality" {
    enabled = true
}

rule "terraform_module_pinned_source" {
    enabled = true
}

rule "terraform_module_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = false
}

rule "terraform_required_version" {
  enabled = false
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
}
