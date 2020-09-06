This example doesn't specify a credential and a project intentionally.

```shell
$ gcloud auth application-default login
$ export GOOGLE_PROJECT=terraform-toshi0607

$ terraform init
$ terraform plan

$ terraform plan -var="vm_enable=true"
$ terraform apply -var="vm_enable=true"

$ terraform destroy
```
