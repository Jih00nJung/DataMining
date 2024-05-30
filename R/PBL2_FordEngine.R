# e1071 패키지 설치 및 로드
# install.packages("e1071", repos = "http://cran.us.r-project.org")
library(e1071)

# 작업 디렉토리 설정
setwd("C:/WORK_R/Dataset_Machinevision")

# 데이터 불러오기
left_label <- read.csv("left_label.csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
right_label <- read.csv("right_label.csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

# 데이터 결합
label <- rbind(left_label, right_label)

# pf 변수 생성
pf <- ifelse(label$V1 > 0.8 & label$V1 < 1.5, 1, 0)

# pf 변수를 factor 형식으로 변환
pf <- as.factor(pf)

# pf 변수를 label 데이터 프레임에 추가
label <- data.frame(label, pf)

# 데이터 확인
head(label)

# 데이터 분할 (70% 훈련 데이터, 30% 테스트 데이터)
set.seed(1234)
idxs <- sample(1:nrow(label), as.integer(0.7 * nrow(label)))
train <- label[idxs,]
test <- label[-idxs,]

# SVM 모델 생성
model <- svm(pf ~ V1, data = train, type = "C-classification", kernel = "radial", cost = 10, gamma = 0.1)

# 테스트 데이터에 대한 예측 수행
new <- data.frame(실제값 = test$pf)
new$예측값 <- predict(model, newdata = test)

# 예측 결과 확인
predict_table <- table(new$예측값, new$실제값)
names(dimnames(predict_table)) <- c("predicted", "observed")

# 예측 테이블 출력
print(predict_table)

# 정확도 계산
accuracy <- sum(new$예측값 == new$실제값) / nrow(test)
cat("Accuracy:", accuracy, "\n")
