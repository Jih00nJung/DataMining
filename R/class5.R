# chapter 6, 데이터 추론통계

# 작업영역 설정 및 파일 불러오기
setwd("C:/WORK_R")
options("width" = 500)
data <- read.csv("data.csv", header = T, fileEncoding = "EUC-KR")

View(data)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 평균 차이 분석 실행
data1 <- subset(data, data$성별 == '남자')
data2 <- subset(data, data$성별 == '여자')

View(data1)
View(data2)

t_result <- t.test(data1$쇼핑액, data2$쇼핑액)
t_result

# 결과값
# data:  data1$쇼핑액 and data2$쇼핑액
# t = 0.92362, df = 57.42, p-value = 0.3595
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#  -8.833426 23.962777
# sample estimates:
# mean of x mean of y
#  177.1418  169.5771

# p-value 가 0.05보다 작아야 유의미한 데이터라고 할 수 있다.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 대응 표본 평균 차이 분석
t_result2 <- t.test(data$`쇼핑1월`, data$`쇼핑2월`, paired = TRUE)
t_result2

# 결과값 (p-value가 0.05 이상이라 95% 신뢰수준에서는 별 차이가 없다고 판단된다.)
# 	Paired t-test
#
# data:  data$쇼핑1월 and data$쇼핑2월
# t = 1.7024, df = 89, p-value = 0.09216
# alternative hypothesis: true mean difference is not equal to 0
# 95 percent confidence interval:
#  -0.644027  8.350694
# sample estimates:
# mean difference
#        3.853333

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

n1 <- length(which(data$성별 == "남자"))
n2 <- length(which(data$성별 == "여자"))
n <- c(n1, n2)
n

x1 <- length(which(data$성별 == "남자"&data$쿠폰선호도 == "예"))
x2 <- length(which(data$성별 == "여자"&data$쿠폰선호도 == "예"))
x <- c(x1, x2)
x

# 비율 차이 분석
prop_result <- prop.test(x, n)
prop_result

# 결과값
# 2-sample test for equality of proportions with continuity correction
#
# data:  x out of n
# X-squared = 8.7715, df = 1, p-value = 0.00306
# alternative hypothesis: two.sided
# 95 percent confidence interval:
#  -0.5604717 -0.1252426
# sample estimates:
#    prop 1    prop 2
# 0.4000000 0.7428571

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

aov_result1 <- aov(data$`쇼핑액`~data$`주거지역`, data)
# aov_result1
summary(aov_result1)

# 결과값 (Pr이 p-value이다.) 0.4이므로 유의미하지 않다.
#               Df Sum Sq Mean Sq F value Pr(>F)
# data$주거지역  2   1956   978.1   0.774  0.464
# Residuals     87 109935  1263.6

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

aov_data <- as.data.frame(rbind(cbind(data$`쇼핑1월`, 1), cbind(data$`쇼핑2월`, 2), cbind(data$`쇼핑3월`, 3)))
colnames(aov_data) <- c("쇼핑액", "월")
aov_data

aov_result2 <- aov(쇼핑액 ~ 월, aov_data)
# aov_result2
summary(aov_result2)

# 결과값 (p-value가 0.05보다 낮기 때문에  유의미하다.)
#              Df Sum Sq Mean Sq F value   Pr(>F)
# 월            1  12802   12802   37.77 2.87e-09 ***
# Residuals   268  90841     339
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 상관관계 분석

cor(data$`쇼핑액`, data$`이용만족도`)
cor.test(data$`쇼핑액`, data$`이용만족도`)

# 결과값, p-value가 0.81이라 차이가 없다, 즉 유의미하지 않다.
# 	Pearson's product-moment correlation
#
# data:  data$쇼핑액 and data$이용만족도
# t = 0.24115, df = 88, p-value = 0.81
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  -0.1823636  0.2315569
# sample estimates:
#        cor
# 0.02569807

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 상관관계 분석

data <- subset(data, select = c(성별, 연령대, 직업, 주거지역, 쇼핑액))

data$`성별` <- as.numeric(as.factor(data$`성별`))
data$`연령대` <- as.numeric(as.factor(data$`연령대`))
data$`직업` <- as.numeric(as.factor(data$`직업`))
data

# install.packages("Hmisc")
library(Hmisc)
pearson_result <- rcorr(as.matrix(data), type = "pearson")
pearson_result


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 회귀 분석

regression_result <- lm(쇼핑만족도 ~ 품질 + 가격 + 서비스 + 배송, data)
summary(regression_result)






