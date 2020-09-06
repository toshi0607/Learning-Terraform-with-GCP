This example doesn't specify a credential and a project intentionally.
Terraform 0.13.0 or later is required.

```shell
$ gcloud auth application-default login
$ export GOOGLE_PROJECT=terraform-toshi0607

$ terraform init
$ terraform plan
$ terraform apply
```
