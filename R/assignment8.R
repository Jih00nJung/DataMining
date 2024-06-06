# 문제풀이 8장

# 2번

# install.packages("neuralnet")

library(MASS)
library(neuralnet)

data_2 <- Boston
set.seed(123)
idxs <- sample(1:nrow(data_2), as.integer(0.7 * nrow(data_2)))
traindata <- data_2[idxs, ]
testdata <- data_2[-idxs, ]

normalize <- function(x, min_x, max_x) { return((x - min_x) / (max_x - min_x)) }

train_min <- apply(traindata, 2, min)
train_max <- apply(traindata, 2, max)

norm_traindata <- as.data.frame(mapply(normalize, traindata, train_min, train_max))
norm_testdata <- as.data.frame(mapply(normalize, testdata, train_min, train_max))

model <- neuralnet(medv ~ ., norm_traindata, hidden = c(5, 3))

predicted <- predict(model, norm_testdata)

new <- data.frame(실젯값 = testdata$medv, medv = predicted * (train_max["medv"] - train_min["medv"]) + train_min["medv"])

head(new)
cat("2번 끝 \n\n\n")

# 4번
# install.packages("nnet")
# install.packages("caret")

library(nnet)
library(caret)

setwd("C:/WORK_R")
loan <- read.csv("loan_data_set.csv", header = TRUE, fileEncoding = "EUC-KR")

str(loan)
head(loan)

colSums(is.na(loan))

loan$Loan_Status <- as.numeric(as.factor(loan$Loan_Status))
loan <- na.omit(loan)

set.seed(123)
idxs <- sample(1:nrow(loan), as.integer(0.7 * nrow(loan)))
train <- loan[idxs, ]
test <- loan[-idxs, ]

head(loan$Loan_Status)
model <- nnet(Loan_Status ~ ., data = train, size = 2, maxit = 200)

summary(model)

predictions <- predict(model, test, type = "class")

confusion_matrix <- table(Predicted = predictions, Actual = test$Loan_Status1)
confusion_matrix

accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
paste("Accuracy: ", round(accuracy, 2))
cat("4번 끝 \n\n\n")


# 6번

setwd("C:/WORK_R")

data <- iris

View(iris)
str(data)

data <- subset(data, select = c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species))

data$Species <- as.numeric(data$Species)

clu_data <- subset(data, select = c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species))

euclide = dist(clu_data, method = "euclidean")

clu_result1 <- hclust(euclide, method = "single")
clu_result2 <- hclust(euclide, method = "complete")
clu_result3 <- hclust(euclide, method = "average")
clu_result4 <- hclust(euclide, method = "median")
clu_result5 <- hclust(euclide, method = "centroid")
clu_result6 <- hclust(euclide, method = "ward.D")

par(mfrow = c(3, 2))

plot(clu_result1, hang = -1, main = "최단연결법")
plot(clu_result2, hang = -1, main = "최장연결법")
plot(clu_result3, hang = -1, main = "평균연결법")
plot(clu_result4, hang = -1, main = "중위수연결법")
plot(clu_result5, hang = -1, main = "중심연결법")
plot(clu_result6, hang = -1, main = "와드연결법")
