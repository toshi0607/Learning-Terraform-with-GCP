This example doesn't specify a credential and a project intentionally.

```shell
$ gcloud auth application-default login

# export GOOGLE_PROJECT=terraform-toshi0607
# 【YOUR PROJECT】をあなたのGCPプロジェクトに置き換えてください。
$ export GOOGLE_PROJECT=【YOUR PROJECT】

$ terraform init
$ terraform plan
$ terraform apply
```
