
.libPaths("./Rpackages/")
# install.packages("DBI",repos = "http://cran.es.r-project.org/")
# install.packages("RMySQL",repos = "http://cran.es.r-project.org/")
# install.packages("R.utils",repos = "http://cran.es.r-project.org/") 
install.packages("./RSourcePackages/DBI_0.2-5.tar.gz",repos=NULL)
install.packages("./RSourcePackages/RMySQL_0.9-3.tar.gz",repos=NULL)
install.packages("./RSourcePackages/R.methodsS3_1.4.4.tar.gz",repos=NULL)
install.packages("./RSourcePackages/R.oo_1.13.9.tar.gz",repos=NULL)
install.packages("./RSourcePackages/R.utils_1.26.2.tar.gz",repos=NULL) 
install.packages("./RSourcePackages/combinat_0.0-8.tar.gz",repos=NULL) 
install.packages("./RSourcePackages/XML_3.98-1.1.tar.gz",repos=NULL) 


if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())


library("DBI")
library("RMySQL")
library("R.utils")
library("R.oo")
library("combinat")
library("XML")

sourceDirectory("./lib/")

exp <- ExperimentFramework()

exp$hostDB <- "dbmlexp.fe.up.pt"## "localhost" ##"rank.inescporto.pt"
exp$userDB <- "grid" ##"pedabreu"
exp$passwordDB <- "mysqlGridUser170781" ##"mysqlrank0gCVcV30"
exp$nameDB <- "jss_dev"

con <- exp$simpleConnectDB()
exp$connectionDB <- con

exp$lockOptimizationExperiments(1000)
exp$runOptimizationExperiments()
