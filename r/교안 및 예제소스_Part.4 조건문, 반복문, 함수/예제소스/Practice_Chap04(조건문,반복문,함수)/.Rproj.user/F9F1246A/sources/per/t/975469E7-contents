# apply() 이해하기 -- 행과 열이 있는 2차원데이터인 매트릭스나
# 데이터프레임에 반복문에 비해서 속도도 빠르고 사용하기도 
# 편리하므로 자주 이용하자.
iris
dim(iris)

apply(iris[,1:4], 1, mean) # row(행)방향으로 함수를 적용함.
apply(iris[,1:4], 2, sum)  # col(열)방향으로 함수를 적용함.

# 사용자 정의함수에 대해서 알아보기

# mymax함수는 두 개의 매개변수를 받아서 큰 값을 리턴하는
# 함수이다.
mymax <- function(x, y){
  if(x>y){
    max <- x
  }else{
    max <- y
  }
  return(max)
}
mymax(10,5)
a <- mymax(50,20)
b <- mymax(50,200)
print(a+b)

# 함수를 정의함에 있어 매개변수 일부의 값을 초기값을 설정
# 을 해본다.
mydiv <- function(x, y=2){
  result <- x/y
  return(result)
}
mydiv(10,3)
mydiv(100)   # 매개변수가 1개 들어가므로 y값은 기본값을 이용 

# 함수는 원래 하나의 기능을 하게끔 구현하는게 맞다.
# R에서는 리턴값을 벡터나 리스트형태로 해서 여러개 값을
# 넘길수가 있다.
myfunc <- function(x, y){
  vsum <- x+y
  vmul <- x*y
  return(list(sum=vsum, mul=vmul))
}
# 리턴값으로 리스트 데이터 구조로 넘어옴
result <- myfunc(5,8)
class(result)
s <- result$sum
m <- result$mul
cat("5+8=",s,"\n")
cat("5*8=",m,"\n")

# 함수들을 여러 개 만들어서 하나의 R파일로 만들고 그 파일에
# 있는 함수들을 사용하기 위해서 source()이용하여 함수를 
# 이용할 수가 있다.
source("mylib.R")
c <- myadd(10,55)
cat("10 + 55 = ", c)

c <- myminus(10,55)
cat("10 - 55 = ", c)

