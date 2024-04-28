# 인구통계학적 데이터를 이용해서 어떤 모집군에 쿠폰을 나눠줄 것인가

setwd("C:/Users/ghdah/문서/과제/데이터마이닝/데이터마이닝 PBL1/pre_data_정지훈_91910773/bigdata")
# install.packages('lubridate')
# install.packages('zoo')

library("prettyR")
library(descr)
library(lubridate)
library(zoo)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 데이터 불러오기
data2019  <- read.csv("업종_목적지별_배달_주문건수 (3).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
data2020  <- read.csv("업종_목적지별_배달_주문건수 (2).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
data2021  <- read.csv("업종_목적지별_배달_주문건수 (1).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

# 데이터프레임 병합
per_delivery <- rbind(data2019, data2020, data2021)

# 데이터 열 추출 (각각 주문날짜, 시/도/광역시, 주문건수 컬럼이다.)
per_delivery <- subset(per_delivery, select = c(V1, V4, V6))
per_delivery$V1 <- as.yearmon(per_delivery$V1)
# yearmon() 함수는 연도와 월까지 가져온다.
# (일별로 출력하면 데이터가 너무 많아 플롯을 확인하는데 불편함이 있을거라 생각해서 월까지만 출력)


# 데이터프레임 열 이름 변경
names(per_delivery) <- c("date", "state", "order_cnt")

# 날짜 date 자료형으로 변경 (region 데이터와 형식을 맞추기 위해 사용했다.)
per_delivery$date <- as.Date(per_delivery$date, format = "%Y-%m-%d")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 데이터 불러오기
region1  <- read.csv("지역_업종_배달평균거리 (1).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region2  <- read.csv("지역_업종_배달평균거리 (2).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region3  <- read.csv("지역_업종_배달평균거리 (3).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region4  <- read.csv("지역_업종_배달평균거리 (4).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region5  <- read.csv("지역_업종_배달평균거리 (5).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region6  <- read.csv("지역_업종_배달평균거리 (6).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

# 데이터프레임 병합
region <- rbind(region1, region2, region3, region4, region5, region6)

# 데이터프레임 주문연도, 주문월일 합치기
# region 데이터는 연도와 월이 따로 나타나 있어서 paste() 함수로 날짜를 ex) 24-04-01, 이런 식으로 붙여
# as.Date() 함수보다 형식에 느슨한 ymd() 함수로 date 자료형으로 만들었다.
region$date <- ymd(paste(region$V1, region$V2, "01", sep = "-"))

# 데이터 열 추출 (각각 주문날짜, 시/도/광역시, 주문건수 컬럼이다.)
region <- subset(region, select = c(date, V4, V6))

# 데이터프레임 열 이름 변경
colnames(region) <- c("date", "state", "order_cnt")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 중복 데이터 합치기
per_delivery <- aggregate(per_delivery$order_cnt, by = list(per_delivery$date, per_delivery$state), FUN = sum)
region <- aggregate(region$order_cnt, by = list(region$date, region$state), FUN = sum)

# 데이터프레임 열 이름 변경
names(per_delivery) <- c("date", "state", "order_cnt")
names(region) <- c("date", "state", "order_cnt")

# 데이터프레임 정렬
per_delivery <- per_delivery[order(per_delivery$date), ]
region <- region[order(region$date), ]

# 데이터프레임 출력
View(per_delivery)
View(region)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 지역별로 나눈 per_delivery와 region 데이터를 plot으로 출력, 범례 추가
# per_delivery와 region 데이터의 결과가 유사해서 같이 출력하여 보는 것이 편할 것이라 생각해서 같은 plot 상에 출력했다.

# 서울특별시 데이터 플롯
Seoul_data <- region[region$state == "서울특별시",]
Seoul_per_data <- per_delivery[per_delivery$state == "서울특별시",]

plot(Seoul_data$date, Seoul_data$order_cnt, main = "Seoul Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Seoul_per_data$date, Seoul_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 경기도 데이터 플롯
Gyeonggi_data <- region[region$state == "경기도",]
Gyeonggi_per_data <- per_delivery[per_delivery$state == "경기도",]

plot(Gyeonggi_data$date, Gyeonggi_data$order_cnt, main = "Gyeonggi-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Gyeonggi_per_data$date, Gyeonggi_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 인천광역시 데이터 플롯
Incheon_data <- region[region$state == "인천광역시",]
Incheon_per_data <- per_delivery[per_delivery$state == "인천광역시",]

plot(Incheon_data$date, Incheon_data$order_cnt, main = "Incheon Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Incheon_per_data$date, Incheon_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 제주특별자치도 데이터 플롯
Jeju_data <- region[region$state == "제주특별자치도",]
Jeju_per_data <- per_delivery[per_delivery$state == "제주특별자치도",]

plot(Jeju_data$date, Jeju_data$order_cnt, main = "Jeju Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Jeju_per_data$date, Jeju_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 부산광역시 데이터 플롯
Busan_data <- region[region$state == "부산광역시",]
Busan_per_data <- per_delivery[per_delivery$state == "부산광역시",]

plot(Busan_data$date, Busan_data$order_cnt, main = "Busan Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Busan_per_data$date, Busan_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 울산광역시 데이터 플롯
Ulsan_data <- region[region$state == "울산광역시",]
Ulsan_per_data <- per_delivery[per_delivery$state == "울산광역시",]

plot(Ulsan_data$date, Ulsan_data$order_cnt, main = "Ulsan Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Ulsan_per_data$date, Ulsan_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 광주광역시 데이터 플롯
Gwangju_data <- region[region$state == "광주광역시",]
Gwangju_per_data <- per_delivery[per_delivery$state == "광주광역시",]

plot(Gwangju_data$date, Gwangju_data$order_cnt, main = "Gwangju Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Gwangju_per_data$date, Gwangju_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 대구광역시 데이터 플롯
Daegu_data <- region[region$state == "대구광역시",]
Daegu_per_data <- per_delivery[per_delivery$state == "대구광역시",]

plot(Daegu_data$date, Daegu_data$order_cnt, main = "Daegu Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Daegu_per_data$date, Daegu_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 대전광역시 데이터 플롯
Daejeon_data <- region[region$state == "대전광역시",]
Daejeon_per_data <- per_delivery[per_delivery$state == "대전광역시",]

plot(Daejeon_data$date, Daejeon_data$order_cnt, main = "Daejeon Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Daejeon_per_data$date, Daejeon_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 강원도 데이터 플롯
Gangwon_data <- region[region$state == "강원도",]
Gangwon_per_data <- per_delivery[per_delivery$state == "강원도",]

plot(Gangwon_data$date, Gangwon_data$order_cnt, main = "Gangwon-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Gangwon_per_data$date, Gangwon_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 충청북도 데이터 플롯
Chungcheongbuk_data <- region[region$state == "충청북도",]
Chungcheongbuk_per_data <- per_delivery[per_delivery$state == "충청북도",]

plot(Chungcheongbuk_data$date, Chungcheongbuk_data$order_cnt, main = "Chungcheongbuk-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Chungcheongbuk_per_data$date, Chungcheongbuk_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 충청남도 데이터 플롯
Chungcheongnam_data <- region[region$state == "충청남도",]
Chungcheongnam_per_data <- per_delivery[per_delivery$state == "충청남도",]

plot(Chungcheongnam_data$date, Chungcheongnam_data$order_cnt, main = "Chungcheongnam-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Chungcheongnam_per_data$date, Chungcheongnam_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 경상북도 데이터 플롯
Gyeongsangbuk_data <- region[region$state == "경상북도",]
Gyeongsangbuk_per_data <- per_delivery[per_delivery$state == "경상북도",]

plot(Gyeongsangbuk_data$date, Gyeongsangbuk_data$order_cnt, main = "Gyeongsangbuk-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Gyeongsangbuk_per_data$date, Gyeongsangbuk_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 경상남도 데이터 플롯
Gyeongsangnam_data <- region[region$state == "경상남도",]
Gyeongsangnam_per_data <- per_delivery[per_delivery$state == "경상남도",]

plot(Gyeongsangnam_data$date, Gyeongsangnam_data$order_cnt, main = "Gyeongsangnam-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Gyeongsangnam_per_data$date, Gyeongsangnam_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 전라북도 데이터 플롯
Jeollabuk_data <- region[region$state == "전라북도",]
Jeollabuk_per_data <- per_delivery[per_delivery$state == "전라북도",]

plot(Jeollabuk_data$date, Jeollabuk_data$order_cnt, main = "Jeollabuk-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Jeollabuk_per_data$date, Jeollabuk_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)

# 전라남도 데이터 플롯
Jeollanam_data <- region[region$state == "전라남도",]
Jeollanam_per_data <- per_delivery[per_delivery$state == "전라남도",]

plot(Jeollanam_data$date, Jeollanam_data$order_cnt, main = "Jeollanam-do Order Counts", xlab = "Month", ylab = "Order Count", type = "o", col = "blue")
lines(Jeollanam_per_data$date, Jeollanam_per_data$order_cnt, type = "o", col = "red")
legend("topright", legend = c("Order Counts", "Average Distance"), col = c("blue", "red"), lty = 1:2)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 데이터프레임 리스트 생성

# data_list <- list(
#   "Seoul_data" = Seoul_data,
#   "Seoul_per_data" = Seoul_per_data,
#   "Gyeonggi_data" = Gyeonggi_data,
#   "Gyeonggi_per_data" = Gyeonggi_per_data,
#   "Incheon_data" = Incheon_data,
#   "Incheon_per_data" = Incheon_per_data,
#   "Jeju_data" = Jeju_data,
#   "Jeju_per_data" = Jeju_per_data,
#   "Busan_data" = Busan_data,
#   "per_data" = Busan_per_data,
#   "Ulsan_data" = Ulsan_data,
#   "Ulsan_per_data" = Ulsan_per_data,
#   "Gwangju_data" = Gwangju_data,
#   "Gwangju_per_data" = Gwangju_per_data,
#   "Daegu_data" = Daegu_data,
#   "Daegu_per_data" = Daegu_per_data,
#   "Daejeon_data" = Daejeon_data,
#   "Daejeon_per_data" = Daejeon_per_data,
#   "Gangwon_data" = Gangwon_data,
#   "Gangwon_per_data" = Gangwon_per_data,
#   "Chungcheongbuk_data" = Chungcheongbuk_data,
#   "Chungcheongbuk_per_data" = Chungcheongbuk_per_data,
#   "Chungcheongnam_data" = Chungcheongnam_data,
#   "Chungcheongnam_per_data" = Chungcheongnam_per_data,
#   "Gyeongsangbuk_data" = Gyeongsangbuk_data,
#   "Gyeongsangbuk_per_data" = Gyeongsangbuk_per_data,
#   "Gyeongsangnam_data" = Gyeongsangnam_data,
#   "Gyeongsangnam_per_data" = Gyeongsangnam_per_data,
#   "Jeollabuk_data" = Jeollabuk_data,
#   "Jeollabuk_per_data" = Jeollabuk_per_data,
#   "Jeollanam_data" = Jeollanam_data,
#   "Jeollanam_per_data" = Jeollanam_per_data
# )
#
# # 각 데이터프레임 저장
# setwd("C:/WORK_R")
#
# lapply(names(data_list), function(x) {
#   write.csv(data_list[[x]], paste0(x, ".csv"), row.names = TRUE)
# })
#
# # 데이터프레임 저장
# write.csv(per_delivery, "per_delivery.csv", row.names = TRUE)
# write.csv(region, "region.csv", row.names = TRUE)

