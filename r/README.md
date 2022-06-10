# 설치

- URL : https://www.r-project.org/ 
- [https://ftp.harukasan.org/CRAN/](https://ftp.harukasan.org/CRAN/)
- [Download R for Windows](https://ftp.harukasan.org/CRAN/bin/windows/)
- [base](https://ftp.harukasan.org/CRAN/bin/windows/base/)
> Binaries for base distribution. This is what you want to  **[install R for the first time (https://ftp.harukasan.org/CRAN/bin/windows/base/)**.
- [Download R 4.0.3 for Windows](https://ftp.harukasan.org/CRAN/bin/windows/base/R-4.0.3-win.exe)  (85 megabytes, 32/64 bit)
- 32Bit 체크해제, 기본값 사용

- URL : www.rstudio.com
- download --> Free --> Download


### 툴 미리보기


- 편집창 : R 명령문들을 작성하고 실행
- 콘솔창 : 편집창에서 R명령문을 편집하고 실행 시, 결과를 보여주는 창
- 환경창 : R 명령문이 실행되는 동안 만들어지는 각종 변수나 자료구조를 보여주는 창
- 파일창 : 도움말, 패키지 설치 및 조회, 그래프 실행 내용 조회 등 유용한 기능을 제공.

### 단축키
- ctrl + L : 콘솔창 지우기
- ctrl + 1,2 : 스크립트창 이동
- ctrl + shift + N : 새창
- ctrl + shift + C : 주석 처리 / 주석 풀기
- ctrl + enter : 한 줄만 실행
- 드래그 + ctrl + enter : 여러 줄 실행
- ctrl + enter + R : 모든 명령문 실행
- ctrl + enter + P : 바로 직전 실행한 명령을 다시 실행

### 새로운 패키지의 설치
- library(ggplot2)

## 변수와 벡터

- 숫자형 : 정수와 실수 모두가능
- 문자형 : '', "" 
- 논리형 : true -> T, false -> F
- 특수값 :
-- NULL : 자료형 없고, 길이0
-- NA : 결측값(missing value)
-- NaN : 수학적으로 정의가 불가능한 값
-- Inf, -Inf : 양의 무한대, 음의 무한대.

### 벡터의 이해
```

x <- c(1,2,3)                     # 숫자형 벡터
y <- c("a","b","c")               # 문자형 벡터
z <- c(TRUE,T, F, TRUE)           # 논리형 벡터
v1 <- 50:90 # 연속된수 한번에 넣기
v3 <- seq(1,101,3)      # 1번자리 부터 2번자리까지 3씩 + 하여 생성
v6 <- rep(1:5,times=3)         # 1에서 5까지 3번 반복
 

score <- c(90,85,70)                    # 성적
score
names(score)                            # score에 저장된 값들의 이름을 보이시오
names(score) <- c("John","Tom","Jane")  # 값들에 이름을 부여
names(score)                            # score에 저장된 값들의 이름을 보이시오
score                                   # 이름과 함께 값이 출력      
> John  Tom Jane 
  90   85   70 


d <- c(1,4,3,7,8)
d[c(1,3,5)]         # 1, 3, 5번째 값 출력
d[1:3]              # 처음 세 개의 값 출력
d[seq(1,5,2)]       # 홀수 번째 값 출력
d[-2]               # 2번째 값 제외하고 출력
d[-c(3:5)]          # 3~5번째 값은 제외하고 출력

GNP <- c(2090,2450,960) 
GNP
names(GNP) <- c("Korea","Japan","Nepal")
GNP
GNP[1]
GNP["Korea"]
GNP[c("Korea","Nepal")]    


v1 <- c(1,5,7,8,9)
v1
v1[2] <- 3              # v1의 2번째 값을 3으로 변경
v1
v1[c(1,5)] <- c(10,20)  # v1의 1, 5번째 값을 각각 10, 20으로 변경
v1
```

### 벡터에 적용가능한 함수

sum() #벡터에 포함된 값들의 합
mean() #벡터에 포함된 값들의 편균
median() #벡터에 포함된 값들의 중앙값
max(), min() #벡터에 포함된 값들의 최댓값, 최솟값
var() #벡터에 포함된 값들의 분산
sd() #벡터에 포함된 값들의 표준편차
sort() #벡터에 포함된 값들의 정렬(오름차순이 기본)
range() 벡터에 포함된 값들의 범위(최솟값~최댓값)
length() #벡터에 포함된 값들의 개수(길이)

### 도움말
창의 [HELP] 탭에서 검색,
함수 선택후 F1

### 논리연산
< 
<=
>
>=
==
!= : 같지않다.
! : OR
& : AND


### 벡터와 팩터의 차이점

1. 출력시 벡터는 " " 가 붙지만 팩터는 붙지않는다.
2. 팩터는 Levels가 함께 출력되는데 이것은 팩터에 저장된 값의 종류를 알려주는 것이다. 팩터의 목적이 어떤 종류를 나타내는 문자값을 저장하는 것이기 때문에
때문에 종류의 정보를 나타내는 것을 잊지말자.

3. 팩터는 이미 지정된 값의 종류 외에 다른 값이 들어오는 것을 막는다. 하여, 위의 코드에서 C라는 값은 팩터에 없기 때문에 경고 메시지가 뜨고 아울러 출력해보면 NA가 뜬다
4. 리스트와 팩터는 벡터에 비해 사용 빈도가 적긴하지만 중요한 자료구조이니 명확히 알아야 함.

###

### 2021-02-16
#### 벡터의 연산
```
d <- c(1,10,5,3)
```
- 바로 연산 가능
```
2*d  # 각요소에다가 2를 곱해라 
d-5
3*d+4
```
- 벡터간 연산과 저장? 가능
```
x <- c(2,4,6)
y <- c(1,3,5)
x+y  # 대응하는 요소끼리 더하여 출력
x*y
x/y
x%%y
z <- x+y
z
```
- 벡터변수의 함수에서 사용
```
sum(d)  
sum(3*d)
length(d) # 벡터요소의 길이(개수)
mean(d[1:5]) # 벡터요소의 평균
max(d) # 최대값
min(d) # 최소값
# 정렬
sort(d)
sort(x = d,decreasing = TRUE)
sort(d, T)
# 중앙값구하기
v1 <- median(d)
v1

v2 <- sum(d)/length(d)
v2
```
-- 벡터변수의 함수에서 사용 (응용)
```
d <- c(1:9)
d
d >= 5   # 논리값 출력
d[d>=5]  # 실제값을 출력
sum(d[d>5]) # 5초과의 합계를 출력
condi <- (d > 5) & (d < 8)
condi
d[condi]
```

### 리스트
- 리스트(벡터와 같은 1차원데이터를 나타내는 것은 맞으나
- 리스트는 다른 데이터형을 가질수 있는 것이 바로 리스트다)

- 리스트 작성하기
```
ds <- c(10,15,70,85)
myinfo <- list(name = "신은혁", age = 12, status = TRUE, score = ds)
myinfo
```
- 리스트 접근과 출력
```
myinfo[[3]]
myinfo$name  # $이용하는 방법 권장드림.
myinfo$score
```
- unlist() : 리스트를 벡터로 변경
```
vmyinfo <- unlist(myinfo)
vmyinfo
```
- as.integer() 다른데이터형을 숫자형으로 변경
```
v1 = as.integer(vmyinfo[2])
v1
```

- 팩터(factor)
```
bt <- c("A", "B", "B", "O", "AB", "A")
bt
fbt <- factor(bt)
bt
fbt ##Levels : A AB B O #종류를 나타냄. 중복제거

bt[5]
fbt[5]
# levels()는 팩터에 저장된 데이터의 종류를 알려준다.
levels(fbt)
as.integer(fbt) #levels 에 해당하는 자리를 반환
length(fbt)

fbt[7] <- "B"
fbt
```

- 팩터 그외요소
```
# Z라는 값은 fbt라는 팩터의 level에 그 값이 없다.
# 하여, NA생성한다.
fbt[8] <- "Z"
fbt
```
-
### 2021-02-17
#### 매트릭스
- 매트릭스(matrix) : 동일한 데이터형을 가지는 2차원 데이터형태의 자료구조이다.

- 매트릭스 저장방법
```
z <- matrix(1:20, nrow = 4, ncol = 5)
z
```
- byrow 속성(데이터 저장순서, TRUE, FALSE)
```
z <- matrix(1:20, nrow = 4, ncol = 5, byrow = TRUE)
z
```
- 벡터 -> 매트릭스
```
x <- c(1:4)
x
y <- c(5:8)
y

z <- matrix(1:20, nrow = 4, ncol = 5)
z
```

- 2개 이상의 벡터를 이용, 매트릭스생성, cbind() : 열방향 결합, rbind() : 행방향 결합
```
m1 <- cbind(x, y)
m1
m2 <- rbind(x, y)
m2
z
m3 <- rbind(m2, x)
m3

m4 <- cbind(z, x)
m4
```
- 매트릭스 접근
```
z <- matrix(1:20, nrow = 4, ncol = 5)
z
z[2,3] # 2행3열의 값 출력
z[2,3] <- 55
z

z[1,] # 1행만 다 출력
z[,1] # 1열만 다 출력

z[1, 1:3] # 1행중에서 1~3열까지의 값을 출력
z[1, c(1,2,4)]

```

- 매트릭스 행, 열 이름 변경 및 이름을 이용한 접근
```
score <- matrix(c(90,85,96,88,55,77,88,99,100,47,55,33),
                nrow = 4, ncol = 3)
score

rownames(score) <- c("존","홍길동","신은혁","김말자")
colnames(score) <- c("국어","영어","수학")

score[1,1]
score["신은혁", "국어"]
score["김말자",]
score[,"수학"]

score["신은혁", "국어"] = 100
sum(score[,"국어"])
mean(score[,"국어"])
```

### 데이터 프레임
- class() 와  str() : class() 는 변수에 담긴 데이터셋의 자료구조를 알려줌, str() 는 데이터의 요약정보를 알려줌
```
city <- c("서울","도쿄","워싱턴")   # 문자형벡터
rank <- c(1,2,3)
a <- c(1,2,3,4,5,6,7,8,9,10)   # 정수형벡터
b <- seq(0.0,1.0,0.1)          # 실수형벡터침
class(a)
str(rank)
```
- 데이터 프래임 만들기 
```
cityInfo <- data.frame(city, rank)   # 문자형 벡터와 숫자형벡터를 합쳐서 생성
cityInfo
```
- 접근
```
cityInfo[1,1]
cityInfo[1,]
class(cityInfo[,2])  
class(cityInfo[1,])
class(iris)
```

- dim : 몇개의 행과 몇개의 열로 구성되어있는지 확인
```
dim(iris)
dim(cityInfo)
str(iris)
```

- iris :  R에서 제공해주는 데이터셋, 
```
iris[1,1]
iris[,"Species"]
mean(iris[,"Sepal.Length"])
```




