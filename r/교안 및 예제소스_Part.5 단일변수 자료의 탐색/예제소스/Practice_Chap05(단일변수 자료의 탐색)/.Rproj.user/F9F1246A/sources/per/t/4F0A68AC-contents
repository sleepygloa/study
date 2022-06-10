# 히스토그램 -> 연속형 데이터를 구간별로 나타내주는 그래프

class(cars)
# 자동차의 제동거리만 dist라는 변수에 담고 있다.
dist <- cars[,2]
hist(
  x = dist,
  breaks = 5,          # 구간의 개수(막대의 개수와 동일)
  col = "green",       # 막대의 색깔
  border = "blue",     # 막대의 테두리 색깔
  xlab = "제동거리",   # x축의 레이블
  ylim = c(0, 20), 
  ylab = "빈도 수",    # y축의 레이블
  las = 1,             # x축의 글씨 방향(0~3), 2는 세로, 1은 가로 
  main = "제동거리"    # 제목
)

# 내장 데이터셋 quakes
dim(quakes)

# 지진의 강도를 추출
mag <- quakes$mag
mag
summary(mag)

hist(
  x = mag,
  breaks = seq(4.0, 6.5, by = 0.5),
  col = rainbow(5),
  border = "black",
  xlab = "지진 강도",
  ylab = "발생 건수",
  main = "지진 발생 강도의 분포"
)
