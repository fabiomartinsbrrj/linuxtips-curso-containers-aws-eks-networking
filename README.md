# linuxtips-curso-containers-aws-eks-networking

Centralização da criação de recursos de Networking do modulo de EKS

Criar a fundação de Networking necessária para realização do projeto.

Os id`s das subnets estarão no SSM.

![alt text](<assets/Kubernetes-K8S Networking.jpg>)

## Serviços AWS Utilizados

Este projeto cria uma infraestrutura de networking robusta na AWS utilizando os seguintes serviços:

### **Networking Core**

- **VPC (Virtual Private Cloud)**: Rede virtual principal com suporte a CIDRs adicionais
- **Subnets**: Três tipos de subnets distribuídas em múltiplas AZs:
  - **Public Subnets**: Para recursos que precisam de acesso direto à internet
  - **Private Subnets**: Para recursos internos com acesso à internet via NAT Gateway
  - **Database Subnets**: Para bancos de dados com controle de acesso restrito
- **Internet Gateway**: Gateway para acesso à internet das subnets públicas
- **NAT Gateway**: Gateway para acesso à internet das subnets privadas (um por AZ)
- **Elastic IP**: IPs estáticos associados aos NAT Gateways

### **Roteamento e Segurança**

- **Route Tables**: Tabelas de roteamento específicas para cada tipo de subnet
- **Network ACL**: Controle de acesso em nível de subnet para databases com regras específicas:
  - Porta 3306 (MySQL) liberada para subnets privadas
  - Porta 6379 (Redis) liberada para subnets privadas
  - Negação de todo tráfego de entrada por padrão
  - Permissão de todo tráfego de saída

### **Gerenciamento de Estado e Configuração**

- **S3**: Backend para armazenamento remoto do Terraform state
- **Systems Manager Parameter Store**: Armazenamento dos IDs dos recursos para consumo por outros módulos:
  - ID da VPC
  - IDs das subnets públicas, privadas e de database
  - Organização hierárquica por projeto, tipo e zona de disponibilidade

### **Características da Arquitetura**

- **Multi-AZ**: Distribuição em múltiplas zonas de disponibilidade para alta disponibilidade
- **Escalabilidade**: Suporte a CIDRs adicionais para expansão da rede
- **Segurança em Camadas**: NACLs específicas para isolamento de databases
- **Integração**: Parameter Store facilita o consumo por outros módulos (ex: EKS)
- **Flexibilidade**: Configuração parametrizada via variáveis Terraform

## Issues a serem trabalhadas

1. **Modularização**  
    Converta o código existente em um módulo de Terraform. Um módulo bem estruturado é essencial para reaproveitamento e padronização em múltiplos projetos. Este exercício ajudará a "produtizar" a criação de networkings na AWS sob demanda.

2. **Documentação**  
    Crie uma documentação clara e objetiva sobre como utilizar o módulo desenvolvido. Utilize ferramentas como o Terraform Docs para facilitar a geração e manutenção da documentação.

3. **Mais parametrizações**  
    Adicione variáveis ao módulo para torná-lo mais flexível, permitindo configurações personalizadas de elementos como CIDR blocks, tags, regras de segurança e outras configurações importantes que atualmente estão mockadas ou com valores fixos.

4. **Produtização das Regras de NACL's**  
    Refine as regras de NACL (Network Access Control Lists) para torná-las mais completas e alinhadas com as boas práticas de segurança. Certifique-se de que as regras sejam fáceis de entender e reutilizar.

## Trocando de conta AWS

Para alternar entre contas AWS durante o desenvolvimento ou execução dos recursos:

1. **Configure um novo perfil AWS CLI**  

    ```sh
    aws configure
    ```

2. **Verifique o perfil ativo**

    ```sh
    aws sts get-caller-identity
    ```

3. **Remova os arquivos terraform**  

    ```sh
    export AWS_REGION=us-east-1
    rm -f .terraform/terraform.tfstate .terraform/terraform.tfstate.backup
    ```

4. **Crie novamente o ambiente**

    ```sh
    terraform init
    ```

## Documentação Técnica

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.90.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_association.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_rule.allow_3306](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.allow_6379](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.deny](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_ssm_parameter.database_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_ipv4_cidr_block_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | Lista de Databases Subnets da VPC | <pre>list(object({<br>    name              = string<br>    cidr              = string<br>    availability_zone = string<br>  }))</pre> | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Lista de Private Subnets da VPC | <pre>list(object({<br>    name              = string<br>    cidr              = string<br>    availability_zone = string<br>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Nome do projeto | `string` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Lista de Public Subnets da VPC | <pre>list(object({<br>    name              = string<br>    cidr              = string<br>    availability_zone = string<br>  }))</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Região AWS | `string` | n/a | yes |
| <a name="input_vpc_additional_cidrs"></a> [vpc\_additional\_cidrs](#input\_vpc\_additional\_cidrs) | Lista de CIDRS adicionais da VPC | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR principal da VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | The IDs of the database subnets |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | The IDs of the private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | The IDs of the public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->
