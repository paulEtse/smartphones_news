# importation des librairies
library(readr)
library(plyr)
library(tidyverse)
library(ggplot2)
# chargement du dataset
PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path),"/dataset/smartphones.csv", sep = "")
dfa<- read_csv2(PATH)

dfa$Année <- format(as.POSIXlt(dfa$`date début commercialisation`,tz = "", "%d/%m/%Y"), format="%Y")


# aggrégation par année selon les moyennes
df<-ddply(dfa, "Année", summarize, som=sum(`masse (g)`>=0),masse=mean(`masse (g)`), largeur_carree = sqrt(mean(`largeur (mm)`)*mean(`hauteur (mm)`)), largeur=mean(`largeur (mm)`), hauteur=mean(`hauteur (mm)`), epaisseur=mean(`epaisseur (mm)`), surface=mean(`surface utile (%)`),ratio=mean(`largeur (px)`)/mean(`hauteur (px)`)) 

# constatation du manque de donnée en 2010 et 2011
ggplot(df,aes(x=Année, y=som))+geom_col()+geom_text(aes(label=som), vjust=1.6, color="black", size=3.5)+theme_minimal()

#tests
#ggplot(df,aes(x=Année, y=hauteur, fill=-epaisseur))+geom_col()



y_lim <- c(0,210) #intervalle (masse en g)
x_lim <- c(2012,2020) #intervalle (années)   
plot.new() 
#affichage des contours de telephones
par(new = T)
plot(df$Année, df$masse,col="#22222a",xlab="Années",ylab="masse (g) →",pch=15,cex=df$largeur_carree^2/1000,xlim=x_lim,ylim=y_lim) #largeur_carree mis au carre 
#affichage par dessus des écrans 
par(new = T)
plot(df$Année,df$masse,col="#b0d6ee",xlab="Années",ylab="masse (g) →",pch=15,cex=df$largeur_carree^2*df$surface/100/1000,xlim=x_lim,ylim=y_lim) #/100 pour pourcentage 
#NB: la légende a été rajoutée à posteriori


