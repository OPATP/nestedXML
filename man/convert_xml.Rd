\name{convert_xml}
\alias{convert_xml}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert xml to a friendly format
}
\description{
This function convert a xml to a list of friendly formats has .csv, .txt or .rds
}
\usage{
convert_xml(file)
}


\arguments{
  \item{file}{
A character. Path to xml file.
}
  \item{ext}{
A character. Extension to save results preceded by a dot, like .rds. The default is '.csv'.
}
  \item{out_dir}{
A character. A path for alternative directory to save outputs.
}

}

\author{
"Guimarães, Gustavo <caiogcg.mobilidade@gmail.com>"
}

\seealso{
XML
}
\examples{

convert_xml('my_file.xml')

# Change out format or output path

convert_xml('my_file.xml',ext='.rds',
out_dir='outputs/RDS/')

# Use in parallel

xmls<-list.files(pattern=".xml")

# Create clusters according to the capacity of your machine
cl<-makeCluster( detectCores()/2 )

parLapply(cl,xmls,conver_xml,out_dir='outputs/RDS')

}
