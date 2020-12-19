library(readr)
library(plyr)
library(tidyverse)
library(ggplot2)
library(reshape2)
theme_set(
  theme_classic() 
)
PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path), 
             "/dataset/smartphones.csv", sep = "")
dfa =  read_csv2(PATH)
dfa$Année <- format(as.POSIXlt(dfa$`date début commercialisation`,tz = "", "%d/%m/%Y"), format="%Y")
dfa$extensible <- as.numeric(dfa$extensible) * 64
df <- ddply(dfa, "Année",  summarise, memoire = mean(`capacité (GB)`), extensible = mean(extensible))
df <- na.omit(df)
df1 = melt(df)
# ggplot(df)+
#   geom_col(aes(x=Année, y=memoire, fill= 'blue'),position='dodge' )+
#   geom_col(aes(x=Année, y= ram, fill='red'))+
#   scale_fill_manual("", values = c('blue', 'red'), labels=c("storage","ram"))+
#   
df1$variable = factor(df1$variable, levels = c('extensible', 'memoire'), ordered = true)
g <- NaN
g <- ggplot(df1, aes(x=Année, y=value, fill=factor(variable, levels = c('extensible', 'memoire'))))
g <- g + geom_bar(stat="identity", position = "stack")
g <- g + scale_fill_manual("Storage", 
                              values = c("gray", "#0088cc"),
                              labels = c("extensibillty", "memoire"))
g <- g + theme(legend.position=c(0.5,0.7))
g <- g + ylab("Capacity (GB)")
g

