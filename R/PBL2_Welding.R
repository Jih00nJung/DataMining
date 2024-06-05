# Welding tree

# install.packages("tree", repos = "https://cran.r-project.org/")

library(tree)

setwd("C:/WORK_R/Dataset_Welding")
welding <- read.csv("Welding.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

welding <- na.omit(welding)

str(welding)

set.seed(1234)
idxs <- sample(1:nrow(welding), as.integer(0.7 * nrow(welding)))
train <- welding[idxs, ]
test <- welding[-idxs, ]

cat("model \n")
model <- tree(FIN_JGMT ~ DV_R + DA_R + AV_R + AA_R + PM_R, data = train)

plot(model)
text(model, pretty = 5, all = TRUE)