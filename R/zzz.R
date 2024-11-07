
.onLoad <- function(libname,pkgname){
  invisible(
    suppressMessages(
      suppressWarnings(
        
        lapply(
          c('tidyverse','xml2','data.table'),
          function(x){
            invisible(
              suppressPackageStartupMessages(
                requireNamespace(x,quietly = TRUE,character.only = TRUE)
              )
            )
          })
        
      )
    )
  )
  
  
}



