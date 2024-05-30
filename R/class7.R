# 7장 데이터마이닝1
library(e1071)
data <- iris
View(iris)

set.seed(1234)          # 표본 추출값 고정 (여기서 1234가 뭘 의미하는가)
idxs <- sample(1:nrow(data), as.integer(0.7 * nrow(data)))        # data의 70% 표본 추출
train <- data[idxs,]        # 훈련용 데이터셋
test <- data[-idxs,]        # 검증용 데이터셋
model <- naiveBayes(Species ~ ., train)

View(test)

new <- data.frame(실젯값 = test$Species)       # 실젯값
new$예측값 <- predict(model, test)       # 분류(예측값 생성)

predict_table <- table(new$예측값, new$실젯값)        # 정오 분류표 생성
names(dimnames(predict_table)) <- c("predicted", "observed")
predict_table       # 정오 분류표

# 결과값
#             observed
# predicted    setosa versicolor virginica
#   setosa         16          0         0
#   versicolor      0         14         1
#   virginica       0          2        12

# 예측 적중률 산출
new$result <- ifelse(new$실젯값 == new$예측값, "Y", "N")        # 관측/예측값 비교 결과
predict_prob <- sum(new$result == "Y") / length(new$result)       # 에측 확률
predict_prob        # 0.9333333