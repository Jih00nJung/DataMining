# 품질 이상탐지 진단 (전해탈지)       electro_cleaning

# 패키지 설치 및 로드
# install.packages("e1071", repos = "http://cran.us.r-project.org")
# install.packages("dplyr")
# install.packages("ggplot2", repos = "http://cran.us.r-project.org")

library(e1071)
library(dplyr)
library(ggplot2)

# 작업 디렉토리 설정
setwd("C:/WORK_R/Dataset_Electro_cleaning")

# 모든 CSV 파일의 파일명을 가져옴
file_list <- list.files(pattern = "*.csv")

# CSV 파일을 읽어와 리스트로 저장
csv_list <- lapply(file_list, read.csv, header = TRUE, sep = ",")

cat("csv_list", "\n")
head(csv_list)

# 리스트의 모든 데이터 프레임을 하나로 결합
combined_data <- bind_rows(csv_list)

# 결합된 데이터 확인
head(combined_data)

combined_data$Time <- as.numeric(as.factor(combined_data$Time))

# 데이터 크기 확인
cat("Number of rows in combined data:", nrow(combined_data), "\n")
cat("Number of columns in combined data:", ncol(combined_data), "\n")

# 데이터 샘플링 및 분할
set.seed(1234)
num_rows <- nrow(combined_data)
sample_size <- as.integer(0.7 * num_rows)

# 샘플링 비율이 데이터 크기보다 큰지 확인
if (sample_size < num_rows) {
  cat("Sample size for training:", sample_size, "\n")
  idxs <- sample(1:num_rows, sample_size)
  train <- combined_data[idxs,]
  test <- combined_data[-idxs,]

  # Naive Bayes 모델 생성
  model <- naiveBayes(Lot ~ pH + Temp + Current, data = train, na.action = na.omit)
  cat("Naive Bayes model created.\n")

  # 테스트 데이터에 대한 예측 수행
  new <- data.frame(실제값 = test$Time)
  new$예측값 <- predict(model, test)
  cat("Predictions completed.\n")

  # 예측 결과 확인
  cat("New Data Frame Head:\n")
  print(head(new))

  # 예측 결과의 테이블 생성
  predict_table <- table(new$예측값, new$실제값)
  names(dimnames(predict_table)) <- c("predicted", "observed")

  # 예측 테이블 출력
  cat("Predict Table:\n")
  print(predict_table)

  # 정확도 계산
  accuracy <- sum(new$예측값 == new$실제값) / nrow(test)
  cat("Accuracy:", accuracy, "\n")

  # 예측값과 실제값을 포함한 데이터프레임 생성
  plot_data <- data.frame(실제값 = new$실제값, 예측값 = new$예측값)

  ggplot(plot_data, aes(x = 실제값, y = 예측값)) +
    geom_point(color = "blue") +
    geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
    labs(x = "Actual Value", y = "Predicted Value", title = "Actual vs. Predicted Values") +
    theme_minimal()
} else {
  cat("Sample size is greater than the number of rows in the data. Please check your data or adjust the sampling ratio.\n")
}

warnings()
