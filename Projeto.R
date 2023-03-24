library(dplyr)
library(readxl)
library(ggplot2)
library(randomForest)
library(caret)
library(e1071)
library(class)
library(gmodels)

dados = read_xlsx("Acoustic_Extinguisher_Fire_Dataset.xlsx", sheet = "A_E_Fire_Dataset")
dados = as.data.frame(dados)

View(dados)
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

# Vamos vizualizar as variáveis numéricas com o boxplot
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

set.seed(105)
modelo_knn_v1 = knn(train = treino,
                    test = teste,
                    cl = treino_labels,
                    k = 7)
summary(modelo_knn_v1)
CrossTable(x = teste_labels, y = modelo_knn_v1, prop.chisq = FALSE)
