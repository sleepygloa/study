# 반복문에 대해서 알아보자
# for문

# for(변수 in 범위)
for(i in 1:5){
  print('*')
}

for(i in 1:10){
  print(i)
}

# cat()문장을 만들어서 출력하고자 할 때 사용하는 함수
# \n은 개행하라 이스케이프문자
for(i in 1:9){
  cat("2 *", i, "=", 2*i, "\n")
}

c <- 20
cat("c의 값은 ", c , "\n")

for(i in 1:20){
  # 짝수인지 확인
  if((i%%2) == 0){  
    cat("1~20까지의 짝수 : " ,i , "\n")
  }
}

# 값을 누적하기
sum <- 0
for(i in 1:100){
  sum <- sum + i
}
cat("1~100누적값 : ", sum)

head(iris)

#num은 150이 저장
num <- nrow(iris)
mylabel <- c()

for(i in 1:num){
  # 꽃잎의 길이에 따라 레이블 결정
  if(iris$Petal.Length[i] <= 1.6){
    mylabel[i] <- 'L'
  }else if(iris$Petal.Length[i] >= 5.1){
    mylabel[i] <- 'H'
  }else{
    mylabel[i] <- 'M'
  }
}
mylabel
# 새로운 데이터프레임을 만들고 있다.
df_new_iris <- data.frame(iris$Petal.Length, mylabel)
class(df_new_iris)
head(df_new_iris)

# while문(통상 무한루프를 돌릴때 많이 사용함)
sum <- 0
i <- 1
while (i<=100) {
  sum <- sum + i  # 값 누적하기
  i <- i + 1
}
print(sum)

# break문(어떠한 조건에 만족을 하면 루프문을 빠져나오는 문)
sum <- 0
for(i in 1:10){
  sum <- sum + i
  if(i>=5)
    break
}
print(sum)

# next문은 자신의 뒷문장은 실행하지 않고 반복문의 블럭 
# 끝으로 이동함
sum <- 0
for(i in 1:10){
  if(i%%2 == 0){
    next
  }
  # 홀수만 더하는 형태
  sum <- sum + i
}
print(sum)