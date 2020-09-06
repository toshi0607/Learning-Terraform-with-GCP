```shell
# Bucket name must be globally unique. Change toshi0607-20200827 to waht you like.
$ gsutil mb -l ASIA-NORTHEAST1 gs://tf-state-toshi0607-20200827-dev
# Update main.tf

$ terraform init
$ terraform plan
$ terraform apply
$ terraform destroy
```
