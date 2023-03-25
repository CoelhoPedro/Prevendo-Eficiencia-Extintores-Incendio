library(readxl)
library(ggplot2)
library(randomForest)
library(caret)
library(e1071)
library(class)
library(gmodels)

dados = read_xlsx("Acoustic_Extinguisher_Fire_Dataset.xlsx", sheet = "A_E_Fire_Dataset")
dados = as.data.frame(dados)

set.seed(105)

dim(dados)

# Checando valores missing
sum(is.na(dados$STATUS))

# Checando os tipos de dados
str(dados)

# Transformando os tipos de dados
dados$SIZE = as.factor(dados$SIZE)
dados$FUEL = as.numeric(as.factor(dados$FUEL))
dados$STATUS = as.factor(dados$STATUS)

# Checando a fequência dos dados, para verificar se precisaremos usar
# alguma técnica para balancear os dados
summary(dados)
table(dados$DISTANCE)
table(dados$DESIBEL)
table(dados$AIRFLOW)
table(dados$FREQUENCY)
table(dados$STATUS)
table(dados$FUEL)

# Parece que as variáveis estão bem balanceadas

# Vamos fazer uma análise das variáveis



# Criando boxplot para as variáveis numéricas
col_names = names(dados)
lapply(col_names, function(x){
  if(!is.factor(dados[,x])) {
    ggplot(dados, aes_string(x)) +
      geom_boxplot() +
      ggtitle(paste("Boxplot de", x))}})

# Criando gráfico de barras para as variáveis do tipo fator
lapply(col_names, function(x){
  if(is.factor(dados[,x])) {
    ggplot(dados, aes_string(x)) +
      geom_bar() +
      ggtitle(paste("Frequência da variável",x))}})

# Criando os dados de treino e de teste com o pacote caret
index = createDataPartition(dados$STATUS, p = .70, list = FALSE)
treino = dados[index, ]
teste = dados[-index, ]

dim(treino)
dim(teste)

# Criando o primeiro modelo com o knn
treino_labels = dados[index, 7]
teste_labels = dados[-index, 7]

modelo_knn_v1 = knn(train = treino,
                    test = teste,
                    cl = treino_labels,
                    k = 7)

CrossTable(x = teste_labels, y = modelo_knn_v1, prop.chisq = FALSE)
confusionMatrix(modelo_knn_v1, reference = teste_labels)

# Precisão de 93%

# Vamos tentar criar outros modelos com o valor de k diferente

modelo_knn_v2 = knn(train = treino,
                    test = teste,
                    cl = treino_labels,
                    k = 5)

CrossTable(x = teste_labels, y = modelo_knn_v2, prop.chisq = FALSE)
confusionMatrix(modelo_knn_v2, reference = teste_labels)

# A segunda versão do modelo possui a mesma acurácia do primeiro, 93%.

modelo_knn_v3 = knn(train = treino,
                    test = teste,
                    cl = treino_labels,
                    k = 10)

CrossTable(x = teste_labels, y = modelo_knn_v3, prop.chisq = FALSE)
confusionMatrix(modelo_knn_v3, reference = teste_labels)

# Acurácia de 92%.

# Vamos criar modelos com outros algoritmos.
# Vamos tentar o Support Vector Machine (SVM)

modelo_svm_v1 <- svm(STATUS ~ ., 
                     data = treino, 
                     type = 'C-classification', 
                     kernel = 'radial')

previsao_svm_v1 = predict(modelo_svm_v1, teste)

table(previsao_svm_v1, teste$STATUS)
mean(previsao_svm_v1 == teste$STATUS)

# Conseguimos uma acurácia de 94% com o algoritmo SVM

# Vamos tentar também o algoritmo random forest

modelo_rf_v1 = randomForest(STATUS ~ .,
                            data = treino,
                            ntree = 100,
                            nodesize = 10)

previsao_rf_v1 = predict(modelo_rf_v1, teste)

table(previsao_rf_v1, teste$STATUS)
mean(previsao_rf_v1 == teste$STATUS)

# Conseguimos a melhor acurácia com o random forest, de 95%

# Vamos tentar mudar os hiperparâmetros do random forest pra ver se conseguimos
# um resultado melhor

modelo_rf_v2 = randomForest(STATUS ~ .,
                            data = treino,
                            ntree = 200,
                            nodesize = 10)

previsao_rf_v2 = predict(modelo_rf_v2, teste)

table(previsao_rf_v2, teste$STATUS)
mean(previsao_rf_v2 == teste$STATUS)

# Acurácia de 95%, levemente inferior ao primeiro modelo.

# Vamos tentar mais uma modificação

modelo_rf_v3 = randomForest(STATUS ~ .,
                            data = treino,
                            ntree = 200,
                            nodesize = 5)

previsao_rf_v3 = predict(modelo_rf_v3, teste)

table(previsao_rf_v3, teste$STATUS)
mean(previsao_rf_v3 == teste$STATUS)

# Acurácia de 95%, levemente superior.

# Vamos tentar mais uma modificação.

modelo_rf_v4 = randomForest(STATUS ~ .,
                            data = treino,
                            ntree = 200,
                            nodesize = 1)

previsao_rf_v4 = predict(modelo_rf_v4, teste)

table(previsao_rf_v4, teste$STATUS)
mean(previsao_rf_v4 == teste$STATUS)

# Acurácia de 96%, conseguimos a melhor performance com essa versão do modelo
# random forest