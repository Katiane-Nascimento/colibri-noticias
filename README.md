# API Colibri Notícias 🐦📰

Bem-vindo à API Colibri Notícias! Esta API fornece endpoints para gerenciar e acessar categorias e notícias do sistema Colibri Notícias.

## Índice

* [Sobre](#sobre)
* [Recursos](#recursos)
* [Tecnologias Utilizadas](#tecnologias-utilizadas)
* [Como Começar (Setup Local)](#como-começar-setup-local)
    * [Pré-requisitos](#pré-requisitos)
    * [Instalação](#instalação)
* [Autenticação](#autenticação)
* [Endpoints da API](#endpoints-da-api)
    * [Categorias](#categorias)
    * [Notícias](#notícias)
* [Exemplos de Requisição/Resposta](#exemplos-de-requisiçãoresposta)
* [Tratamento de Erros](#tratamento-de-erros)
* [Contribuição](#contribuição-opcional)

## Sobre

A API Colibri Notícias é o backend responsável por fornecer e gerenciar o conteúdo de notícias e suas respectivas categorias para a plataforma Colibri Notícias. Ela permite a criação, leitura, atualização e exclusão (CRUD) de notícias, bem como o gerenciamento de categorias, com funcionalidades de busca, filtro e ordenação.

## Recursos

* Gerenciamento completo de Categorias (CRUD).
* Gerenciamento completo de Notícias (CRUD).
* Busca textual em notícias (título, resumo, colaborador).
* Filtragem de notícias por categoria.
* Ordenação de notícias por data de adição.

## Tecnologias Utilizadas

* Python
* Django
* Django REST Framework
* SQLite

## Como Começar (Setup Local)

Siga estas instruções para configurar e executar a API em seu ambiente local.

### Pré-requisitos

* Python 3.12+
* Pip (Gerenciador de pacotes Python)
* Git

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone <https://github.com/Katiane-Nascimento/colibri-noticias.git>
    cd apiColibriNoticias
    ```

2.  **Crie e ative um ambiente virtual (recomendado):**
    ```bash
    python -m venv venv
    # No Windows:
    # venv\Scripts\activate
    # No macOS/Linux:
    # source venv/bin/activate
    ```

3.  **Instale as dependências:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Aplique as migrações do banco de dados:**
    ```bash
    python manage.py migrate
    ```

5.  **Crie um superusuário (para acessar o Django Admin, opcional):**
    ```bash
    python manage.py createsuperuser
    ```

6.  **Execute o servidor de desenvolvimento:**
    ```bash
    python manage.py runserver
    ```
    A API estará disponível em `http://127.0.0.1:8000/`.

## Autenticação

*(Esta seção é crucial e precisa ser preenchida com base na sua implementação)*

**Exemplo:**
A API utiliza autenticação baseada em Token (TokenAuthentication). Para acessar os endpoints protegidos, você precisa incluir um Token de autenticação no header `Authorization` de suas requisições:

`Authorization: Token SEU_TOKEN_AQUI`

## Endpoints da API

O prefixo base para todos os endpoints é `/api`.

---

### Categorias

Recurso para gerenciar categorias de notícias.

* **`GET /api/categorias/`**
    * **Descrição:** Retorna uma lista de todas as categorias.
    * **Parâmetros de Query:** Nenhum.
    * **Resposta de Sucesso:** `200 OK`
        ```json
        [
            {
                "nome": "Esportes",
            },
            {
                "nome": "Tecnologia",
            }
        ]
        ```

* **`GET /api/categorias/{nome_categoria}/`**
    * **Descrição:** Retorna uma categoria específica pelo seu nome.
    * **Parâmetros de URL:**
        * `nome_categoria` (string, obrigatório): O nome da categoria a ser recuperada.
    * **Resposta de Sucesso:** `200 OK`
        ```json
        {
            "nome": "Esportes",
        }
        ```
    * **Resposta de Erro:** `404 Not Found` se a categoria não existir.

* **`POST /api/categorias/`**
    * **Descrição:** Cria uma nova categoria.
    * **Corpo da Requisição (JSON):**
        ```json
        {
            "nome": "Política",
        }
        ```
    * **Campos Obrigatórios:** `nome`.
    * **Resposta de Sucesso:** `201 Created`
        ```json
        {
            "nome": "Política",
        }
        ```
    * **Resposta de Erro:** `400 Bad Request` se os dados forem inválidos.

---

### Notícias

Recurso para gerenciar notícias.

* **`GET /api/noticias/`**
    * **Descrição:** Retorna uma lista de todas as notícias. Suporta busca, filtragem e ordenação (veja abaixo).
    * **Resposta de Sucesso:** `200 OK`
        ```json
        [
            {
                "id": "93aded75-977d-4979-bfa3-f0b3ff5c0426",
                "titulo": "Título da Notícia 1",
                "resumo": "Breve resumo da notícia 1...",
                "conteudo_completo": "Conteúdo extenso da notícia 1...",
                "dataHoraPublicacao":"2024-05-24T10:00:00Z",
                "dataHoraAdicao": "2024-05-25T10:00:00Z",
                "colaborador": "Nome do Colaborador",
                "categoria": null
            }
        ]
        ```

* **`GET /api/noticias/{id}/`**
    * **Descrição:** Retorna uma notícia específica pelo seu ID.
    * **Parâmetros de URL:**
        * `id` (integer, obrigatório): O ID da notícia.
    * **Resposta de Sucesso:** `200 OK`
        ```json
        {
            "id": "93aded75-977d-4979-bfa3-f0b3ff5c0426",
            "titulo": "Título da Notícia 1",
            "resumo": "Breve resumo da notícia 1..."
        }
        ```
    * **Resposta de Erro:** `404 Not Found` se a notícia não existir.

* **`POST /api/noticias/`**
    * **Descrição:** Cria uma nova notícia.
    * **Corpo da Requisição (JSON):**
        ```json
        {
            "titulo": "Nova Descoberta Científica",
            "resumo": "Cientistas anunciam avanço importante...",
            "conteudo_completo": "Detalhes completos da descoberta...",
            "dataHoraAdicao": "2024-05-26T14:30:00Z",
            "colaborador": "Redação Científica",
            "categoria": "ciência"
        }
        ```
    * **Campos Obrigatórios:** `titulo`, `conteudo_completo`, `categoria`. (Ajuste conforme sua modelagem)
    * **Resposta de Sucesso:** `201 Created` (Retorna a notícia criada)
    * **Resposta de Erro:** `400 Bad Request`

* **`PUT /api/noticias/{id}/`**
    * **Descrição:** Atualiza uma notícia existente pelo seu ID. Envia todos os campos para atualização.
    * **Parâmetros de URL:**
        * `id` (integer, obrigatório): O ID da notícia a ser atualizada.
    * **Corpo da Requisição (JSON):** (Mesma estrutura do POST, com os campos a serem atualizados)
    * **Resposta de Sucesso:** `200 OK` (Retorna a notícia atualizada)
    * **Resposta de Erro:** `400 Bad Request`, `404 Not Found`.

* **`PATCH /api/noticias/{id}/`** *(Considere adicionar este endpoint)*
    * **Descrição:** Atualiza parcialmente uma notícia existente. Envia apenas os campos que deseja alterar.
    * **Parâmetros de URL:**
        * `id` (integer, obrigatório): O ID da notícia a ser atualizada.
    * **Corpo da Requisição (JSON):**
        ```json
        {
            "titulo": "Título Atualizado da Notícia",
            "resumo": "Resumo revisado."
        }
        ```
    * **Resposta de Sucesso:** `200 OK` (Retorna a notícia atualizada)
    * **Resposta de Erro:** `400 Bad Request`, `404 Not Found`.

* **`DELETE /api/noticias/{id}/`**
    * **Descrição:** Remove uma notícia pelo seu ID.
    * **Parâmetros de URL:**
        * `id` (integer, obrigatório): O ID da notícia a ser removida.
    * **Resposta de Sucesso:** `204 No Content`
    * **Resposta de Erro:** `404 Not Found`.

#### Funcionalidades Avançadas para Notícias (Query Parameters em `GET /api/noticias/`)

* **Pesquisa Textual:**
    * `GET /api/noticias/?search={termo}`
    * **Descrição:** Pesquisa por `{termo}` nos campos `titulo`, `resumo` e `colaborador`.
    * **Exemplo:** `/api/noticias/?search=inteligencia artificial`

* **Filtragem por Categoria:**
    * `GET /api/noticias/?categoria={nome_da_categoria}`
    * **Descrição:** Filtra as notícias que pertencem à categoria especificada pelo nome.
    * **Exemplo:** `/api/noticias/?categoria=Esportes`

* **Ordenação:**
    * `GET /api/noticias/?ordering={campo}`
    * **Descrição:** Ordena a lista de notícias.
    * **Valores para `{campo}`:**
        * `dataHoraAdicao`: Ordena pela data de adição, da mais antiga para a mais recente.
        * `-dataHoraAdicao`: Ordena pela data de adição, da mais recente para a mais antiga (descendente).
    * **Exemplo:** `/api/noticias/?ordering=-dataHoraAdicao`

* **Combinando Parâmetros:**
    * É possível combinar múltiplos parâmetros de query:
    * **Exemplo:** `/api/noticias/?search=futebol&categoria=Esportes&ordering=-dataHoraAdicao`

## Exemplos de Requisição/Resposta

*(Esta seção pode ser expandida com exemplos mais detalhados usando `curl` ou uma ferramenta como Postman/Insomnia para cada endpoint, se desejar.)*

**Exemplo de criação de categoria usando `curl`:**

```bash
curl -X POST [http://127.0.0.1:8000/api/categorias/](http://127.0.0.1:8000/api/categorias/) \
-H "Authorization: Token SEU_TOKEN_AQUI" \
-H "Content-Type: application/json" \
-d '{
    "nome": "Saúde",
}'