# 인구통계학적 데이터를 이용해서 어떤 모집군에 쿠폰을 나눠줄 것인가
#
# 식사시간 전에 팝업이나 알림을 띄워 쿠폰을 배포한다.
# 주문별 사용금액을 확인하고 평균 주문금액 이상 주문시 할인 쿠폰. ex) 평균 주문금액은 15000원, 그러면 2만원 이상 주문시 2000원 할인 등

setwd("C:/WORK_R/datamining_PBL1")

library("prettyR")

# 데이터 불러오기
data2019  <- read.csv("업종_목적지별_배달_주문건수 (3).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
data2020  <- read.csv("업종_목적지별_배달_주문건수 (2).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
data2021  <- read.csv("업종_목적지별_배달_주문건수 (1).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

# 데이터프레임 병합
pre_data <- rbind(data2019, data2020, data2021)

# 데이터 열 추출
pre_data <- subset(pre_data, select = c(V1, V4, V5, V6))

# 데이터프레임 열 이름 변경
names(pre_data) <- c("주문날짜", "도/특별시/광역시", "시/군/구", "주문건수")

# 데이터프레임 정렬
pre_data <- pre_data[order(pre_data$'주문날짜', pre_data$'도/특별시/광역시', pre_data$'시/군/구', pre_data$'주문건수'), ]

# View(pre_data)

# 데이터 불러오기
region1  <- read.csv("지역_업종_배달평균거리 (1).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region2  <- read.csv("지역_업종_배달평균거리 (2).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region3  <- read.csv("지역_업종_배달평균거리 (3).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region4  <- read.csv("지역_업종_배달평균거리 (4).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region5  <- read.csv("지역_업종_배달평균거리 (5).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)
region6  <- read.csv("지역_업종_배달평균거리 (6).csv", header = FALSE, sep = ",", na.strings = "NA", stringsAsFactors = TRUE)

# 데이터프레임 병합
region <- rbind(region1, region2, region3, region4, region5, region6)

# 데이터 열 추출
region <- subset(region, select = c(V1, V2, V4, V5, V6))

# 데이터프레임 열 이름 변경
names(region) <- c("주문연도", "주문월일", "도/특별시/광역시", "시/군/구", "주문건수")

# 데이터프레임 정렬
region <- region[order(region$'주문연도', region$'주문월일', region$'도/특별시/광역시', region$'시/군/구', region$'주문건수'), ]


View(region)





# setwd("C:/WORK_R")
# write.csv(pre_merge_data2, "datamining_PBL1_Jihoon.csv", row.names = TRUE)