convert_xml<-function(file,ext='.csv',out_dir=""){
  
  arqXML<-xml2::read_xml(file)
  node<-xml2::xml_name(xml2::xml_child(arqXML))
  
  nodes<-xml2::xml_find_all(arqXML, paste0("//", node))
  lapply(nodes, function(x){
    parent <- data.frame(as.list(xml2::xml_attrs(x)), stringsAsFactors = FALSE)
    kids <- bind_rows(lapply(xml2::xml_children(x), get_children))
    cbind.data.frame(parent, kids, stringsAsFactors = FALSE)
  }) %>% unlist(recursive = F) %>%
    suppressMessages() %>% 
    write_out(ext=ext,file=file,path=out_dir)
  
  return(TRUE)
  
}
