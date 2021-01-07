library(readr)
library(plyr)
library(tidyverse)
library(ggplot2)
theme_set(
  theme_classic() 
)

PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path), 
             "/dataset/smartphones.csv", sep = "")
dfa<- read_csv2(PATH)
dfa$Année <- format(as.POSIXlt(dfa$`date début commercialisation`,tz = "", "%d/%m/%Y"), format="%Y")
dfa$`2G` <- (dfa$`2G (CN)` + dfa$`2G (FR)` + dfa$`2G (US)`+ dfa$`2G (JP)`)/4
dfa$`3G` <- (dfa$`3G (CN)` + dfa$`3G (FR)` + dfa$`3G (US)`+ dfa$`3G (JP)`)/4
dfa$`4G` <- (dfa$`4G (CN)` + dfa$`4G (FR)` + dfa$`4G (US)`+ dfa$`4G (JP)`)/4
dfa$`5G` <- (dfa$`5G (CN)` + dfa$`5G (FR)` + dfa$`5G (US)`+ dfa$`5G (JP)`)/4
df <- ddply(dfa, "Année",  summarise, `2G` = mean(`2G`), `3G` = mean(`3G`), `4G`=mean(`4G`), `5G`=mean(`5G`))
df <- na.omit(df)
s = 1
g <- NaN
g <- ggplot(df, aes(x=Année, group= 1))
g <- g + geom_area(aes(y= `2G`, col="red"), fill= '#99ff99', size = s, alpha=0.5)
g <- g + geom_area(aes(y= `3G`, col="green"), fill= '#ff4000', size = s, alpha=0.5)
g <- g + geom_area(aes(y= `4G`, col="yellow"), fill= '#cc3300', size = s, alpha=0.5)
g <- g + geom_area(aes(y= `5G`, col="black"), fill='#4d1300', size = s, alpha=0.5)
g <- g + labs(y= "Courverture") 
g <- g + scale_color_manual("", 
                      values = c("green", "yellow","black", "red"),
                      labels = c("5G", "3G", "2G", "4G"))+
  theme(legend.position=c(0.7,0.3))
g 


