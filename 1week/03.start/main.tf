# resource "local_file" "abc" {
#   content  = "123!"
#   filename = "${path.module}/abc.txt"
# }

# resource "local_file" "def" {
#   content  = "456!"
#   filename = "${path.module}/def.txt"

#   depends_on = [ local_file.abc ]
# }
variable "file_name" {
  default = "step11.txt"
}

resource "local_file" "abc" {
  content  = "lifecycle - step 6"
  filename = "${path.module}/${var.file_name}"

  lifecycle {
    postcondition {
      condition     = contains(["step0.txt", "step1.txt", "step2.txt", "step3.txt", "step4.txt", "step5.txt", "step6.txt", "step7.txt"], "${var.file_name}")
      error_message = "file name is not \"step6.txt\""
    }
  }
}
