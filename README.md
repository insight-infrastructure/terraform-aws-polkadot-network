# terraform-aws-polkadot-network

## Features

This module sets up VPCs, DNS zones, and security groups for running validator nodes on polkadot.

## Terraform versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/terraform-aws-polkadot-network"
}
```

## Examples

- [simple](https://github.com/insight-infrastructure/terraform-aws-polkadot-network/tree/master/examples/simple)

## Known issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| cloudflare | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| all\_enabled | Bool to enable all the security groups | `bool` | `false` | no |
| allow\_ssh\_commands | Allows the SSH user to execute one-off commands. Pass 'True' to enable. Warning: These commands are not logged and increase the vulnerability of the system. Use at your own discretion. | `string` | `""` | no |
| api\_enabled | Boolean to allow api related traffic | `bool` | `false` | no |
| api\_sg\_name | Name for the api security group | `string` | `"api-sg"` | no |
| azs | List of availability zones | `list(string)` | `[]` | no |
| bastion\_enabled | Boolean to enable a bastion host.  All ssh traffic restricted to bastion | `bool` | `false` | no |
| bastion\_host\_name | The hostname for bastion | `string` | `"bastion"` | no |
| bastion\_instance\_type | The instance type of the bastion instances. | `string` | `"t2.nano"` | no |
| bastion\_monitoring\_enabled | Cloudwatch monitoring on bastion | `bool` | `true` | no |
| bastion\_sg\_name | Name for the bastion security group | `string` | `"bastion-sg"` | no |
| bucket\_force\_destroy | The bucket and all objects should be destroyed when using true | `bool` | `false` | no |
| bucket\_name | Bucket name were the bastion will store the logs | `string` | `""` | no |
| bucket\_versioning | Enable bucket versioning or not | `bool` | `true` | no |
| cidr | The cidr range for network | `string` | `"10.0.0.0/16"` | no |
| cloudflare\_enable | Make records in cloudflare | `bool` | `false` | no |
| consul\_enabled | Boolean to allow consul traffic | `bool` | `false` | no |
| consul\_sg\_name | Name for the consult security group | `string` | `"consul-sg"` | no |
| corporate\_ip | The corporate IP you want to restrict ssh traffic to | `string` | `""` | no |
| create\_bastion | Bool to create bastion instance | `bool` | `false` | no |
| create\_internal\_domain | Boolean to create an internal split horizon DNS | `bool` | `false` | no |
| create\_public\_regional\_subdomain | Boolean to create regional subdomain - ie us-east-1.example.com | `bool` | `false` | no |
| domain\_name | #### DNS #### | `string` | `""` | no |
| extra\_user\_data\_content | Additional scripting to pass to the bastion host. For example, this can include installing postgresql for the `psql` command. | `string` | `""` | no |
| hids\_enabled | Boolean to enable intrusion detection systems traffic | `bool` | `false` | no |
| hids\_sg\_name | Name for the HIDS security group | `string` | `"hids-sg"` | no |
| id | A unique identifier for the deployment | `string` | `""` | no |
| internal\_tld | The top level domain for the internal DNS | `string` | `"internal"` | no |
| k8s\_enabled | Boolean to enable kubernetes | `bool` | `false` | no |
| k8s\_sg\_name | Name for the consult security group | `string` | `"k8s-sg"` | no |
| log\_auto\_clean | Enable or not the lifecycle | `bool` | `false` | no |
| log\_expiry\_days | Number of days before logs expiration | `number` | `90` | no |
| log\_glacier\_days | Number of days before moving logs to Glacier | `number` | `60` | no |
| log\_standard\_ia\_days | Number of days before moving logs to IA Storage | `number` | `30` | no |
| logging\_enabled | Boolean to allow logging related traffic | `bool` | `false` | no |
| logging\_sg\_name | Name for the logging security group | `string` | `"logging-sg"` | no |
| monitoring\_enabled | Boolean to for prometheus related traffic | `bool` | `false` | no |
| monitoring\_sg\_name | Name for the monitoring security group | `string` | `"monitoring-sg"` | no |
| name | The name of the deployment | `string` | `"polkadot-api"` | no |
| namespace | The namespace to deploy into | `string` | `"polkadot"` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `"kusama"` | no |
| num\_azs | The number of AZs to deploy into | `number` | `0` | no |
| polkadot\_network\_settings | Map of port settings for one or more polkadot networks | `map(map(string))` | <pre>{<br>  "polkadot": {<br>    "api_health": "5500",<br>    "json_rpc": "9933",<br>    "name": "polkadot",<br>    "polkadot_prometheus": "9610",<br>    "shortname": "polkadot",<br>    "ws_rpc": "9944"<br>  }<br>}</pre> | no |
| public\_key\_paths | List of paths to public ssh keys | `list(string)` | `[]` | no |
| public\_ssh\_port | Set the SSH port to use from desktop to the bastion | `number` | `22` | no |
| root\_domain\_name | The public domain | `string` | `""` | no |
| subdomain | The subdomain | `string` | `""` | no |
| tags | The tags of the deployment | `map(string)` | `{}` | no |
| validator\_enabled | Boolean to allow validator related traffic | `bool` | `false` | no |
| validator\_sg\_name | Name for the validator security group | `string` | `"validator-sg"` | no |
| vpc\_name | The name of the VPC | `string` | `""` | no |
| zone\_id | The zone ID to configure as the root zoon - ie subdomain.example.com's zone ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| api\_security\_group\_id | n/a |
| azs | n/a |
| bastion\_security\_group\_id | #### SGs #### |
| consul\_security\_group\_id | n/a |
| hids\_security\_group\_id | n/a |
| internal\_tld | n/a |
| k8s\_security\_group\_id | n/a |
| logging\_security\_group\_id | n/a |
| monitoring\_security\_group\_id | n/a |
| private\_subnets | n/a |
| private\_subnets\_cidr\_blocks | n/a |
| public\_regional\_domain | n/a |
| public\_subnet\_cidr\_blocks | n/a |
| public\_subnets | n/a |
| root\_domain\_name | #### DNS #### |
| validator\_security\_group\_id | n/a |
| vpc\_id | #### VPC #### |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [{{ cookiecutter.owner }}](github.com/{{ cookiecutter.owner }})

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.