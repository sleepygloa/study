# 상관분석에 대해서 이해하기

# 음주량
beers <- c(5,2,9,8,3,7,3,5,3,5)
# 혈중 알콜 농도 
bal <- c(0.1,0.03,0.19,0.12,0.04,0.0095,0.07,0.06,0.02,0.05)
length(bal)

data <- data.frame(beers, bal)
dim(data)
head(data)

# 산점도 그리기
plot(bal~beers, data = data)

# lm()함수는 회귀식을 구하는 함수
res <- lm(bal~beers, data = data)
class(res)

# 회귀선을 그리는 함수이다.
abline(res)

# 상관계수를 구하는 함수가 cor()이다.
# -1 <= r <= 1
# -0.5보다 작거나 혹은 1에 가까울수록 상관성이 높다.
cor(beers, bal)

# iris데이터셋의 4개의 변수의 상관계
cor(iris[, 1:4])

mtcars

# 연비를 가져옴
mpg <- mtcars$mpg
# 배기량을 가져옴
disp <- mtcars$disp
# 중량을 가져옴
wt <- mtcars$wt

carb <- mtcars$carb

plot(x = mpg, y = disp)
plot(x = mpg, y = wt)
plot(x = mpg, y = carb)


# 연비와 배기량은 상관계수가 -1에 가깝다.
cor(mpg, disp)
# 연비와 중량은 상관계수가 -1에 가깝다.
cor(mpg, wt)
# 연비와 캬브레터의 상관계수가 -0.55이다.
cor(mpg, carb)

