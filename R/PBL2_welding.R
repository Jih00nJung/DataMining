library("e1071")

setwd("C:/WORK_R/Dataset_Welding")

welding <- read.csv("normal_data.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

head(welding)

welding <- na.omit(welding)

welding$PIPE_NO <- as.factor(welding$PIPE_NO)

set.seed(1234)
idxs <- sample(1:nrow(welding), as.integer(0.7 * nrow(welding)))
train <- welding[idxs, ]
test <- welding[-idxs, ]

model <- svm(FIN_JGMT ~ DV_R + DA_R + AV_R + AA_R + PM_R,
             data = train,
             type = "C-classification",
             kernel = "radial",
             cost = 10,
             gamma = 0.1)

predictions <- predict(model, newdata = test)

confusion_matrix <- table(predictions, test$FIN_JGMT)
print(confusion_matrix)

accuracy <- sum(predictions == test$FIN_JGMT) / length(test$FIN_JGMT)
cat("Accuracy:", accuracy, "\n")
