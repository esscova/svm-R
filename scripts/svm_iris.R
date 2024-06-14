# bibliotecas
library(e1071)
library(tidyr)
library(lattice)
library(ggplot2)
library(caret)

# dataset Iris
data(iris)

# eda
head(iris)
summary(iris)
str(iris)

# par de variáveis para ver as relações
pairs(iris, main = "Pairs plot of Iris dataset")

# matriz de correlação excluindo a coluna categórica
correlation_matrix <- cor(iris[, -5])
print(correlation_matrix)

# matriz de correlação usando um heatmap
heatmap(correlation_matrix, main = "Heatmap of Correlation Matrix")

# pre processamento
# divisão dos dados em treinamento e teste
set.seed(123)
train <- sample(nrow(iris), 0.7 * nrow(iris))
test <- setdiff(1:nrow(iris), train)

X_train <- iris[train, 1:4]
y_train <- iris[train, 5]

X_test <- iris[test, 1:4]
y_test <- iris[test, 5]

# escalar os dados
scaledData <- preProcess(X_train, method = c("center", "scale"))
X_train_scaled <- predict(scaledData, X_train)
X_test_scaled <- predict(scaledData, X_test)

# kernels
kernels <- c("linear", "polynomial", "radial", "sigmoid")

# df para armazenar os resultados
results <- data.frame()

# df para armazenar as métricas de desempenho
metrics <- data.frame(Kernel = character(), Accuracy = numeric(), Precision = numeric(), Recall = numeric(), F1 = numeric(), Sensitivity = numeric(), Specificity = numeric(), stringsAsFactors = FALSE)

# classificador svm
# Loop para treinar e avaliar o modelo com diferentes kernels
for (kernel in kernels) {
  # treinar modelo
  svmModel <- svm(y_train ~ ., data = data.frame(X_train_scaled, y_train), kernel = kernel)
  
  # previsões
  predictions <- predict(svmModel, X_test_scaled, type = "response")
  
  # desempenho do modelo
  confusion <- confusionMatrix(predictions, y_test)
  accuracy <- confusion$overall['Accuracy']
  
  # precisão, recall e F1-score para cada classe e tirar a média
  precision <- mean(confusion$byClass[, "Pos Pred Value"], na.rm = TRUE)
  recall <- mean(confusion$byClass[, "Sensitivity"], na.rm = TRUE)
  f1 <- mean(2 * (precision * recall) / (precision + recall), na.rm = TRUE)
  
  # média ponderada de sensibilidade e especificidade
  sensitivity <- mean(confusion$byClass[, "Sensitivity"], na.rm = TRUE)
  specificity <- mean(confusion$byClass[, "Specificity"], na.rm = TRUE)
  
  # persistir métricas
  metrics <- rbind(metrics, data.frame(Kernel = kernel, Accuracy = accuracy, Precision = precision, Recall = recall, F1 = f1, Sensitivity = sensitivity, Specificity = specificity))
  
  # df para os resultados
  temp_results <- data.frame(X_test, Species = y_test, Predicted = predictions, Kernel = kernel, Accuracy = accuracy)
  results <- rbind(results, temp_results)
}

# redefinir os nomes das linhas do df metrics
row.names(metrics) <- NULL

# coluna com títulos das facetas incluindo a acurácia
results$FacetTitle <- paste(results$Kernel, sprintf("(Acurácia: %.2f%%)", results$Accuracy * 100))

# resultados usando ggplot2
ggplot(results, aes(x = Sepal.Length, y = Sepal.Width, color = Predicted, shape = Species)) +
  geom_point(size = 3) +
  facet_wrap(~ FacetTitle) +
  labs(title = "Resultados dos Modelos SVM com Diferentes Kernels",
       x = "Sepal Length",
       y = "Sepal Width") +
  theme_minimal() +
  scale_color_manual(values = c("setosa" = "red", "versicolor" = "blue", "virginica" = "green"))

# relatório das métricas de desempenho
print(metrics)
