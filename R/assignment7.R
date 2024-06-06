# 데이터마이닝 7장 홀수, 8장 짝수 문제풀이

# 7장 1번
# install.packages("e1071")

library(e1071)
setwd("C:/WORK_R")
job <- read.csv("job.csv", header = T, fileEncoding="EUC-KR")

head(job)

set.seed(1234)
idxs <- sample(1:nrow(job), as.integer(0.7 * nrow(job)))
train <- job[idxs, ]
test <- job[-idxs, ]

model <- naiveBayes(직무 ~., train)

new <- data.frame(실제값 = test$직무)
new$예측값 <- predict(model, test)

predict_table <- table(new$예측값, new$실제값)
names(dimnames(predict_table)) <- c("predict", "observed")

predict_table

new$result <- ifelse(new$실제값 == new$예측값, "Y", "N")
predict_prob <- sum(new$result=='Y') / length(new$result)
predict_prob

cat("1번 종료 \n\n\n")


# 5번
# install.packages("e1071")

library(e1071)
setwd("C:/WORK_R")
job <- read.csv("job.csv", stringsAsFactors = TRUE, fileEncoding="EUC-KR")

set.seed(1234)
idxs <- sample(1:nrow(job), as.integer(0.7 * nrow(job)))
train <- job[idxs, ]
test <- job[-idxs, ]

str(job)
model <- svm(직무 ~ ., train, type = "C-classification", kernel = "radial", cost = 10, gamma = 0.1)

new <- data.frame(실젯값=test$직무)
new$예측값 <- predict(model, test, decision.values = TRUE)

predict_table <- table(new$예측값, new$실젯값)
names(dimnames(predict_table)) <- c("predict", "observed")

predict_table

new$result <- ifelse(new$실젯값 == new$예측값, "Y", "N")
predict_prob <- sum(new$result=='Y') / length(new$result)
predict_prob

str(job)
cost_range <- 10^(-1:2)
gamma_range <- c(.1,5,1,2)
svm_tune <- tune(svm, train.x = 직무 ~ ., data = train, kernel = "radial", ranges = list(cost = cost_range, gamma = gamma_range))
svm_tune

cat("5번 종료 \n\n\n")

# 7번

# install.packages("nnet")
# install.packages("downloader")

library(nnet)
library(downloader)

setwd("C:/WORK_R")
job <- read.csv("job.csv", stringsAsFactors = TRUE, fileEncoding="EUC-KR")

set.seed(1234)
idxs <- sample(1:nrow(job), as.integer(0.7 * nrow(job)))
train <- job[idxs, ]
test <- job[-idxs, ]

str(job)
model <- nnet(직무 ~ ., data = train, size = 3)

source_url("https://gist.githubusercontent.com/fawda123/5086859/raw/17fd6d2adec4dbcf5ce750cbd1f3e0f4be9d8b19/nnet_plot_fun.r", prompt = FALSE)
plot.nnet(model)

new <- data.frame(실젯값 = test$직무)
new$예측값 <- predict(model, test, type = "class")

predict_table <- table(new$예측값, new$실젯값)
names(dimnames(predict_table)) <- c("predict", "observed")

predict_table

new$result <- ifelse(new$실젯값 == new$예측값, "Y", "N")
predict_prob <- sum(new$result == 'Y') / length(new$result)
predict_prob

cat("7번 종료 \n\n\n")


# 9번

# install.packages("e1071")

library(e1071)
setwd("C:/WORK_R")
job <- read.csv("job.csv", stringsAsFactors = TRUE, fileEncoding="EUC-KR")

set.seed(1234)
idxs <- sample(1:nrow(job), as.integer(0.7 * nrow(job)))
train <- job[idxs, ]
test <- job[-idxs, ]

str(job)
model <- svm(직무 ~ ., train, type = "C-classification", kernel = "radial", cost = 10, gamma = 0.1)

new <- data.frame(실젯값=test$직무)
new$예측값 <- predict(model, test, decision.values = TRUE)

predict_table <- table(new$예측값, new$실젯값)
names(dimnames(predict_table)) <- c("predict", "observed")

predict_table

new$result <- ifelse(new$실젯값 == new$예측값, "Y", "N")
predict_prob <- sum(new$result == 'Y') / length(new$result)
predict_prob

head(job)
str(job)

cost_range <- 10^(-1:2)
gamma_range <- c(.1,5,1,2)
svm_tune <- tune(svm, train.x = 직무 ~ ., data = train, kernel = "radial", ranges = list(cost = cost_range, gamma = gamma_range))
svm_tune

best_model <- svm_tune$best.model

new_data <- data.frame(야외활동성 = 20, 사교성 = 15, 보수성 = 10)
names(new_data) <- c("야외활동성", "사교성", "보수성")
new_data

predicted_job <- predict(best_model, new_data)
cat("prepredicted_job\n")
predicted_job

cat("9번 종료 \n\n\n")


