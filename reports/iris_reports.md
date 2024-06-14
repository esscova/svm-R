# Relatório do Script e Dataset - SVM com o Dataset Iris

## Descrição Geral

Este script em R realiza a classificação das espécies de flores do dataset Iris utilizando Máquinas de Vetores de Suporte (SVM) com diferentes kernels. O script inclui as etapas de exploração de dados, pré-processamento, treinamento de modelos, avaliação de desempenho e visualização dos resultados.

### Bibliotecas Utilizadas
O script utiliza as seguintes bibliotecas:
- `e1071`: Implementação de SVM.
- `tidyr`: Manipulação de dados.
- `lattice`: Visualização de dados.
- `ggplot2`: Visualização de dados.
- `caret`: Funções para treinamento e avaliação de modelos.

### Dataset Iris
O dataset Iris é um conjunto de dados clássico na área de aprendizado de máquina que contém 150 amostras de flores de três espécies diferentes: Iris setosa, Iris versicolor e Iris virginica. Cada amostra possui quatro atributos numéricos:
- Comprimento da sépala (`Sepal.Length`)
- Largura da sépala (`Sepal.Width`)
- Comprimento da pétala (`Petal.Length`)
- Largura da pétala (`Petal.Width`)
- Especificação da espécie (`Species`), que é a variável categórica.

### Análise Exploratória de Dados (EDA)
1. **Visualização Inicial**:
   - `head(iris)`: Exibe as primeiras seis linhas do dataset.
   - `summary(iris)`: Exibe um resumo estatístico das variáveis.
   - `str(iris)`: Mostra a estrutura do dataset.

2. **Plot de Pares**:
   - `pairs(iris, main = "Pairs plot of Iris dataset")`: Visualiza as relações entre os pares de variáveis numéricas.

   ![image](/plots/iris_pairs_plot.png)

3. **Matriz de Correlação**:
   - `correlation_matrix <- cor(iris[, -5])`: Calcula a matriz de correlação excluindo a coluna categórica `Species`.
   
   - `heatmap(correlation_matrix, main = "Heatmap of Correlation Matrix")`: Visualiza a matriz de correlação usando um heatmap.

   ![image](/plots/iris_matrix_corr.png)

### Pré-processamento
1. **Divisão dos Dados**:
   - Os dados são divididos em conjuntos de treinamento (70%) e teste (30%):
     ```r
     set.seed(123)
     train <- sample(nrow(iris), 0.7 * nrow(iris))
     test <- setdiff(1:nrow(iris), train)
     ```

2. **Escalamento dos Dados**:
   - Os dados são escalados para terem média zero e variância um usando a função `preProcess` do pacote `caret`:
     ```r
     scaledData <- preProcess(X_train, method = c("center", "scale"))
     X_train_scaled <- predict(scaledData, X_train)
     X_test_scaled <- predict(scaledData, X_test)
     ```

### Treinamento e Avaliação do Modelo
1. **Kernels Utilizados**:
   - Quatro tipos de kernels são usados para treinar o modelo SVM: linear, polinomial, radial e sigmoide.

2. **Loop para Treinamento e Avaliação**:
   - Para cada kernel, o modelo SVM é treinado e avaliado. As métricas de desempenho são calculadas e armazenadas:
     ```r
     for (kernel in kernels) {
       svmModel <- svm(y_train ~ ., data = data.frame(X_train_scaled, y_train), kernel = kernel)
       predictions <- predict(svmModel, X_test_scaled, type = "response")
       confusion <- confusionMatrix(predictions, y_test)
       accuracy <- confusion$overall['Accuracy']
       precision <- mean(confusion$byClass[, "Pos Pred Value"], na.rm = TRUE)
       recall <- mean(confusion$byClass[, "Sensitivity"], na.rm = TRUE)
       f1 <- mean(2 * (precision * recall) / (precision + recall), na.rm = TRUE)
       sensitivity <- mean(confusion$byClass[, "Sensitivity"], na.rm = TRUE)
       specificity <- mean(confusion$byClass[, "Specificity"], na.rm = TRUE)
       metrics <- rbind(metrics, data.frame(Kernel = kernel, Accuracy = accuracy, Precision = precision, Recall = recall, F1 = f1, Sensitivity = sensitivity, Specificity = specificity))
       temp_results <- data.frame(X_test, Species = y_test, Predicted = predictions, Kernel = kernel, Accuracy = accuracy)
       results <- rbind(results, temp_results)
     }
     ```

### Visualização dos Resultados
- Os resultados das previsões são visualizados usando o `ggplot2`:
  ```r
  ggplot(results, aes(x = Sepal.Length, y = Sepal.Width, color = Predicted, shape = Species)) +
    geom_point(size = 3) +
    facet_wrap(~ FacetTitle) +
    labs(title = "Resultados dos Modelos SVM com Diferentes Kernels",
         x = "Sepal Length",
         y = "Sepal Width") +
    theme_minimal() +
    scale_color_manual(values = c("setosa" = "red", "versicolor" = "blue", "virginica" = "green"))
  ```

   ![image](/plots/iris_svm_kernels.png)


### Relatório de Métricas de Desempenho
- As métricas de desempenho (acurácia, precisão, recall, F1-score, sensibilidade e especificidade) são impressas no console:

```r
print(metrics)

     Kernel  Accuracy Precision    Recall        F1 Sensitivity Specificity
     linear 0.9777778 0.9761905 0.9814815 0.9788288   0.9814815   0.9895833
 polynomial 0.9555556 0.9666667 0.9487179 0.9576082   0.9487179   0.9753086
     radial 0.9777778 0.9761905 0.9814815 0.9788288   0.9814815   0.9895833
    sigmoid 0.9111111 0.9215686 0.9259259 0.9237421   0.9259259   0.9583333
```

## Conclusão
O script realiza uma análise abrangente e sistemática do dataset Iris utilizando SVM com diferentes kernels. As etapas incluem desde a análise exploratória até a visualização dos resultados, permitindo uma compreensão completa do desempenho dos modelos.