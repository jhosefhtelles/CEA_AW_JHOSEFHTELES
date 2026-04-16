# Adventure Works - Projeto dbt & Modern Data Stack

Este repositório contém o pipeline de dados da **Adventure Works**, estruturado para transformar dados transacionais brutos em um modelo dimensional (**Star Schema**) otimizado para Business Intelligence. O projeto utiliza o **dbt (data build tool)** sobre a infraestrutura do **Databricks (Lakehouse)**.

## 🎯 Objetivo
O foco principal é a conversão dos dados complexos do ERP Adventure Works em uma camada de negócios confiável, garantindo integridade referencial, métricas calculadas e documentação completa da linhagem dos dados.

---

## 🏗️ Estrutura de Camadas (Medallion Architecture)

O pipeline segue uma estrutura modular para garantir manutenibilidade e escalabilidade:

### 1. Camada de Origem (Sources/Raw)
Mapeamento direto dos dados brutos no Databricks.

### 2. Camada de Staging (Silver)
Limpeza, padronização de tipos e saneamento de dados.

### 3. Camada Intermediate
Consolidação de joins complexos e cálculo de métricas de negócio (Valor Bruto e Líquido).

### 4. Camada Marts (Gold)
Entrega final no formato **Star Schema** (Dimensões e Fatos).

---

## 📊 Modelo Conceitual e Entrega

### 1. Modelo Conceitual (Star Schema)
Abaixo está a representação visual da modelagem dimensional utilizada:

![Modelo Conceitual](./Diagrama%20CEA_AW_JT%20-%20.drawio.png)

* 📄 [Download do Diagrama em PDF](./Cópia%20do%20Diagrama%20CEA_AW_JT%20-%20.drawio.pdf)

### 2. Dashboard Power BI
O relatório final foi desenvolvido no Power BI, conectando-se diretamente às tabelas Gold processadas pelo dbt.

* <img src="https://raw.githubusercontent.com/microsoft/PowerBI-Icons/main/SVG/PowerBI_Icon_Type.svg" width="20" height="20"> [**Baixar Dashboard (.pbix)**](./Dashboard%20AventureWorks%20-%20JT.pbix)

### 3. Apresentação do Projeto
Vídeo demonstrativo com a explicação técnica de ponta a ponta.

* <img src="https://upload.wikimedia.org/wikipedia/commons/1/12/Google_Drive_icon_%282020%29.svg" width="20" height="20"> [**Assistir Apresentação no Google Drive**](LINK_DO_SEU_VIDEO_AQUI)

---

## 🧪 Qualidade e Governança de Dados
A confiança nos dados é garantida através de testes automatizados:

* **Testes de Unicidade e Nulidade:** Aplicados em todas as chaves primárias.
* **Integridade Referencial:** Testes de `relationships` na tabela fato.
* **Auditoria Financeira:** Teste customizado `verifica_soma_vendas_2011` para validação de faturamento anual.

---

## 🚀 Como Executar este Projeto

1. **Instalar Dependências:**
   ```bash
   dbt deps