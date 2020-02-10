# {{ cookiecutter.module_name }}

## Features

This module...

## Terraform versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/"

}
```

## Examples

- [simple](https://github.com/{{ cookiecutter.owner }}/{{ cookiecutter.module_name }}/tree/master/examples/simple)

## Known issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| azs | n/a | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| bastion\_enabled | n/a | `bool` | `false` | no |
| bastion\_sg\_name | n/a | `string` | `"bastion-sg"` | no |
| consul\_enabled | n/a | `bool` | `false` | no |
| consul\_sg\_name | n/a | `string` | `"consul-sg"` | no |
| corporate\_ip | n/a | `string` | `""` | no |
| create\_internal\_domain | n/a | `bool` | `false` | no |
| create\_public\_regional\_subdomain | n/a | `bool` | `false` | no |
| environment | ###### Label ###### | `string` | `""` | no |
| hids\_enabled | n/a | `bool` | `false` | no |
| hids\_sg\_name | n/a | `string` | `"hids-sg"` | no |
| internal\_tld | #### DNS #### | `string` | `"internal"` | no |
| logging\_enabled | n/a | `bool` | `false` | no |
| logging\_sg\_name | n/a | `string` | `"bastion-sg"` | no |
| monitoring\_enabled | n/a | `bool` | `false` | no |
| monitoring\_sg\_name | n/a | `string` | `"monitoring-sg"` | no |
| namespace | n/a | `string` | `""` | no |
| network\_name | n/a | `string` | `""` | no |
| owner | n/a | `string` | `""` | no |
| public\_node\_sg\_name | n/a | `string` | `"public-sg"` | no |
| root\_domain\_name | n/a | `string` | `""` | no |
| stage | n/a | `string` | `""` | no |
| vault\_enabled | n/a | `bool` | `false` | no |
| vault\_sg\_name | n/a | `string` | `"bastion-sg"` | no |
| vpc\_name | #### VPC #### | `string` | `""` | no |
| zone\_id | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [{{ cookiecutter.owner }}](github.com/{{ cookiecutter.owner }})

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.