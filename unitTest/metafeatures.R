library("R.oo")
library("RMySQL")
library("R.utils")

if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())
sourceDirectory(paste("./lib/Optimization/",sep=""))
sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
sourceDirectory(paste("./DBModels/",sep=""))

s <- system("ssh -fNn -L 3307:rank.fep.up.pt:3306 pedabreu@rank.fep.up.pt &")

m<-dbDriver("MySQL")

##con <- dbConnect(m,host="localhost",user="root",password="pedrito",dbname="JSS")

currentTime <-currentTimeMillis.System()
while(!any("con" == ls()) & currentTimeMillis.System() - currentTime <120000     )
{
  
  currentTime2 <-currentTimeMillis.System()
  while(currentTimeMillis.System() - currentTime2 <20000     )
  {
  }
  
  try(
con <- dbConnect(m,host="127.0.0.1",user="pedabreu",password="abreu",
                 dbname="JSS",port=3307))

  
  
  
  }



inst <- Instance()
inst$random.instance()


opFeat <- OperationFeatures()
opFeat$.instance <- inst
opFeat$.job <- 1
opFeat$.machine <- 1

opFeat$DurationFeatures()
opFeat$PrecedenceFeatures()

opFeat$RankDurationFeatures()
opFeat$.features