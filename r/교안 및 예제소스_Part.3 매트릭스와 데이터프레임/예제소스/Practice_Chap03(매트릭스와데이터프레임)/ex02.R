# 데이터프레임 알아보기

city <- c("서울","도쿄","워싱턴")   # 문자형벡터
rank <- c(1,2,3)
a <- c(1,2,3,4,5,6,7,8,9,10)   # 정수형벡터
b <- seq(0.0,1.0,0.1)          # 실수형벡터
# class()라는 함수는 매개변수로 들어간 변수에 담긴 데이터의 셋 
# 자료구조를 알려준다.
class(a)
# str()라는 함수는 데이터의 요약정보를 알려준다.
str(rank)

# city라는 문자형 팩터와 rank라는 정수형 벡터 합쳐서 데이터 프레임
# 형태가 되었다.
cityInfo <- data.frame(city, rank)
cityInfo

# 데이터프레임도 2차원 데이터 타입이니 얼마든지
# 인덱스로 접근가능하고 수정도 가능하다.
cityInfo[1,1]
cityInfo[1,]
class(cityInfo[,2])  
class(cityInfo[1,])

class(iris)
# dim() 몇개의 행과 몇개의 열로 구성되어있는지 확인할때 사용할
# 수 있다.
dim(iris)
dim(cityInfo)
str(iris)

# iris는 R에서 제공해주는 데이터셋
iris[1,1]
iris[,"Species"]
mean(iris[,"Sepal.Length"])



