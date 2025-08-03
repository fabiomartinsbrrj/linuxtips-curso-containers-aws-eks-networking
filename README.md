# linuxtips-curso-containers-aws-eks-networking
Centralização da criação de recursos de Networking do modulo de EKS

Criar a fundação de Networking necessária para realização do projeto.


Os id`s das subnets estarão no SSM.

![alt text](<assets/Kubernetes-K8S Networking.jpg>)


## Issues a serem trabalhadas

1. **Modularização**  
    Converta o código existente em um módulo de Terraform. Um módulo bem estruturado é essencial para reaproveitamento e padronização em múltiplos projetos. Este exercício ajudará a "produtizar" a criação de networkings na AWS sob demanda.

2. **Documentação**  
    Crie uma documentação clara e objetiva sobre como utilizar o módulo desenvolvido. Utilize ferramentas como o Terraform Docs para facilitar a geração e manutenção da documentação.

3. **Mais parametrizações**  
    Adicione variáveis ao módulo para torná-lo mais flexível, permitindo configurações personalizadas de elementos como CIDR blocks, tags, regras de segurança e outras configurações importantes que atualmente estão mockadas ou com valores fixos.

4. **Produtização das Regras de NACL's**  
    Refine as regras de NACL (Network Access Control Lists) para torná-las mais completas e alinhadas com as boas práticas de segurança. Certifique-se de que as regras sejam fáceis de entender e reutilizar.

    ## Tocando de conta AWS

    Para alternar entre contas AWS durante o desenvolvimento ou execução dos recursos:

    1. **Configure um novo perfil AWS CLI**  
        ```sh
        aws configure
        ```

    2. **Verifique o perfil ativo**
        ```sh
        aws sts get-caller-identity
        ```

    3. **Remova os arquivos  terraform**  
        ```sh
        export AWS_REGION=us-east-1
        rm -f .terraform/terraform.tfstate .terraform/terraform.tfstate.backup
        ```

    5. **Crie novamente o ambiente** 
        ```sh
        terraform init
        ```
