# 3장
# 1번 문제
15 %% 2
27 %/% 4

# 3번 문제
x <- 3
y <- 5
(x < 4)&(y < 4)

# 5번 문제
data <- c(54, 39.6, 51.6, 52.8, 51.6, 52.8, 54, 52.8, 16.8, 52.8, 52.8, 54)

above_50 <- sum(data >= 50)

below_50 <- sum(data < 50)

View(above_50)
View(below_50)


# 9번 문제
smart <- data.frame(
  brand <- c("Samsung", "Huawei", "Apple", "Xiaomi", "OPPO", "Other"),
  quantity <- c(2090, 0.158, 0.121, 0.093, 0.086, 0.332)
)

plot(quantity, main = "smart_phone", type = "o")


# 4장
# 2번 문제
setwd("C:/WORK_R")     # 작업영역 설정
data <- read.csv("data.csv", header = T, fileEncoding = "EUC-KR")

data$합계 <- rowSums(data[, c("품질", "가격", "서비스", "배송")])

View(data)


# 5번 문제
# 대도시, 중도시, 소도시 데이터프레임 생성
data_large <- data[data$주거지역 == "대도시", ]
data_medium <- data[data$주거지역 == "중도시", ]
data_small <- data[data$주거지역 == "소도시", ]

# 데이터프레임을 하나의 새로운 데이터프레임으로 결합
data_living <- rbind(data_large, data_medium, data_small)

# 결과 출력
View(data_living)





# 10번 문제

library(XML)

# API 호출을 위한 기본 정보
service_key <- "5R1W25iameoAVaGDMFaP03PhY4t3LTsoLrt00XESCDquGBzGjfq7YD%2F7LIbb1o0V0km%2FwLqK5pluQch%2BwaiEAQ%3D%3D"
base_url <- "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev"

# API 호출에 필요한 파라미터 설정
lawd_cd <- "11680"  # 강남구 코드
deal_ymd <- "202101"  # 조회할 연도와 월 (예: 2021년 1월)
num_of_rows <- "100"  # 한 페이지에 출력할 결과 수

# API 호출 URL 조합
url <- paste0(base_url, "?serviceKey=", service_key, "&LAWD_CD=", lawd_cd, "&DEAL_YMD=", deal_ymd, "&numOfRows=", num_of_rows)

raw.data <- xmlTreeParse(url, useInternalNodes = TRUE, encoding = "UTF-8")

Gangnam <- xmlToDataFrame(getNodeSet(raw.data, "//item"))

answer5 <- subset(Gangnam, select = c('법정동', '아파트', '거래금액'))

View(Gangnam)
View(answer5)






