# which함수 이해하기

# 학생들 성적을 벡터로 만듬.
score <- c(76,84,69,50,95,60,82,71,88,84) 

# 69점을 획득한 학생의 인덱스를 얻기위해서 반복문 사용
for(i in 1:length(score)){
  if(score[i] == 69){
    idx <- i
    break
  }
  print(score[i])
}

# which()함수는 조건에 맞는 인덱스를 리턴함.
idx <- which(score == 69)  # 69점의 인덱스를 리턴
idx
# which()함수는 조건에 맞는 인덱스를 하나 혹은 여러 개를 리턴함.
idx <- which(score>=85)
class(idx)
idx

max(score) # max()는 벡터의 데이터 중에 최고값을 리턴
which.max(score) # which.max() 최고값이 있는 인덱스를 리턴
min(score)
which.min(score)

idx <- which(score<=60)
idx
# 아래와 같은 방법으로 해도 무방하나 코드를 절약하기
# score[idx] <- 61이렇게 하는 방법을 권장함.
score[idx] <- 61
score[c(4,6)] <- 1000
score

idx <- which(score>=80)
idx
# 80점 이상인 학생을 추출하여 또 다른 벡터를 만듬.
highscore <- score[idx]
highscore

idx <- which(iris$Petal.Length>5.0)
length(idx)
# 꽃잎의 길이가 5.0초과 데이터를 추출함.
irisbig <- iris[idx,]
irisbig

# 1~4열에서의 값들 중에서 5.0초과된 값의 행과 열의 위치를 
# 알고자 할 때, 아래와 같이 작성하면 된다.
idx <- which(iris[,1:4]>5.0, arr.ind = TRUE)
idx
dim(idx)