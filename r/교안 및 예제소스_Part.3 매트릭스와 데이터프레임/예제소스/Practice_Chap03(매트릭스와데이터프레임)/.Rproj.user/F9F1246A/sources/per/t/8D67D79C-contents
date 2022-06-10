# 매트릭스, 데이터프레임 다루기

iris
# 행과 열의 개수를 표식하는 함수
dim(iris)

# 행의 개수 출력
nrow(iris)

# 열의 개수 출력
ncol(iris)

# 열의 이름 출력
colnames(iris)

# 행의 이름 출력
rownames(iris)

# 데이터의 셋의 앞부부 일부 출력
head(iris)
tail(iris)

# 데이터 셋의 요약 정보를 출력
str(iris)

# 데이터셋의 자료구조 출력
class(iris)

iris[,5]
# 품종은 팩터이다.
class(iris[,5])
levels(iris[,5])
# 중복된 값을 제거하고 품종의 종류를 본다.
unique(iris[,5])
# 5열은 팩터이기 때문에 합계, 평균이 나오지 않으므로 
# -5하여 제외하였음.
colSums(iris[-5])
colMeans(iris[-5])

rowSums(iris[,-5])
rowMeans(iris[,-5])

# 빈도수 확인
table(iris[,"Species"])

# 매트릭스 행렬값 서로 바꾸기
z <- matrix(1:20, nrow = 4, ncol = 5)
z
t(z) # t()는 행렬값을 서로 바꾸는 함수다.

# subset()함수는 조건에 맞는 값을 추출한다.
setosa <- subset(x = iris, Species=="setosa")
setosa
class(setosa)

v1 <- subset(x = iris, (Sepal.Length>5.0) & (Sepal.Width>4.0))
v1
class(v1)

# 매트릭스(행렬)에 대한 산술연산
a <- matrix(data = 1:20, nrow = 4, ncol = 5)
b <- matrix(21:40, 4, 5)

a
a*2

a
b
a + b

b - a

class(b)

state.x77

str(state.x77)
dim(state.x77)
class(state.x77)

# 매트릭스를 데이터프레임형태로 변경하고 할 때
st <- as.data.frame(state.x77)
class(st)
st

# 데이터프레임에 접근하는 방법
iris[1,1]
iris$Sepal.Length

st$Area

# 접두사로 is온다면 ~~이냐? 확인하는 용도이구요.리턴값
# 은 논리형 타입이 된다.
is.matrix(st)
is.data.frame(st)