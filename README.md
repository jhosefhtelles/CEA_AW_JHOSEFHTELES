# Adventure Works - Projeto dbt & Modern Data Stack

Este repositório contém o pipeline de dados da **Adventure Works**, estruturado para transformar dados transacionais brutos em um modelo dimensional (**Star Schema**) otimizado para Business Intelligence. O projeto utiliza o **dbt (data build tool)** sobre a infraestrutura do **Databricks (Lakehouse)**.

## 🎯 Objetivo
O foco principal é a conversão dos dados complexos do ERP Adventure Works em uma camada de negócios confiável, garantindo integridade referencial, métricas calculadas e documentação completa da linhagem dos dados.

---

## 🛠️ Tecnologias Utilizadas
* **Data Warehouse:** [Databricks](https://databricks.com/) (Spark SQL)
* **Transformação de Dados:** [dbt Core](https://www.getdbt.com/) (v1.11)
* **Linguagem de Modelagem:** SQL & Jinja
* **Pacotes dbt:** `dbt_utils`
* **Dataset:** Microsoft Adventure Works

---

## 🏗️ Estrutura de Camadas (Medallion Architecture)

O pipeline segue uma estrutura modular para garantir manutenibilidade e escalabilidade:

### 1. Camada de Origem (Sources/Raw)
Mapeamento direto dos dados brutos no Databricks. As definições de tabelas e descrições de colunas foram centralizadas em arquivos `.yml` para garantir que o contexto do dado venha desde a fonte.

### 2. Camada de Staging (Silver)
Camada de limpeza inicial.
* **Padronização:** Renomeação de colunas e `cast` de tipos de dados.
* **Saneamento:** Filtros para remover registros inconsistentes (ex: tratamento de nulos em `countryregioncode`).
* **Performance:** Materialização como `view` para garantir que os dados reflitam as mudanças da origem em tempo real.

### 3. Camada Intermediate
Onde a lógica de negócio é consolidada antes da entrega final.
* **Consolidação:** Joins complexos entre Pessoas, Endereços, Pedidos e Motivos de Venda.
* **Transformação:** Cálculo de métricas financeiras como **Valor Bruto** (Qtd * Preço Unitário) e **Valor Líquido** (após descontos).

### 4. Camada Marts (Gold)
Entrega final no formato **Star Schema** (Dimensões e Fatos).
* **Dimensões:** `d_produtos`, `d_clientes`, `d_localidades`, `d_cartoes`, `d_motivo_venda` e `d_datas`.
* **Fato:** `f_vendas` (Tabela central que conecta todas as dimensões).
* **Surrogate Keys:** Utilização de chaves únicas geradas para garantir integridade.

---

## 📊 Modelo Conceitual e Entrega

Para facilitar a exploração dos dados transformados, os seguintes recursos estão disponíveis:

### 1. Modelo Conceitual (Star Schema)
O diagrama representa a estrutura de dados final na camada Gold, demonstrando como a tabela fato se relaciona com as dimensões.
* 🖼️ **Visualizar Modelo:** [Link para a Imagem do Modelo Conceitual/Diagrama]

### 2. Dashboard Power BI
O relatório final com os KPIs de vendas e análises regionais.
* 📥 **Download .PBIX:** [Link para o arquivo Power BI anexado]

### 3. Apresentação do Projeto
Vídeo demonstrativo com a explicação técnica de ponta a ponta.
* 🎬 **Assistir Vídeo:** [Link do Drive com a apresentação do projeto]

---

## 🧪 Qualidade e Governança de Dados
A confiança nos dados é garantida através de testes automatizados:

* **Testes de Unicidade e Nulidade:** Aplicados em todas as chaves primárias.
* **Integridade Referencial:** Testes de `relationships` na tabela fato para garantir que não existam registros órfãos.
* **Auditoria Financeira:** Teste customizado `verifica_soma_vendas_2011` que valida se o total faturado no ano de 2011 está alinhado com a contabilidade.

---

## 🚀 Como Executar este Projeto

1. **Instalar Dependências:**
   ```bash
   dbt deps