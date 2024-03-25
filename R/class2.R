# 데이터 마이닝 24.03.25

# 산술연산자
x <- c(1, 2, 3, 4);
z <- c(1, 2);
x + z         # 2, 4, 4, 6

x <- 4;
x != 5;       # TRUE

x <- 4
x ++ 5        # 9


# 벡터에 대한 비교 연산

x <- c(1, 2, 3, 4, 5, 6, 7)
y <- c(1, 3, 5, 7, 9, 11, 13)
x[x>3]        # 4 5 6 7


# 논리 연산 (and, or, not, Not Available)

# &&는 하나의 벡터 결과만 리턴한다.
x <- c(3, 4)
y <- c(4, 5)
# (x < 4)&&(y < 5)    # 벡터 다른 값이 있어서 오류 나는데 어떻게 함..?
# (x < 4)&&(y < 4)


# ifelse문
x <- 3
y <- 5
z <- ifelse((x < y), 1, 0)
z       # 1


# for문
x <- 1
for(i in 1:5) {
  x <- x + 2
}
x       # 11


# repeat문 : 무조건 반복, break문을 이용하여 실행 중단
x <- 1
i <- 0
repeat {
  x <- x + 2
  if(i >= 9) break
  i <- i + 1
}
x      # 21


# 중복 고수준 그래프 작성하기
data <- c(5, 7, 3, 4, 5, 9, 10)
barplot(data)
par(new=T)
plot(data, type = "o")










