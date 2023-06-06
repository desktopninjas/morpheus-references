# ECS Standard Module
## Overview
This module provides a standard configuration for deploying services on Amazon Elastic Container Service (ECS).

## Features
- Standardized ECS service and task definition configuration.
- Integration with AWS Fargate for serverless compute for containers.
- Support for both public and private subnets.
- Auto-scaling configuration.
- Load balancing support.

## Prerequisites
- Terraform v0.14.0 or later.
- AWS CLI v2.0 or later.
- An AWS account with the necessary permissions to create and manage the aforementioned resources.

## Usage
Include this module in your Terraform configuration file with the following code:

```hcl
module "ecs_standard" {
  source = "github.com/desktopninjas/morpheus-references/tf-modules/ecs-standard"

  // insert required variables here
}
```

## Variables
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| `cluster_name` | The name of the ECS cluster | `string` | `default-cluster` | No |
| `instance_type` | The instance type of the EC2 instances in the cluster | `string` | `t2.micro` | No |
| `min_size` | The minimum number of instances in the cluster | `number` | `1` | No |
| `max_size` | The maximum number of instances in the cluster | `number` | `2` | No |
| `desired_capacity` | The desired number of instances in the cluster | `number` | `1` | No |
| `iam_instance_profile` | Instance role to apply to instances in the ECS cluster | `number` | `1` | No |
| `key_name` | The name of the key pair to use for the instances | `string` | `your-key-pair` | No |
| `image_id` | The ID of the AMI to use for the instances | `string` | `ami-0c94855ba95c574c8` | No |
| `cis_hardening_script` | HTTPS path to the CIS hardening script to be executed on the node after startup | `string` | `https://location-to-your-script/cis-hardening-script.sh` | No |
| `tags` | A map of tags to add to all resources | `map(string)` | `{}` | No |

## Outputs
No outputs as of now.