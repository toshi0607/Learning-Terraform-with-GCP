This example doesn't specify a credential and a project intentionally.

```shell
$ gcloud auth application-default login
$ export GOOGLE_PROJECT=terraform-toshi0607

$ terraform init
$ terraform plan
$ terraform apply
```