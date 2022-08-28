This example doesn't specify a credential and a project intentionally.

```shell
$ gcloud auth application-default login

# export GOOGLE_PROJECT=terraform-toshi0607
# 【YOUR PROJECT】をあなたのGCPプロジェクトに置き換えてください。
$ export GOOGLE_PROJECT=【YOUR PROJECT】

$ terraform init
$ terraform plan
$ terraform apply

# Change resource name from before-move to after-move
# Confirm resource recreation (+ create and -destroy) would happen
$ terraform plan

# Enable (comment in moved block)
# Confirm resource recreation would NOT happen
$ terraform plan
$ terraform apply

$ terraform destroy
```