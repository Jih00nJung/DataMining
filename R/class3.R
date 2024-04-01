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


# 웹 스크래핑
library(rvest)
library(stringr)

url <- "https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K"
usedCar <- read_html(url)
carInfos <- html_nodes(usedCar, css = ".product-item")
head(carInfos)

# 차량 명칭 추출
title_tmp <- html_nodes(carInfos, css = ".tit.ellipsis")
title <- html_text(title_tmp)

# 데이터 정제
title <- str_trim(title)        # 문자열에서 공백 제거

# 차량 연식 추출
year_tmp <- html_nodes(carInfos, css = ".mode-cell.year")
year <- html_text(year_tmp)
year <- str_trim(year)

# 연료 구분
fuel_tmp <- html_nodes(carInfos, css = ".mode-cell.fuel")
fuel <- html_text(fuel_tmp)
fuel <- str_trim(fuel)

# 주행거리 추출
km_tmp <- html_nodes(carInfos, css = ".mode-cell.km")
km <- html_text(km_tmp)
km <- str_trim(km_tmp)

# 판매가격 추출
price_tmp <- html_nodes(carInfos, css = ".mode-cell.price")
price <- html_text(price_tmp)
price <- str_trim(price)
price <- str_replace(price, '\n', '')       # 문자열 변경 (\n을 스페이스로)

# 차량 명칭으로부터 제조사 추출
maker <- c(" ")
for(i in 1:length(title)) {
  marker <- c(maker, unlist(str_split(title[i], ' '))[1])   # str_split 문자열 분리
}

# 데이터프레임 만들기
usedcars <- data.frame(title, year, fuel, km, price, maker)
View(usedcars)
usedcars


