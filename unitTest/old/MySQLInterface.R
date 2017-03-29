library("R.oo")
library("RMySQL")
library("R.utils")

rm(list = ls())

sourceDirectory(paste("./lib/MySQLInterface/",sep=""))

m<-dbDriver("MySQL")

con <- dbConnect(m,host="localhost",user="root",password="pedrito",dbname="JSS")

teste<-DBInstance()
print(teste$save(con))
                        
