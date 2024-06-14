
# Support Vector Machine

Este repositório apresenta um exemplo de implementação de SVM em R com diferentes kernels (linear, radial e polinomial) para classificar um conjunto de dados de vinhos.

![image](screenshot.png)

## Observações sobre o dataset wine.csv

O arquivo `wine.csv` contém um conjunto de dados de vinhos com informações como cor, teor alcoólico e tipo de vinho.

## Sobre o código

O código utiliza o pacote `e1071` para carregar o conjunto de dados `wine.csv`. Ele converte a variável `Type` em um fator e seleciona as variáveis `Color`, `Alcohol` e `Type` para modelagem.

Os seguintes passos são realizados:

1. Treinamento de três modelos SVM com diferentes kernels: linear, radial e polinomial. Os resultados são plotados para cada kernel.

2. Ajuste dos parâmetros do modelo SVM usando a função `tune.svm` e plotagem dos resultados do ajuste de parâmetros.

3. Avaliação do modelo com melhor ajuste, incluindo cálculos de precisão, recall e F1-score.

## Como executar o código

Você pode executar o código de duas maneiras: localmente ou utilizando Docker.

### Execução local

1. Clone o repositório e navegue até a pasta do projeto.

2. Execute o script R localizado em `scripts/`.

### Utilizando Docker

1. Clone o repositório e navegue até a pasta do projeto.

2. Para construir a imagem Docker, execute:
    ```sh
    docker build -t svm-wine .
    ```

3. Para iniciar o container Docker, execute:
    ```sh
    docker run -p 8787:8787 svm-wine
    ```

4. Acesse o RStudio Server em `http://localhost:8787`.

5. Faça login utilizando as seguintes credenciais:
    - **Usuário**: `rstudio`
    - **Senha**: `123456`

6. Abra o arquivo `svm_wine.R` no RStudio e execute o código.

### Notas adicionais

- Certifique-se de ter o Docker instalado na sua máquina.
- A imagem Docker é baseada em `rocker/rstudio:latest` e inclui os pacotes R necessários.
- O arquivo `wine.csv` será copiado para o container Docker e estará disponível para o script R durante a execução.

## Relatório de análise
Para uma análise detalhada do processo de implementação da SVM e dos resultados, consulte o <a href='/reports/wine_reports.md'>relatório completo</a>.

## Connect with me

[![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:wmoreira.ds@gmail.com)
[![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/wellington-moreira-santos/)
[![Facebook](https://img.shields.io/badge/Facebook-%231877F2.svg?style=for-the-badge&logo=Facebook&logoColor=white)](https://www.facebook.com/wellmoreiras)
[![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=Instagram&logoColor=white)](https://www.instagram.com/moreira.883/)
[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/wellington_moreira_santos)

