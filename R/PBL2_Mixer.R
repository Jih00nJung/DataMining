# Mixer

# install.packages('abind')
# install.packages('zoo')
# install.packages('xts')
# install.packages('quantmod')
# install.packages('ROCR')

# install.packages("remotes")
# remotes::install_github("cran/DMwR")
install.packages("scales")

library(scales)
library(DMwR)
library(ggplot2)

setwd("C:/WORK_R/Dataset_Mixer")

mixer <- read.csv("mixing_actuator.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

mixer$Quality <- as.factor(mixer$Quality)
mixer <- mixer[-2]

head(mixer)

idxs <- sample(1:nrow(mixer), as.integer(0.7 * nrow(mixer)))
train <- mixer[idxs, ]
test <- mixer[-idxs, ]

k <- 2

result <- kNN(Quality ~ Sensor, train, test, norm = FALSE, k)

new <- data.frame(실제값 = test$Quality)
new$예측값 <- result

predict_table <- table(new$예측값, new$실제값)
dimnames(predict_table) <- list("predicted" = rownames(predict_table), "observed" = colnames(predict_table))

predict_table

new$result <- ifelse(new$실제값 == new$예측값, "Y", "N")
predict_prob <- sum(new$result == "Y") / length(new$result)

cat("일치하는 비율: ", predict_prob, "\n")

ggplot(new, aes(x = 예측값, fill = result)) +
  geom_bar() +
  labs(title = "kNN 예측 결과", x = "예측값", y = "빈도") +
  scale_fill_manual(values = c("Y" = "green", "N" = "red"))
