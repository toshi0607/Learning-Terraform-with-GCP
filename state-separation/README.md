```shell
# Bucket name must be globally unique. Change toshi0607-20200827 to waht you like.
$ gsutil mb -l ASIA-NORTHEAST1 gs://tf-state-toshi0607-20200827-dev

#
# development
#
$ cd development
# Update main.tf

$ terraform init
$ terraform plan
$ terraform apply
$ terraform destroy

#
# production
#
$ cd ../production
# Bucket name must be globally unique. Change toshi0607-20200827 to waht you like.
$ gsutil mb -l ASIA-NORTHEAST1 gs://tf-state-toshi0607-20200827-prod
Creating gs://tf-state-toshi0607-0827-prod/...
# Update main.tf

$ terraform init
$ terraform plan
$ terraform apply
$ terraform destroy
```
