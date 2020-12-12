library(readr)
PATH = paste(dirname(rstudioapi::getSourceEditorContext()$path), 
             "/dataset/smartphones.csv", sep = "")
df <- read_csv2(PATH)

df$date <- as.POSIXlt(df$`date début commercialisation`,tz = "", "%d/%m/%Y")



