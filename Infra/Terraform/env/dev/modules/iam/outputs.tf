output "instance_profile_name" {
  value = length(aws_iam_instance_profile.this) > 0 ? aws_iam_instance_profile.this[0].name : ""
}
