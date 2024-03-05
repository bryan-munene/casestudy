# Emirates Group Case Study

## Overview

This repo is divided into 2 main sections(directories):

1. [terraform](./terraform/): Contains terraform files to create an EKS cluster.
2. [helm](./terraform/): A helm chart to deploy nginx on the EKS cluster created above.

### [Terraform](./terraform/)

AWS resources are defined as code. 2 main components are created here using upstream official terraform modules. EKS(kubernetes cluster) and the VPC(private network) in which it resides.

### [Helm](./terraform/)

Related Kubernetes objects are together to be shipped as one. In this helm chart we have:

1. [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
2. [HorizontalPodAutoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
3. [PodDisruptionBudget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/)
4. [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

The [values file](./helm/values.yaml) allows you to pass in different configuration values, making this more flexible than using plain kubernetes manifests. This is one of the main advantages of using helm.

## Implementation

### Pre-Requisites

1. [AWS account](https://aws.amazon.com/console/): Create an account and then [create an IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html). [Create access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) for the user and store them safely.
2. [Terraform](https://www.terraform.io/): Install the [client](https://developer.hashicorp.com/terraform/install?product_intent=terraform).
3. [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl): Install the [client](https://kubernetes.io/docs/tasks/tools/#kubectl).
4. [helm](https://helm.sh/): Install the [client](https://helm.sh/docs/intro/install/).
5. [AWS CLI](https://aws.amazon.com/cli/): Install the [client](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
6. [Metric server](https://github.com/kubernetes-sigs/metrics-server?tab=readme-ov-file#installation): This will need to be installed for HPA to work.

### [Terraform](./terraform/)

To execute terraform, first need to prepare the environment.

```bash
export AWS_ACCESS_KEY_ID=<YOUR AWS ACCESS KEY ID>
export AWS_SECRET_ACCESS_KEY=<YOUR AWS SECRET ACCESS KEY>
```

You'll need to run these commands at the base of the repo to create the S3 bucket to be used to store state files.

```bash
terraform init
terraform plan
terraform apply
```

Then repeat the same commands inside the `./terraform` directory. This will create a VPC and an EKS cluster running on the VPC.

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Once this is done you will need to [update you kubernetes context file](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html) with the info for the cluster. Necessary for next step to work.

### [Helm](./terraform/)

Once you have the correct kubernetes context set, to deploy the helm chart run:

```bash
helm upgrade casestudy ./helm --install --timeout 90s -f ./helm/values.yaml --create-namespace --namespace casestudy-ns
```

This will create the namespace, if it does not already exist, then deploy the helm chart contents to that namespace.
To deploy new changes, run the same command again.
