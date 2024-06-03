# Pasteurizer

# install.packages("rpart", repos = "https://cran.r-project.org/")
# install.packages("rpart.plot", repos = "https://cran.r-project.org/")

library(rpart)
library(rpart.plot)

setwd("C:/WORK_R/Dataset_Pasteurizer")
pasteurizer <- read.csv("pasteurizer.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

pasteurizer <- na.omit(pasteurizer)
pasteurizer$INSP <- as.factor(pasteurizer$INSP)
pasteurizer <- pasteurizer[pasteurizer$MIXA_PASTEUR_STATE < 2, ]

cat("pasteurizer str \n")
str(pasteurizer)

set.seed(1234)
idxs <- sample(1:nrow(pasteurizer), as.integer(0.7 * nrow(pasteurizer)))
train <- pasteurizer[idxs, ]
test <- pasteurizer[-idxs, ]

model <- rpart(INSP ~ MIXA_PASTEUR_STATE + MIXB_PASTEUR_STATE + MIXA_PASTEUR_TEMP + MIXB_PASTEUR_TEMP, data = train)

rpart.plot(model, type = 2, extra = 101, digits = 1)

