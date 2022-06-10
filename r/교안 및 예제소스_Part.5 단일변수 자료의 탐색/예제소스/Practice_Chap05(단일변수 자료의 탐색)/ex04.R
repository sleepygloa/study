# 박스상자그림 - boxplot()
dist <- cars[,2]
class(dist)
quantile(x = dist)

summary(object = dist)

boxplot(x = dist, main = "자동차 제동거리")

# 위의 박스상자그림을 보게되면 수치적인 부분을 알고자 한다면
# stats()사용하면 된다.
boxplot.stats(x = dist)

# 내장데이터셋을 이용하여 박스상자 그리기
head(iris)

# Petal.Length~Species매개변수는 Petal.Length를 기준으로 하되
# Species별로 그려달라.
boxplot(Petal.Length~Species, data = iris, 
        main = "품종별 꽃잎의 길이")

boxplot(iris$Petal.Length~iris$Species, 
        main = "품종별 꽃잎의 길이")

mag <- quakes$mag
head(mag)
boxplot(x = mag, main="지진 발생 강도 분포", xlab="지진", 
        ylabl="발생건수", col="red")

boxplot.stats(mag)

# 화면 분할 방법
View(mtcars)
dim(mtcars)
# par()화면 분할을 하는데 1행에 3개의 차트를 나타내줘라는 명령어
par(mfrow=c(1,3)) 
barplot(table(mtcars$carb),
        main = "캬브레터 막대그래프",
        xlab = "캬브레터",
        ylab = "빈도수",
        col = "blue"
)
barplot(table(mtcars$cyl),
        main = "실린더 막대그래프",
        xlab = "실린더",
        ylab = "빈도수",
        col = "red"
)
barplot(table(mtcars$gear),
        main = "기어 막대그래프",
        xlab = "기어",
        ylab = "빈도수",
        col = "blue"
)
par(mfrow=c(1,1)) # 화면분할 해제 