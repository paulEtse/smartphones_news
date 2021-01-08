# importation des librairies
library(readr)
library(plyr)
library(tidyverse)
library(ggplot2)
library(viridis) 
library(fmsb)
library(colormap)
# chargement du dataset
PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path), 
             "/dataset/smartphones.csv", sep = "")
dfa<- read_csv2(PATH)

# formatage des types
dfa$Année <- format(as.POSIXlt(dfa$`date début commercialisation`,tz = "", "%d/%m/%Y"), format="%Y")
dfa$fingerprint <- as.numeric(dfa$fingerprint)
dfa$proximité <- as.numeric(dfa$proximité)
dfa$accéléromètre <- as.numeric(dfa$accéléromètre)
dfa$`lumière d'ambiance` <- as.numeric(dfa$`lumière d'ambiance`)
dfa$Boussole <- as.numeric(dfa$Boussole)
dfa$gyroscope <- as.numeric(dfa$gyroscope)
dfa$baromètre <- as.numeric(dfa$baromètre)
dfa$NFC <- as.numeric(dfa$NFC)
dfa$jack <- as.numeric(dfa$jack)
dfa$`radio FM` <- as.numeric(dfa$`radio FM`)
dfa$`computer sync` <- as.numeric(dfa$`computer sync`)
dfa$tethering <- as.numeric(dfa$tethering)
dfa$VoLTE <- as.numeric(dfa$VoLTE)
dfa$OTA <- as.numeric(dfa$OTA)

# dans ce jeu de données lorsqu'un composant est noté NAN c'est qu'il n'est pas trouvé, autrement dit, il est pas disponible -> 0
dfa$gyroscope[is.na(dfa$gyroscope)] <- 0
dfa$baromètre[is.na(dfa$baromètre)] <- 0
dfa$accéléromètre[is.na(dfa$accéléromètre)] <- 0
dfa$`lumière d'ambiance`[is.na(dfa$`lumière d'ambiance`)] <- 0
dfa$Boussole[is.na(dfa$Boussole)] <- 0
dfa$proximité[is.na(dfa$proximité)] <- 0
dfa$`computer sync`[is.na(dfa$`computer sync`)] <- 0
dfa$`OTA`[is.na(dfa$`OTA`)] <- 0


# aggrégation par année selon les moyennes
df<-ddply(dfa, "Année", summarize, fingerprint=mean(`fingerprint`),lumière=mean(`lumière d'ambiance`),proximité=mean(`proximité`),accéléromètre=mean(`accéléromètre`),boussole=mean(`Boussole`),gyroscope=mean(`gyroscope`),baromètre=mean(`baromètre`),NFC=mean(`NFC`),radio=mean(`radio FM`),OTA=mean(`OTA`),sync=mean(`computer sync`))#,bluetooth=mean(`bluetooth`)) 


data <-rbind(rep(1,11) , rep(0,11) , df)  %>% select(-Année) # on mets les lignes de max (ligne 1 <- ligne de 1) et de min (ligne 2 <- ligne de 0)
data <- data[-3,] # on enleve la ligne 3 -> 2010 année trop peu renseignée 

# définition des couleurs
colors_border=colormap(colormap=colormaps$viridis, nshades=10, alpha=1)
colors_in=colormap(colormap=colormaps$viridis, nshades=10, alpha=0.3)

# partage des zones de graphiques
par(mar=rep(0.8,4))
par(mfrow=c(2,5))     #en 2*5 -> 10 parties


# boucle pour chaque affichage
for(i in 1:10){

  radarchart( data[c(1,2,i+2),], axistype=1, 

              pcol=colors_border[i] , pfcol=colors_in[i] , plwd=4, plty=1 , 
              cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,1,5), cglwd=0.8,
              
              #label personalisé
              vlcex=1.05,
              
              #titre
              title=df[-1,]$Année[i]
  )
}



