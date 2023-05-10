variable "environment" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "allow_vpces" {
  type = list(string)
}
variable "lambda_function_arn" {
  type = string
}
