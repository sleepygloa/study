# 다중변수 자료의 분석과 탐색

# 산점도 : 2개의 변수로 구성된 자료의 분포를 알아보는 그래프

dim(mtcars)
class(mtcars)

wt <- mtcars$wt    # 중량자료 추출
mpg <- mtcars$mpg  # 연비 추출

# plot()는 2개의 변수를 가지고 산점도를 그린다.
plot(
     x = wt,     # x축의 값
     y = mpg,    # y축의 값
     main = "중량-연비 그래프", 
     xlab = "중량",
     ylab = "연비",
     col = "red",
     pch = 19    # 그래프에 나타나는 점
)

# 여러 변수들 간의 산점도 
# pairs()를 이용하면 된다.
vars <- c("mpg", "disp", "drat", "wt") # 문자형 벡터
target <- mtcars[,vars]
head(target)
class(target)

# 다중 변수들간의 산점도를 그리고자 할 때 사용한다.
pairs(x = target, 
      main = "다중변수 산점도")

# 그룹정보가 있는 산점도
irisdata <- iris[,3:4]
head(irisdata)

# Species는 품종으로 팩터타입인데 숫자타입(1,2,3)변환하고 있다.
# 이유는 색깔로 구별을 주기 위해서 이 작업을 하고 있다.
point <- as.numeric(iris$Species)
point
class(point)
color <- c("red", "green", "blue")

plot(x = irisdata,
     main = "품종별 산점도",
     pch=c(point),
     col=color[point]
     )

pairs(x = irisdata,
     main = "품종별 산점도",
     pch=c(point),
     col=color[point]
)




