library(prettyR)

# 2장

# 연습문제 3번
sqrt(sum(1:999))

# 연습문제 5번
a <- c(1, 2, 0.5, 3, 7, -2, 10)
a[2]

# 연습문제 6번
b <- c(54, 39.6, 51.6, 52.8, 54, 52.8, 16.8, 52.8, 52.8, 54)
sum(b)    # 481.2
mean(b)   # 48.12
sd(b)     # 11.81795
min(b)    # 16.8
max(b)    # 54

# 연습문제 7번
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
y <- matrix(x, ncol=3)
y

# 연습문제 8번
x <- c(1, 2, 3, 4)                          # 1 1    red  TRUE
y <- c("red", "white", "blue", "yellow")    # 2 2  white  TRUE
z <- c(TRUE, TRUE, TRUE, FALSE)             # 3 3   blue  TRUE
df <- data.frame(x, y, z)                  # 4 4 yellow FALSE
df

# 연습문제 9번
mean(df[,1])
sum(df[,1])

# 연습문제 10번
colnames(df)
colnames(df) <- c("숫자", "색상", "논리값")
df