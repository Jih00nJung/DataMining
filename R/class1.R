1 + 2
23 * 54
setwd("C:/WORK_R")  # 운영환경 설정
getwd()                  # 운영환경 경로 확인

install.packages("prettyR")   # prettyR 패키지 설치

library(prettyR)    # prettyR 패키지 사용



# pacman 패키지가 설치되어 있어야 Gist 코드가 R에서 동작합니다. pacman 설치되어 있지 않다면 바로 아래 주석의 코드를 실행시켜서 pacman 패키지를 설치하세요. (온라인 상태이어야 하며, 주석을 해제하고 직접 실행해야 합니다.)
install.packages("pacman")

# 현 Gist 에 올려진 R코드를 바로 실행하고 싶으시다면 아래 주석의 코드를 실행시키세요. (온라인 상태이어야 하며, 주석을 해제하고 직접 실행해야 합니다.)
source("https://gist.githubusercontent.com/lovetoken/16f862394a7f541faafde067cee0bf77/raw/4c5ec3ff8b1ea8d1eaa9a058a3e227ff8152c2a9/R_packages_install_for_myself")

pacman::p_load(
  aws.s3,
  bigrquery,
  BiocManager,
  bit64,
  bookdown,
  broom,
  bupaR,
  caesar,
  colourpicker,
  data.table,
  DBI,
  devtools,
  DiagrammeR,
  DiagrammeRsvg,
  dplyr,
  DT,
  edeaR,
  eventdataR,
  extrafont,
  feather,
  fst,
  gargle,
  gganimate,
  ggplot2,
  htmlwidgets,
  httpuv,
  jsonlite,
  knitr,
  lubridate,
  magrittr,
  patchwork,
  plotly,
  processanimateR,
  processmapR,
  purrr,
  RCurl,
  readr,
  reshape2,
  RODBC,
  ROSE,
  RPresto,
  rsvg,
  rvest,
  scales,
  sessioninfo,
  sparklyr,
  tidyquant,
  tidyr,
  tidyverse,
  xml2
)

library()   # 설치된 package를 확인하는 구문


# 수치계산 기능 : R의 가장 기본적인 기능으로 산술연산자나 함수를 이용하여 수치계산을 수행하는 것

3 + 4 ^ 2

log(10)

exp(2)

sqrt(10)

1:15

sum(1:15)

rnorm(12)

min(rnorm(12))

sample(20)

help(min)   # min에 대한 문서가 나온다

runif(2, 1, 10)   # 난수 2개를 벡터로 생성

