This example doesn't specify a credential and a project intentionally.

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
