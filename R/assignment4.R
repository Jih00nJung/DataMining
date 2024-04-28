setwd("C:/WORK_R")
data <- read.csv("data.csv", header = TRUE, fileEncoding = "EUC-KR")
View(data)

library(descr)

freq_data <- table(data$성별, data$연령대, data$직업, data$주거지역)
freq_data

# 문제 3번
prop_data <- prop.table(freq_data) * 100
prop_data

freq_data_plot <- freq(freq_data, plot = TRUE)
freq_data_plot

# 문제 5번
# install.packages("gmodels")
library(gmodels)
crosstable <- CrossTable(data$`성별`, data$`연령대`, expected = T, prop.r = T, prop.c = T, prop.t = T, prop.chisq = T, chisq = F, fisher = F, mcnemar = F)

# 문제 7번
# install.packages("dplyr")
library(dplyr)

avg_used <- data %>%
  group_by(연령대) %>%
  summarise(평균_이용만족도 = mean(이용만족도))

avg_used


# 문제 9번
data$쇼핑액 <- round(data$쇼핑액)

stem(data$쇼핑액)


# 6장
# 문제 2번
t_result <- t.test(소득 ~ 성별, data = data)
t_result


# 문제 4번
regi_result <- aov(소득 ~ 주거지역, data = data)
summary(regi_result)

# 문제 6번
re_result <- lm(쇼핑만족도 ~ 소득 + 이용만족도, data = data)

summary(re_result)