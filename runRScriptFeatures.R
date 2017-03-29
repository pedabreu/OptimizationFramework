sessionInfo()
.libPaths("./Rpackages/")
# install.packages("DBI",repos = "http://cran.es.r-project.org/")
# install.packages("RMySQL",repos = "http://cran.es.r-project.org/")
# install.packages("R.utils",repos = "http://cran.es.r-project.org/") 
install.packages("./RSourcePackages/DBI_0.2-5.tar.gz",repos=NULL)
install.packages("./RSourcePackages/RMySQL_0.9-3.tar.gz",repos=NULL)
install.packages("./RSourcePackages/R.methodsS3_1.4.4.tar.gz",repos=NULL)
install.packages("./RSourcePackages/R.oo_1.13.9.tar.gz",repos=NULL)
install.packages("./RSourcePackages/R.utils_1.26.2.tar.gz",repos=NULL) 
install.packages("./RSourcePackages/moments_0.13.tar.gz",repos=NULL) 

if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())

library("DBI")
library("RMySQL")
library("R.utils")
library("R.oo")
library("moments")
library("reshape")

sourceDirectory("./lib/")

exp <- ExperimentFramework()

exp$hostDB <- "localhost"
exp$userDB <- "root"
exp$passwordDB <- "pedrito"
exp$nameDB <- "jss_dev"


con <- exp$simpleConnectDB()
exp$connectionDB <- con

##exp$generateModels(file="./lib/MySQLInterface/DBModel.R")

exp$runFeaturesCalculation(nr=1,duration=60)

