```console
$ brew tap instrumenta/instrumenta
$ brew install conftest

$ conftest test --namespace tf main.tf

$ terraform init
$ terraform plan --out plan.out 2>&1
$ terraform show -json plan.out > plan.out.json
$ conftest test --namespace plan plan.out.json
```