# Learning-Terraform-with-GCP

This repository is sample codes to learn Terraform with GCP.

Samples are explained in the below books.

* 『[Google Cloud Platformで学ぶTerraform 〜基礎編〜 @技術書典マーケット](https://techbookfest.org/product/6331235183886336)』
* 『[Google Cloud Platformで学ぶTerraform 〜基礎編〜（PDF、ePubセット） #技術書典 @BOOTH](https://toshi0607.booth.pm/items/2354817)』
* 『[Google Cloud Platformで学ぶTerraform 〜実践編〜 @技術書典マーケット](https://techbookfest.org/product/6366164626178048)』
* 『[Google Cloud Platformで学ぶTerraform 〜実践編〜（PDF、ePubセット） #技術書典 @BOOTH](https://toshi0607.booth.pm/items/2629085)』

## Basic edition

### Chapter 4 Resource and terraform command

* [basic](./basic)

### Chapter 5 How to write a configuration

* [variable](./variable)
* [output](./output)
* [locals](./locals)
* [Data sources](./data-sources)
* [count](./count)
* [for_each](./for_each)
* [dynamic](./dynamic)
* [Condition expression](./condition)
* [Version and Provider](./version-and-provider)
* [Module structure](./module-sample)
* [Module](./module-test)

### Chapter 6 State management

* [Remote backend](./remote-backend)
* [Separate state by backend end environment](./state-separation)
* [terraformer](./terraformer-test)
* [moved](./moved)

## Practical edition

### Chapter 3 Two-layer architecture

* [Two-layer architecture](./two-layer-architecture)

### Chapter 4 ~ 7, 9, 10 GKE + Microservices template

Diffrent repository: [toshi0607/GKE-Microservices-Terraform-project-template](https://github.com/toshi0607/GKE-Microservices-Terraform-project-template)

### Chapter 8 Lint and validation

* [Lint and validation](./lint-and-validation/)
  * [terraform fmt](./lint-and-validation/terraform-fmt)
  * [terraform validate](./lint-and-validation/terraform-validate)
  * [TFLint](./lint-and-validation/tflint)
  * [Conftest](./lint-and-validation/conftest)
