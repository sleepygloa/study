# 단일변수 (범주형, 연속형)에 분석을 해보고 그래프로 
# 데이터시각화를 한번 해보는 시간

favorite <- c("WINTER","SUMMER","SPRING","SUMMER", "SUMMER",
              "SPRING", "FALL", "FALL", "SUMMER","FALL")
class(favorite)
length(favorite)  
table(favorite)   # 범주형 데이터에서 빈도수를 출력
table(favorite)/length(favorite)   # 비율 계산

ds <- table(favorite)
class(ds)
str(ds)
ds

# 막대그래프 
c <- c("green","red","yellow","black")
barplot(ds, main = "선호하는 계절", col=c)

#원 그래프 
pie(ds, main = "선호하는 계절", col=c)

favoritecolor <- c(2,3,1,1,1,3,1,1,1,2,1)
length(favoritecolor)
favoritecolor
ds <- table(favoritecolor)
class(ds)
ds

barplot(ds, main = "선호하는 색상", col=c)
c <- c("green","red","blue")
# names()이용을 하여 자료값 1,2,3을 green,red,blue로 변경
names(ds) <- c 
ds

pie(ds,main = "선호하는 색상",col=c)


# 막대그래프에 속성을 최대한 이용함
height <- c(9,15,20,6)
name <- c("영업1팀","영업2팀","영업3팀","영업4팀")
barplot(height, names.arg = name, main = "부서별 영업 실적",
        col=rainbow(length(height)), xlab="부서", 
        ylab="영업실적(억원)")


# 원그래프에 속성을 최대한 이용함
x <- c(9,15,20,6)
label <- c("영업1팀","영업2팀","영업3팀","영업4팀")
pie(x, main = "부서별 영업실적")

pie(x, init.angle = 90, labels = label, main = "부서별 영업실적")
pct <- round(x/sum(x)*100)  # 각 항목의 비율 구함
pct

label <- paste(label, pct)
label <- paste(label, '%')
label
pie(x, init.angle = 90, labels = label, col = rainbow(length(x)),
    main = "부서별 영업실적")
