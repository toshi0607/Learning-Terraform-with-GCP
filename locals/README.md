This example doesn't specify a credential and a project intentionally.
Terraform 0.13.0 or later is required.

```shell
$ gcloud auth application-default login

# replace 【YOUR PROJECT】 with your project
# e.g.
# export GOOGLE_PROJECT=terraform-toshi0607
$ export GOOGLE_PROJECT=【YOUR PROJECT】

$ terraform init
$ terraform plan
$ terraform apply
$ terraform destroy
```
