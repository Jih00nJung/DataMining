# CSV 텍스트 파일 불러오기
setwd("C:/WORK_R")     # 작업영역 설정
data <- read.csv("data.csv", header = T, fileEncoding = "EUC-KR")
# data                        # 불러온 자료 보기
View(data)                  # View로 불러온 자료 보기


# 엑셀 파일 불러오기 실행
# install.packages("readxl")
# library(readxl)             # 패키지 설치 후 실행
# excel_data <- read_excel("C:/WORK_R/data/xlsx", sheet = "data", col_names = TRUE)
# excel_data

# 자료의 구조 확인
# str(data)       # 'data.frame':	90 obs. of  18 variables:
# 펙터? 벡터로 바꾸면 데이터를 덜 쓴다. 0, 1, -1 등등

# head(data)      # 상위 6개의 자료를 tail() 함수는 하휘 6개 관측치 보기

# dim(data)       # 데이터 객체의 차원 보기

# length(data)    # 데이터 객체의 요소들의 개수를 산출


# 1) 변수의 생성 및 변환
# 신규생성
data$변수 <- 'new'        # 변수라는 항목의 모든 열의 값을 'new'로 변경
data$쇼핑합계 <- data$쇼핑1월 + data$쇼핑2월 + data$쇼핑3월    # 합계항목 등록
data$쇼핑평균 <- mean(data$쇼핑1월 + data$쇼핑2월 + data$쇼핑3월)    # 평균항목 등록
View(data)
# data

# w/   : with
# w/o  : without
# xing : crossing


# 데이터의 분할
# data
data1 <- subset(data, data$성별=='남자')
data2 <- subset(data, data$성별=='여자')
# data1
# data2

# 데이터의 추출
sub_data <- subset(data, select = c(성별, 연령대, 직업, 쇼핑액))
# sub_data        # 성별, 연령대, 직업, 쇼핑액으로만 구성된 데이터프레임
View(sub_data)

# 수직적 자료의 결합
data3 <- rbind(data1, data2)
# data3


# apply() 함수
# apply(data, 2, max)     # 모든 컬럼에서의 max값 산출


