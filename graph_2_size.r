library(readr)
library(plyr)
library(tidyverse)
library(ggplot2)

PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path), 
             "/dataset/smartphones.csv", sep = "")
dfa<- read_csv2(PATH)

dfa$Année <- format(as.POSIXlt(df$`date début commercialisation`,tz = "", "%d/%m/%Y"), format="%Y")



df<-ddply(dfa, "Année", summarize, som=sum(`masse (g)`>=0),masse=mean(`masse (g)`), largeur_carree = sqrt(mean(`largeur (mm)`)*mean(`hauteur (mm)`)), largeur=mean(`largeur (mm)`), hauteur=mean(`hauteur (mm)`), epaisseur=mean(`epaisseur (mm)`), surface=mean(`surface utile (%)`),ratio=mean(`largeur (px)`)/mean(`hauteur (px)`)) 
ggplot(df,aes(x=Année, y=som))+geom_col()+geom_text(aes(label=som), vjust=1.6, color="black", size=3.5)+theme_minimal()
ggplot(df,aes(x=Année, y=hauteur, fill=-epaisseur))+geom_col()
ggplot(df,aes(x=Année, y=surface))+geom_col()
ggplot(df,aes(x=Année, y=ratio))+geom_col()


y_lim <- c(0,210)
x_lim <- c(2010,2020.2)
plot.new() 
#plot(df$Année, df$masse,col="#22222a",xlab="Années",ylab="← Poids (mg)",pch=15,cex=df$largeur_carree^2/1000,xlim=x_lim,ylim=y_lim)
#grid(nx = 0, ny = 100, col = "#b0d6ee", lty = "solid",lwd = par("lwd"), equilogs = TRUE)
par(new = T)
plot(df$Année, df$masse,col="#22222a",xlab="Années",ylab="masse (mg) →",pch=15,cex=df$largeur_carree^2/1000,xlim=x_lim,ylim=y_lim)
par(new = T)
plot(df$Année,df$masse,col="#b0d6ee",xlab="Années",ylab="masse (mg) →",pch=15,cex=df$largeur_carree^2*df$surface/100/1000,xlim=x_lim,ylim=y_lim) #/20=*5/100



