# Relatório do Script e Dataset - SVM com o Dataset Wine

## Descrição Geral

Este script em R realiza a classificação dos tipos de vinhos utilizando Máquinas de Vetores de Suporte (SVM) com diferentes kernels e ajusta os parâmetros do modelo para obter o melhor desempenho. O script inclui as etapas de leitura do dataset, preparação dos dados, treinamento dos modelos, ajuste de parâmetros, avaliação do desempenho e visualização dos resultados.

### Bibliotecas Utilizadas
O script utiliza a biblioteca `e1071`, que fornece funções para a implementação de SVM em R.

### Dataset Wine
O dataset `wine.csv` contém dados sobre diferentes tipos de vinhos. Cada instância no dataset é uma amostra de vinho, e as colunas incluem várias características químicas. No script, três colunas são utilizadas:
- `Type`: Tipo de vinho (variável categórica).
- `Color`: Cor do vinho.
- `Alcohol`: Conteúdo de álcool no vinho.

### Carregamento e Preparação dos Dados
1. **Leitura do Dataset**:
   - O dataset é lido de um arquivo CSV:
     ```r
     wine <- read.csv('data/wine.csv')
     ```

2. **Conversão da Variável Categórica**:
   - A coluna `Type` é convertida para o tipo fator:
     ```r
     wine$Type <- as.factor(wine$Type)
     ```

3. **Seleção de Colunas**:
   - São selecionadas apenas as colunas `Type`, `Color` e `Alcohol` para a análise:
     ```r
     indices <- wine[,c('Type', 'Color', 'Alcohol')]
     ```

### Treinamento dos Modelos SVM
1. **Treinamento com Diferentes Kernels**:
   - Três modelos SVM são treinados utilizando diferentes kernels: linear, radial e polinomial:
     ```r
     svm_linear_wine <- svm(Type ~., data=indices, kernel='linear')
     svm_radial_wine <- svm(Type ~., data=indices, kernel='radial')
     svm_poly_wine <- svm(Type ~., data=indices, kernel='polynomial')
     ```

### Ajuste de Parâmetros
1. **Ajuste do Parâmetro Cost**:
   - O ajuste do parâmetro `cost` é realizado utilizando a função `tune.svm`:
     ```r
     set.seed(1)
     svm_tune <- tune.svm(Type ~., data=indices, cost=c(0.05, 0.1, 0.5, 1, 1.5))
     ```

### Avaliação do Modelo
1. **Previsões e Matriz de Confusão**:
   - O modelo ajustado é utilizado para fazer previsões, e uma matriz de confusão é gerada para avaliar o desempenho:
     ```r
     pred <- predict(svm_tune$best.model, indices)
     conf_matrix <- table(pred, wine$Type)
     ```

2. **Cálculo da Acurácia**:
   - A acurácia do modelo é calculada como a razão entre o número de previsões corretas e o total de previsões:
     ```r
     accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
     cat("Acurácia:", accuracy, "\n")
     ```

### Visualização dos Resultados
1. **Plots dos Modelos SVM**:
   - Os modelos SVM com diferentes kernels são visualizados utilizando a função `plot`:
     
     ```r
     plot(svm_linear_wine, indices, main="Kernel Linear")
     ```
     ![image](/plots/wine_svm_kernel_linear.png)

     ```r
     plot(svm_radial_wine, indices, main="Kernel Radial")
     ```
     ![image](/plots/wine_svm_kernel_radial.png)

     ```r
     plot(svm_poly_wine, indices, main="Kernel Polinomial")
     ```
     ![image](/plots/wine_svm_kernel_polinomial.png)


2. **Plot do Ajuste de Parâmetros**:
   - O resultado do ajuste de parâmetros é visualizado:
     ```r
     plot(svm_tune, main = "Tunning de Parâmetro Cost")
     ```
     ![image](/plots/wine_svm_tune.png)

## Conclusão
O script realiza uma análise completa do dataset Wine utilizando SVM com diferentes kernels e ajuste de parâmetros. As etapas incluem desde a preparação dos dados até a avaliação do desempenho e visualização dos resultados, permitindo uma compreensão detalhada do desempenho dos modelos treinados. A acurácia obtida é impressa no console, proporcionando uma métrica clara do sucesso do modelo ajustado.