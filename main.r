library(readr)
PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path), 
             "/dataset/smartphones.csv", sep = "")
df <- read.csv(PATH, sep = ';')
df$date <- as.POSIXlt(df$`date début commercialisation`,tz = "", "%d/%m/%Y")
