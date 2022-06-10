# 보스톤하우징 데이터셋을 분석을 해본다.

# 데이터 수집
# BostonHousing데이터셋을 활용하기 위해서 아래와 같이 
# mlbench패키지를 인스톨한다.
install.packages("mlbench")  
data("BostonHousing")

# 5개의 변수만 추출해서 따로 데이터셋을 만든다.
myds <- BostonHousing[,c("crim","rm","dis","tax","medv")]
head(myds)
dim(myds)
grp <- c()
# grp변수에다가 medv(주택가격) 상, 중, 하 분류한 내용을 저장
# 506번 루핑하면서 해당 값을 grp에 저장함.
for(i in 1:nrow(myds)){
  if(myds$medv[i] >= 25.0){
    grp[i] <- "H"
  }else if(myds$medv[i] < 25.0 & myds$medv[i] > 17.0){
    grp[i] <- "M"
  }else{
    grp[i] <- "L"
  }
}

grp <- factor(grp)
# 팩터값 조정
grp <- factor(grp, levels = c("H","M","L"))
grp
# 기존의 myds라는 데이터프레임에 grp팩터를 추가해서 
# 새로운 데이터셋을 만듬.
myds <- data.frame(myds, grp)
View(myds)

str(myds)
head(myds)
tail(myds)

# 그룹별 주택의 빈도수
table(myds$grp)

# 분석과정 시작
# 1.히스토그램 차트 작성
par(mfrow=c(2,3)) # 가상화면 분할

for(i in 1:5){
  hist(myds[,i],
       main = colnames(myds)[i],
       col = "yellow"
  )
}

par(mfrow=c(1,1)) # 가상화면 원복

# 2. 박스상자 
par(mfrow=c(2,3)) # 가상화면 분할

for(i in 1:5){
  boxplot(myds[,i],
          main = colnames(myds)[i]
  )
}

par(mfrow=c(1,1)) # 가상화면 원복

# 그룹별 관측값 분포
boxplot(myds$crim~myds$grp, main="1인당 범죄율")

boxplot(myds$rm~myds$grp, main="방의 갯수")

# 다중 산점도를 통한 변수들 간의 상관관계 
pairs(myds[,-6])

point <- as.integer(myds$grp)
point
color <- c("red","green","blue")
pairs(myds[,-6], pch=point, col= color[point])

# 변수 간의 상관계수를 확인
cor(myds[,-6])


