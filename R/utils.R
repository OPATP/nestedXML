with_names<-function(y,nm){
  colnames(y)<-paste0(nm[1],".",colnames(y))
  return(y)
}


get_children<-function (x) {
  if (length(xml2::xml_children(x)) > 0) {
    cbind.data.frame(with_names(data.frame(as.list(xml2::xml_attrs(x)), 
                                                       stringsAsFactors = FALSE), nm = xml2::xml_name(x)), bind_rows(lapply(xml2::xml_children(x), 
                                                                                                                      get_children)))
  }else {
    as.list(xml2::xml_attrs(x))
  }
}

write_out<-function(x,ext,file,path){
  ext<-tolower(ext)
  if(path!=""){
    file<-basename(file)
    path<-paste0(normalizePath(path),"\\")
  }
  of<-paste0(path,gsub(".xml",ext,file))
  if(ext%in%c(".csv",".txt")){
    data.table::fwrite(x,of)
  }else{
    if(ext==".rds"){
      saveRDS(x,of)
    }else{
      stop("Wrong output format. Choose between .csv, .txt or .rds")
    }
  }
  
}
