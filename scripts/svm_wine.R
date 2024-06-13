# carregando pacote
library(e1071)

# url do dataset
url='https://gist.githubusercontent.com/tijptjik/9408623/raw/b237fa5848349a14a14e5d4107dc7897c21951f5/wine.csv'

# carregar dataset
wine <- read.csv(url, header=TRUE)

# renomear colunas
colnames(wine) <- c('Type', 'Alcohol', 'Malic', 'Ash', 
                          'Alcalinity', 'Magnesium', 'Phenols', 
                          'Flavanoids', 'Nonflavanoids',
                          'Proanthocyanins', 'Color', 'Hue', 
                          'Dilution', 'Proline')

# converter para fator
wine$Type <- as.factor(wine$Type)

# opcional salvar dataset localmente
#write.csv(wine, file = file.path('/home/rstudio/mydata', 'wine.csv'), row.names = FALSE)

# selecionar variaveis para modelagem
indices <- wine[,c('Type', 'Color', 'Alcohol')]

# treinar modelos svm com diferentes kernels
svm_linear_wine <- svm(Type ~., data=indices, kernel='linear')
svm_radial_wine <- svm(Type ~., data=indices, kernel='radial')
svm_poly_wine <- svm(Type ~., data=indices, kernel='polynomial')

# plotar resultados
plot(svm_linear_wine, indices, main="Kernel Linear")
plot(svm_radial_wine, indices, main="Kernel Radial")  
plot(svm_poly_wine, indices, main="Kernel Polinomial")

# ajustar parametros
set.seed(1)
svm_tune <- tune.svm(Type ~., data=indices, cost=c(0.05, 0.1, 0.5, 1, 1.5))

# plotar resultados do tunning
plot(svm_tune, main = "Tunning de Parâmetro Cost")

# avaliacao do modelo com melhor ajuste
pred <- predict(svm_tune$best.model, indices)
conf_matrix <- table(pred, wine$Type)
precision <- sum(diag(conf_matrix)) / sum(conf_matrix)
recall <- sum(diag(conf_matrix)) / sum(conf_matrix[,2])
f1_score <- 2 * (precision * recall) / (precision + recall)

# Imprimindo resultados
cat("Precisão:", precision, "\n")
cat("Recall:", recall, "\n")
cat("F1-score:", f1_score, "\n")
