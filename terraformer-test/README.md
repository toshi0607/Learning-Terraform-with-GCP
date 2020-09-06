Terraform 0.12 or ealier is required at the time of writing.

```shell
$ terraform init

$ terraformer plan google --resources=instances --filter=google_compute_instance=test-terraformer --projects=terraform-toshi0607 --regions=asia-northeast1

$ terraformer import google --resources=instances --filter="google_compute_instance=test-terraformer" --projects=terraform-toshi0607 --regions=asia-northeast1
```