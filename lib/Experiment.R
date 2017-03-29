# 
# setConstructorS3("Experiment",function()
# {
#   extend(Object(),"Experiment",
#          connections = list(),
#          connectionDB = NULL)
#   
# })
# 
# 
# 
# setMethodS3("disconnectDB","DBConnection", function(this,                                          
#                                                ...) {
#   
#   dbDisconnect(this$connectionDB)  
#   
# })
# 
# 
# setMethodS3("simpleConnectDB","DBConnection", function(this,   
#                                                        connectionName,
#                                                        ...) {
# #     con <- dbConnect(this$connectionDriver,
# #                                         host="127.0.0.1",
# #                                         user="pedabreu",
# #                                         password="abreu",
# #                                         dbname="JSS",
# #                                         port=3307)
#     
#   connection <- 
#   
# 
#     con <- dbConnect(this$connectionDriver,
#                      client.flag=CLIENT_MULTI_STATEMENTS,
#                      host = this$hostDB,##"rank.fep.up.pt",
#                      user= this$userDB,##"pedabreu",
#                      password= this$passwordDB,##"abreu",
#                      dbname=this$nameDB,
#                      port=this$portDB)
#     
#     this$connectionDB <- con
#     return(con)
# 
# })
