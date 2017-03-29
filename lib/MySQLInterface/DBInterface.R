library("R.oo")
##rm(list = ls())


setConstructorS3("Column",function(type=NULL,
                                  default=NULL,
                                  primaryKey = FALSE,
                                  autoincrement=FALSE,
                                  mandatory = FALSE,
                                  foreignKey= c("tableName"=NULL,
                                                "columnName"=NULL))
  
{  
  extend(Object(),"Column",
         foreignKey=foreignKey,
         primaryKey = primaryKey,
         autoincrement = autoincrement,
         mandatory = mandatory,
         default = default,
         type= type)  
})

setConstructorS3("DBModel",function(tableName=NULL,
                                    columns = list(),
                                    columnsNames = names(columns),         
                                    primaryKeys = columnsNames[unlist(lapply(columns,function(x){x$primaryKey}))],

                                    foreignKeys = columnsNames[unlist(lapply(columns,function(x){!is.null(x$foreignKey["tableName"])}))],
                                    autoincrement =  columnsNames[unlist(lapply(columns,function(x){x$autoincrement}))] )
{
    
  extend(Object(),"DBModel",
         primaryKeys = primaryKeys,
         columnsNames = columnsNames,
         foreignKeys = foreignKeys,
         autoincrement = autoincrement,
         attributes = list(),
         tableName= tableName,
         columns = columns)  
})


setMethodS3("quoteValues","DBModel", function(this,values,...) {
  
  newvalues <- list()
  
  for(att in names(values))
  {   

    value <- values[[att]]

    if(!is.null(value) && !is.na(value))
    {
    
      field <- this$columns[[att]]
      
      type <- field$type
      # queryInsert[att]<-att     
      valueInsert <- as.character(value)
    #  if(length(type)==0)browser()
      if(type=="varchar" | type=="datetime" | type=="text")
      {
        newvalues[[paste("`",att,"`",sep="")]] <- paste("'",valueInsert,"'",sep="")
        
      }
      else
      {
        newvalues[[paste("`",att,"`",sep="")]] <- valueInsert
        
        
      }
      
    }
    else
    {
      newvalues[[att]] <- NULL
    }
      
  }
  
  return(newvalues)
  
})

setMethodS3("getAllByAttributes","DBModel", function(this,con,limit=NULL,orderby=NULL,debug = FALSE,...) {
  
  resultado <- list()  
  thisClass <- class(this)[1]
  
    
  attrib <- this$quoteValues(this$attributes)

  query <- paste("SELECT * FROM ",this$tableName)
  
  if(length(attrib) >0)
  {  
    query <- paste(query," WHERE ",paste(paste(names(attrib),attrib,sep="="),collapse=" AND "),sep="")
  }

  if(!is.null(orderby))
  {
    query <- paste(query," ORDER BY ",orderby)   
  }
  
  if(!is.null(limit))
  {
    query <- paste(query," LIMIT ",limit)   
  }
  

  
  if(debug){print(query)}
  sol <- dbGetQuery(con,query)

  d <- dim(sol)
  nrRows <- d[1]

  if(nrRows > 0)
  {
  for(i in 1:nrRows)
  {
    dados <- sol[i,]
    eval(parse(text=paste("novoobj<-",thisClass,"()",sep="")))
    novoobj$attributes <- dados
    
    resultado[[i]]<-novoobj
    
  }
  }

  return(resultado)
})


setMethodS3("getRandomFromDB","DBModel", function(this,con,debug=FALSE,...) {
  
  resultado <- NULL  
  
  query <- paste("SELECT * FROM ",this$tableName,sep="")
  
  if(!all(is.null(this$attributes)))
  {
    attrib <- this$quoteValues(this$attributes)
    
    
    query <- paste(query," WHERE ",paste(paste(names(attrib),attrib,sep="="),collapse=" AND "),sep="")
    
  }  
  query <- paste(query," LIMIT 1",sep="")
  
  if(debug)
  {
    print(query)
    browser()
  }
  
  
  sol <- dbGetQuery(con,query)
  dados <- sol[1,]  
  
  this$attributes <- dados  
  
  return(resultado)
})


setMethodS3("getByAttributes","DBModel", function(this,con,debug=FALSE,...) {
  
  resultado <- NULL  

  query <- paste("SELECT * FROM ",this$tableName,sep="")
 
  if(length(this$attributes)>0 & !all(is.null(this$attributes)))
  {
    attrib <- this$quoteValues(this$attributes)
    
    
    query <- paste(query," WHERE ",paste(paste(names(attrib),attrib,sep="="),collapse=" AND "),sep="")
    
  }  
  
  query <- paste(query," LIMIT 1",sep="")
  
  if(debug)
  {
    print(query)
    browser()
  }
  
  
  sol <- dbGetQuery(con,query)
  dados <- sol[1,]  
  
  this$attributes <- dados  

  return(resultado)
})

setMethodS3("deleteByAttributes","DBModel", function(this,con,...) {
  
  resultado <- NULL  
  
  attrib <- this$quoteValues(this$attributes)
  
  query <- paste("DELETE FROM ",this$tableName," WHERE ",paste(paste(names(attrib),attrib,sep="="),collapse=" AND ")," LIMIT 1",sep="")
  dbGetQuery(con,query)

})

setMethodS3("existsByAttributes","DBModel", function(this,con,...) {
  
  resultado <- FALSE  
  
  attrib <- this$quoteValues(this$attributes)
  
  query <- paste("SELECT count(*) AS nr FROM ",this$tableName," WHERE ",paste(paste(names(attrib),attrib,sep="="),collapse=" AND "),sep="")
  
  sol <- dbGetQuery(con,query)
  dados <- sol[1,"nr"]
  
  if(dados > 0)
  {
    resultado <- TRUE
  }
      
  return(resultado)
})


setMethodS3("saveAll","DBModel", function(this,con,debug = FALSE,...) {
  
  allAttrib <- this$attributes
  
  firstAttrib <- allAttrib[[1]]
  
  inserts <- names(firstAttrib)
  
  
  query <- paste("INSERT INTO ",
                 this$tableName,
                 "(`",
                 paste(inserts,collapse="`,`"),                         
                 "`) VALUES ", sep = "")
  
  
  
  values <- NULL
  
  for(attrib in allAttrib)
  {
    
    
    queryValues <- NULL
    queryInsert <- NULL
    
    pkValues <- NULL
    pkInsert <- NULL
    
    quotedAttrib<- this$quoteValues(attrib)
    
    for(att in names(quotedAttrib))
    {
      
      valueInsert <- quotedAttrib[[att]]
      field <- this$columns[[att]]
      
      type <- field$type
      
      if(any(att == this$primaryKeys))
      {
        pkInsert[att]<-att   
        pkValues[att]<-valueInsert  
      }
      else
      {
        queryInsert[att]<-att
        queryValues[att]<-valueInsert  
        
      }
      
    }
    
    
    
    values <- c(values,
                paste("(",
                      paste(c(pkValues,queryValues),collapse=","),                    
                      ")", sep = ""))
    
    
  }
  
  query <- paste(query,
                 paste(values,collapse=","))
  
  
  
  

  

  
  
#   
#   if(length(queryInsert)>0)
#   {
#     query <- paste(query,
#                    " ON DUPLICATE KEY UPDATE ",
#                    paste(paste(queryInsert,queryValues,sep="="),collapse=","), 
#                    sep = "")    
#     
#     
#   }
#   
  #   if(length(pkInsert) == length(this$primaryKeys))
  #   {
  #     query <- paste("UPDATE ",this$tableName," SET ",paste(paste(queryInsert,queryValues,sep="="),collapse=",")," WHERE ",paste(paste(pkInsert,pkValues,sep="="),collapse=" AND "),sep = "")
  #        
  #   }
  #   else
  #   {
  #     query <- paste("INSERT ",this$tableName,"(",paste(queryInsert,collapse=","),") VALUE (",paste(queryValues,collapse=","),")",sep = "")
  #     }
  
  retornar <- TRUE
  if(!debug)
  {
    sol <- dbGetQuery(con,query)
  }
  else{
    print(query)
    browser()
  }
  
  return(retornar)
})



setMethodS3("save","DBModel", function(this,con,debug = FALSE,...) {
    
  
  queryValues <- NULL
  queryInsert <- NULL

  pkValues <- NULL
  pkInsert <- NULL

  quotedAttrib<- this$quoteValues(this$attributes)
  
  for(att in names(quotedAttrib))
  {
    
    valueInsert <- quotedAttrib[[att]]
    field <- this$columns[[att]]
    
    if(!is.null(valueInsert))
    {
      type <- field$type
      
      if(any(att == this$primaryKeys))
      {
        pkInsert[att]<-att   
        pkValues[att]<-valueInsert  
      }
      else
      {
        queryInsert[att]<-att
        queryValues[att]<-valueInsert  
        
      }
    }
  }
  
  query <- paste("INSERT INTO ",
                 this$tableName,
                 "(",
                 paste(c(pkInsert,queryInsert),collapse=","),                         
                 ") VALUES (",
                 paste(c(pkValues,queryValues),collapse=","),                    
                 ")", sep = "")

  
  
  if(length(queryInsert)>0)
  {
    query <- paste(query,
                   " ON DUPLICATE KEY UPDATE ",
                   paste(paste(paste("",queryInsert,"",sep=""),queryValues,sep="="),collapse=","), 
                   sep = "")    
    
    
  }

#   if(length(pkInsert) == length(this$primaryKeys))
#   {
#     query <- paste("UPDATE ",this$tableName," SET ",paste(paste(queryInsert,queryValues,sep="="),collapse=",")," WHERE ",paste(paste(pkInsert,pkValues,sep="="),collapse=" AND "),sep = "")
#        
#   }
#   else
#   {
#     query <- paste("INSERT ",this$tableName,"(",paste(queryInsert,collapse=","),") VALUE (",paste(queryValues,collapse=","),")",sep = "")
#     }
  
  retornar <- TRUE
  if(!debug)
  {
  sol <- dbGetQuery(con,query)
  a <- dbGetQuery(con,"SELECT LAST_INSERT_ID()")


  
  if(a[1,"LAST_INSERT_ID()"]>0)
  {
    idDB <- a[1,"LAST_INSERT_ID()"]   
    retornar <- idDB
  }  
  }
  else{
    print(query)
    browser()
  }
  
  return(retornar)
})





