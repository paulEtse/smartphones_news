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
df <- ddply(dfa, "Année",  summarise, price = mean(`prix au lancement (€)`))
df <- na.omit(df)
#Source : https://fr.statista.com/statistiques/479759/taux-inflation-france/
INFLATION <- c(1.5, 2.1, 2, 0.9, 0.5, 0, 0.2, 1, 1.8, 1.1)

acc = 0;
taux = c(acc)
for (i in seq(2,10,by=1)) {
  acc = acc+INFLATION[i]
  taux = append(taux, acc)
}
df$inflation <- INFLATION
df$taux <- taux
df$real_price <- df$price*(100+df$taux)/100
ggplot(df)+
  geom_col(aes(x=Année, y=real_price), fill= '#66d9ff')+
  ylab("Prix (€)")


