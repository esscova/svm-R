# Relatório de Análise SVM para Classificação de Vinhos

Este relatório descreve o processo de implementação de Support Vector Machines (SVM) para a classificação de um conjunto de dados de vinhos utilizando diferentes kernels em R.

## 1. Carregamento e Preparação dos Dados

```r
# Carregando pacote necessário
library(e1071)

# Carregar dataset
wine <- read.csv('data/wine.csv')

# Converter variável Type para fator
wine$Type <- as.factor(wine$Type)

# Selecionar variáveis para modelagem
indices <- wine[, c('Type', 'Color', 'Alcohol')]
```

O conjunto de dados `wine.csv` foi carregado e preparado para a modelagem, com a variável resposta `Type` e preditoras `Color` e `Alcohol`.

## 2. Treinamento dos Modelos SVM

Foram treinados três modelos SVM utilizando diferentes kernels: linear, radial e polinomial.

```r
# Treinar modelos SVM com diferentes kernels
svm_linear_wine <- svm(Type ~ ., data = indices, kernel = 'linear')
svm_radial_wine <- svm(Type ~ ., data = indices, kernel = 'radial')
svm_poly_wine <- svm(Type ~ ., data = indices, kernel = 'polynomial')
```

## 3. Ajuste de Parâmetros

Para otimização dos modelos, foi realizado o ajuste do parâmetro `cost` utilizando a função `tune.svm`:

```r
# Ajustar parâmetros
set.seed(1)
svm_tune <- tune.svm(Type ~ ., data = indices, cost = c(0.05, 0.1, 0.5, 1, 1.5))
```

## 4. Avaliação do Melhor Modelo

Após o ajuste de parâmetros, o modelo com melhor desempenho foi avaliado:

```r
# Avaliação do modelo com melhor ajuste
pred <- predict(svm_tune$best.model, indices)
conf_matrix <- table(pred, wine$Type)

# Calcular a acurácia
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

# Imprimir resultados
cat("Acurácia:", accuracy, "\n")
```

### Resultados da Avaliação

- **Acurácia:** `0.8708`

## 5. Visualização dos Resultados

Os resultados dos modelos SVM foram visualizados utilizando gráficos para cada kernel, bem como os resultados do ajuste de parâmetros:

```r
# Plotar resultados
plot(svm_linear_wine, indices, main = "Kernel Linear")
plot(svm_radial_wine, indices, main = "Kernel Radial")
plot(svm_poly_wine, indices, main = "Kernel Polinomial")
plot(svm_tune, main = "Ajuste de Parâmetro Cost")
```
### Kernel Linear
![image](/plots/wine_svm_kernel_linear.png)

### Kernel Radial
![image](/plots/wine_svm_kernel_radial.png)

### Kernel Polinomial
![image](/plots/wine_svm_kernel_polinomial.png)

### Ajuste de parametros
![image](/plots/wine_svm_tune.png)
