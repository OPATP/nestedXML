\name{read_xml}
\alias{read_xml}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Read a xml and convert to data.frame
}
\description{
Read a nested xml and convert to data.frame. For simple xml use XML package.
}
\usage{
read_xml(file)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{
A character. Path to xml file which will be used by xpathApply. The default is NULL and the highest level node will be determined. 
}

  \item{node}{
A character. Path to xml node.
}
}


\author{
"Guimarães, Gustavo <caiogcg.mobilidade@gmail.com>"
}

\seealso{
XML
}
\examples{

df<-read_xml(my_file.xml)


##  Use with multiple paths
xmls<-list.files(pattern=".xml")

list<-lapply(xmls,read_xml)

df<-data.table::rbindlist(list)

##  Use in parallel
xmls<-list.files(pattern=".xml")

# Create clusters according to the capacity of your machine
cl<-makeCluster( detectCores()/2 )

df<-parLapply(cl,xmls,read_xml) \%>\% 
  rbindlist(fill = T)


}