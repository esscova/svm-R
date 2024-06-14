# Use a imagem base do RStudio
FROM rocker/rstudio:latest

# Definir o diretório de trabalho
WORKDIR /home/rstudio

# Instalar pacotes adicionais do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev \
    libgit2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar pacotes R necessários
RUN R -e "install.packages(c('e1071', 'caret', 'ggplot2'), repos='https://cloud.r-project.org/')"

# Criar o diretório mydata e copiar o dataset
RUN mkdir -p /home/rstudio/data
COPY data/wine.csv /home/rstudio/data/wine.csv

# Copiar o script R para o contêiner
COPY scripts/svm_wine.R /home/rstudio/svm_wine.R
COPY scripts/svm_iris.R /home/rstudio/svm_iris.R

# Definir as permissões apropriadas
RUN chown -R rstudio:rstudio /home/rstudio

# Expor a porta do RStudio Server
EXPOSE 8787

# Definir variáveis de ambiente
ENV PASSWORD=123456

# Comando para iniciar o RStudio Server
CMD ["/init"]
