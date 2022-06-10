# 조건문에 살펴보도록 하자.

jobtype <- 'A'

# if문은 ( )값이 참일때 블럭 실행함.
# else구문, else if구문은 반드시 if구문의 } 의 
# 같은 라인에 적어줘야 한다.
if(jobtype == 'B'){
  bonus <- 200
} else {
  bonus <- 100
}
print(bonus)

rm(jobtype)
rm(bonus)

# 점수를 가지고 학점을 주기
score <- 60
# if~ else if~ else구문
# else구문 옆에는 조건식이 오면 안되는 것을 기억하자.
if(score > 90){
  grade <- 'A'  
}else if(score > 80){
  grade <- 'B'  
}else if(score > 70){
  grade <- 'C'  
}else if(score > 60){
  grade <- 'D'  
}else{
  grade <- 'F'
}
print(grade)
rm(grade)

# 조건문 안에 논리연산자(&, |)사용해보기
a <- 10
b <- 20
# &는 둘다 참이면 참을 리턴함
if((a>5) & (b>5)){
  print(a+b)
}
# |는 하나라도 참이면 참을 리턴함
if((a>5) | (b>30)){
  print(a*b)
}

if(a>b){
  c <- a
}else{
  c <- b
}
print(c)

# 첫번째 매개변수(수식)가 참이면 a를 리턴, 거짓이면 b를 리턴
c <- ifelse(a<b, a, b)
print(c)
