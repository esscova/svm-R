library(e1071)

wine <- read.csv('data/wine.csv')
wine$Type <- as.factor(wine$Type)
indices <- wine[,c('Type', 'Color', 'Alcohol')]

# modelos svm 
svm_linear_wine <- svm(Type ~., data=indices, kernel='linear')
svm_radial_wine <- svm(Type ~., data=indices, kernel='radial')
svm_poly_wine <- svm(Type ~., data=indices, kernel='polynomial')

# ajuste de parametros
set.seed(1)
svm_tune <- tune.svm(Type ~., data=indices, cost=c(0.05, 0.1, 0.5, 1, 1.5))

# avaliacao do modelo com melhor ajuste
pred <- predict(svm_tune$best.model, indices)
conf_matrix <- table(pred, wine$Type)

# acurácia
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Acurácia:", accuracy, "\n")


# plots
plot(svm_linear_wine, indices, main="Kernel Linear")
plot(svm_radial_wine, indices, main="Kernel Radial")  
plot(svm_poly_wine, indices, main="Kernel Polinomial")
plot(svm_tune, main = "Tunning de Parâmetro Cost")
