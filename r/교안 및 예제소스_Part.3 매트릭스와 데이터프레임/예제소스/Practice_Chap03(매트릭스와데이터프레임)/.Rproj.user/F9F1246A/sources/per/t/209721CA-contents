# 외부데이터를 불러오는 법을 습득

# 1.csv라는 확장자를 지닌 파일을 읽어와서 데이터프레임에 저장
# csv(comma seperated values)확장자는 범용적으로 많이 사용
# setwd("D:\Source") 작업폴더 지정하는 방법

df_exam <- read.csv("csv_exam.csv", header = TRUE)
df_exam

# View() 데이터를 좀 더 가독성을 좋게 만들어주는 함수.
View(df_exam)

# rm()함수는 변수값을 삭제할 때 사용하면 된다.
rm(df_exam)
rm(a)

# 내장데이터셋인 iris의 일부데이터만 추출하여 외부데이터로 
# 내보내는 과정이다.
setwd("D:/R작업/Practice_Chap03(매트릭스와데이터프레임)")
setosa <- subset(x = iris, Species=="setosa")
setosa
class(setosa)
write.csv(x = setosa, "setosa.csv", row.names = FALSE)

# 아래와 같이 excel파일을 R로 가져오기 위해서는 readxl패키지를
# 인스톨을 하고, library함수를 통해서 readxl을 쓰겠다라고 
# 로딩하는 방법이다.
install.packages("readxl")
library(readxl)

df_excel <- read_excel("excel_exam.xlsx", col_names = T)
View(df_excel)
head(df_excel)
class(df_excel)

mean(df_excel$math)
mean(df_excel$science)

# R에서 조작한 데이터를 외부 엑셀파일로 내보기를 하기 위해서
# xlsx패키지를 설치하고 로딩을 해야한다.
install.packages("xlsx")
library(xlsx)
write.xlsx(x = setosa, "setosa.xlsx", row.names = FALSE)