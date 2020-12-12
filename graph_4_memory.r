library(readr)
library(plyr)
library(tidyverse)
library(ggplot2)

PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path), 
             "/dataset/smartphones.csv", sep = "")
dfa<- read_csv2(PATH)
dfa$Année <- format(as.POSIXlt(dfa$`date début commercialisation`,tz = "", "%d/%m/%Y"), format="%Y")
dfa$extensible <- as.numeric(dfa$ extensible)
df <- ddply(dfa, "Année",  summarise, memoire = mean(`capacité (GB)`), ram = mean(`RAM (GB)`), extensible = mean(extensible))
df <- na.omit(df)
ggplot(df)+
  geom_col(aes(x=Année, y=memoire, fill= 'blue'))+
  geom_col(aes(x=Année, y= ram, fill='red'))+
  scale_fill_manual("", values = c('blue', 'red'), labels=c("storage","ram"))+
  theme(legend.position=c(0.5,0.7))
