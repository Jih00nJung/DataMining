# Pasteurizer rpart() 사용

# install.packages("rpart", repos = "https://cran.r-project.org/")
# install.packages("rpart.plot", repos = "https://cran.r-project.org/")

library(rpart)
library(rpart.plot)

setwd("C:/WORK_R/Dataset_Pasteurizer")
pasteurizer_r <- read.csv("pasteurizer.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

pasteurizer_r <- na.omit(pasteurizer_r)
pasteurizer_r$INSP <- as.factor(pasteurizer_r$INSP)
pasteurizer_r <- pasteurizer_r[pasteurizer_r$MIXA_PASTEUR_STATE < 2, ]

cat("pasteurizer_r str \n")
str(pasteurizer_r)

set.seed(1234)
idxs_r <- sample(1:nrow(pasteurizer_r), as.integer(0.7 * nrow(pasteurizer_r)))
train_r <- pasteurizer_r[idxs, ]
test_r <- pasteurizer_r[-idxs, ]

model_r<- rpart(INSP ~ MIXA_PASTEUR_STATE + MIXB_PASTEUR_STATE + MIXA_PASTEUR_TEMP + MIXB_PASTEUR_TEMP, data = train_r)

rpart.plot(model_r, type = 2, extra = 101, digits = 1)

cat("pasteurizer_r 끝 \n\n\n")


# 의사결정나무 Welding

# install.packages("tree", repos = "https://cran.r-project.org/")

library(tree)

setwd("C:/WORK_R/Dataset_Pasteurizer")
pasteurizer <- read.csv("Pasteurizer.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

welding <- na.omit(pasteurizer)

str(pasteurizer)

set.seed(1234)
idxs <- sample(1:nrow(pasteurizer), as.integer(0.7 * nrow(pasteurizer)))
train <- pasteurizer[idxs, ]
test <- pasteurizer[-idxs, ]

cat("model \n")
model <- tree(INSP ~ MIXA_PASTEUR_STATE + MIXB_PASTEUR_STATE + MIXA_PASTEUR_TEMP + MIXB_PASTEUR_TEMP, data = train)

plot(model)
text(model, pretty = 2, all = TRUE)

