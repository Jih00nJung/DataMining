# 5장 데이터 기술통계

# 추론 통계 : 모집단의 특징을 파악하고, 모집단 분포 추론

# 기술 통계 : 빅데이터를 근간으로 현재의 현상을 기술하거나 설명하는 것을 목적

# 빈도 분석 : 범주형 자료의 분포적 특정을 파악하는 기법

# install.packages("descr")
# library(descr)

setwd("C:/WORK_R")

options("width" = 500)
usedcars <- read.csv("usedcars_new.csv", header = T, fileEncoding = "EUC-KR")

freq_data <- subset(usedcars, select = c(maker, fuel))
head(freq_data)

freqc <- table(freq_data$maker)
propc <- prop.table(freqc) * 100
propc_r <- round(propc, 1)
freq_table <- cbind(빈도 = freqc, 백분율 = propc_r)


# 빈도 분석
setwd("C:/WORK_R")
data <- read.csv("air_pollution.csv", header = T, fileEncoding = "EUC-KR")


# 교차 분석
