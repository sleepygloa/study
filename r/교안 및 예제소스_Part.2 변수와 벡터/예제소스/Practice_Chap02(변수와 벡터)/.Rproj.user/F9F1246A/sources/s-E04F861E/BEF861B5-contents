# 리스트(벡터와 같은 1차원데이터를 나타내는 것은 맞으나
# 리스트는 다른 데이터형을 가질수 있는 것이 바로 리스트다)

ds <- c(10,15,70,85)
myinfo <- list(name = "신은혁", age = 12, status = TRUE, score = ds)
myinfo

# 리스트요소를 접근이나 출력하는 두 가지방법
myinfo[[3]]
myinfo$name  # $이용하는 방법 권장드림.
myinfo$score

# unlist() : 리스트를 벡터로 변경시켜주는 함수
vmyinfo <- unlist(myinfo)
vmyinfo
# as.integer() : 다른데이터형을 숫자형으로 바꿔주는 함수
v1 = as.integer(vmyinfo[2])
v1


# 팩터(factor)
bt <- c("A", "B", "B", "O", "AB", "A")
bt
fbt <- factor(bt)
bt
fbt

bt[5]
fbt[5]
# levels()는 팩터에 저장된 데이터의 종류를 알려준다.
levels(fbt)
as.integer(fbt)
length(fbt)

fbt[7] <- "B"
fbt

# Z라는 값은 fbt라는 팩터의 level에 그 값이 없다.
# 하여, NA생성한다.
fbt[8] <- "Z"
fbt