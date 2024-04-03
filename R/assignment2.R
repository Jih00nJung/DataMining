# 웹 스크래핑
library(rvest)
library(stringr)

url <- "https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1"

# 웹 문서 가져오기
usedCar <- read_html(url)
usedCar

# 특정 태그의 데이터 추출
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
km <- str_trim(km)

# 판매가격 추출
price_tmp <- html_nodes(carInfos, css = ".mode-cell.price")
price <- html_text(price_tmp)
price <- str_trim(price)
price <- str_replace(price, '\n', '')       # 문자열 변경 (\n을 스페이스로)

# 차량 명칭으로부터 제조사 추출
maker <- c()
for(i in 1:length(title)) {
  maker <- c(maker, unlist(str_split(title[i], ' '))[1])   # str_split 문자열 분리
}

# 데이터프레임 만들기
usedcars <- data.frame(title, year, fuel, km, price, maker)
View(usedcars)

# km 자료 숫자로 변경
usedcars$km <- gsub("만km", "0000", usedcars$km)
usedcars$km <- gsub("천km", "000", usedcars$km)
usedcars$km <- gsub("km", "", usedcars$km)
usedcars$km <- gsub("미등록", "", usedcars$km)
usedcars$km <- as.numeric(usedcars$km)          # 숫자형으로 변경

# price 자료 숫자로 변경
usedcars$price <- gsub("만원", "", usedcars$price)
usedcars$price <- gsub("계약", "", usedcars$price)
usedcars$price <- gsub("팔림", "", usedcars$price)
usedcars$price <- gsub("금융리스", "", usedcars$price)
usedcars$price <- gsub(",", "", usedcars$price)
usedcars$price <- as.numeric(usedcars$price)

View(usedcars)