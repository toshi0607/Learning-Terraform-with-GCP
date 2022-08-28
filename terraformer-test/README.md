```shell
$ terraform init

$ mkdir -p $HOME/.terraform.d/plugins/darwin_amd64
# plugin path is not propely handled at the time of writing
$ cp .terraform/providers/registry.terraform.io/hashicorp/google/4.32.0/darwin_arm64/terraform-provider-google_v4.32.0_x5 \
      $HOME/.terraform.d/plugins/darwin_amd64/terraform-provider-google_v4.32.0_x5

# specify your project with --projects option
$ terraformer plan google --resources=instances --filter=google_compute_instance=test-terraformer --projects=terraform-toshi0607 --regions=asia-northeast1

# specify your project with --projects option
$ terraformer import google --resources=instances --filter="google_compute_instance=test-terraformer" --projects=terraform-toshi0607 --regions=asia-northeast1
```