# POC: Pipeline de ingestão utilizando Terraform na GCP

# **Objetivos**

O objetivo desta POC é usar o Terraform para implantar em um projeto do GCP:

- um bucket para fazer upload de arquivos.
- um bucket para armazenar o código-fonte do Cloud Function.
- uma Função do Cloud que é acionada sempre que um arquivo é enviado para o primeiro bucket e cujo código-fonte está no segundo bucket.

# **Pré-requisitos**

Para executar estre projeto você vai precisar de:

- [Terraform instalado](https://learn.hashicorp.com/tutorials/terraform/install-cli) na máquina local.
- [SDK do Google Cloud instalado](https://cloud.google.com/sdk/docs/install) na máquina local.
- um [projeto do Google Cloud Platform](https://cloud.google.com/resource-manager/docs/creating-managing-projects)[conta de faturamento](https://cloud.google.com/billing/docs/how-to/modify-project)[API do Cloud Functions está ativada](https://cloud.google.com/service-usage/docs/enable-disable)

.cloud_function_pocA3Data/

│ ├── terraform/ │ │ │ ├── backend.tf │ ├── function.tf │ ├── main.tf │ ├── storage.tf │ └── variables.tf │ └── variables.tf src/ │ ├── main.py └── requirements.txt

A `src`pasta contém o código-fonte da função de nuvem. É uma estrutura específica para Python.

- `main.py`
  : código-fonte do Cloud Functions.
- `requirements.txtmain.py`
  : a lista de bibliotecas python necessárias
  para serem executadas. (você não vai precisar dele neste tutorial)

A `terraform`pasta contém os arquivos de configuração do ambiente a ser implantado.

- `backend.tf`
  declaração do [backend do Terraform](https://www.terraform.io/language/settings/backends) .
- `main.tf`
  principais declarações do ambiente.
- `variables.tf`
  definição das variáveis.
- `storage.tf`
  declaração do bucket do Google Cloud Storage.
- `function.tf`
  declaração da Função do Cloud.

# \***\*Estrutura do projeto\*\***
