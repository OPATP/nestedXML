nestedXML
================

nestedXML is a package for read and convert nested XML files to friendly
formats. It was created to make it easier to read large ticketing files
from public transport systems into R data.frames.

## Instalação

You can install the development version from GitHub with

``` r
remotes::install_github("gustavo234guimaraes/nestedXML")
```

## Motivating examples

### Data

Example data can be found at:
[**`Fortaleza dados  abertos`**](https://dados.fortaleza.ce.gov.br/dataset/bilhetagem_01_2014).

### Read data example

You can read a XML into R in data.frame using `read_xml`.

``` r
library(nestedXML)

xml_files<-list.files(
  pattern = "\\.xml",
  recursive = TRUE,
  full.names = TRUE
)
xml_files
```

    ## [1] "./V20140101.xml" "./V20140102.xml" "./V20140113.xml"

``` r
df<-read_xml(xml_files[1])

as_tibble(df)
```

    ## # A tibble: 109,703 × 30
    ##    data_arq   MovimentoDiario.data_mov Categoria.Tipo Empresa.Codigo
    ##    <chr>      <chr>                    <chr>          <chr>         
    ##  1 2021-12-26 2021-12-22               1              021           
    ##  2 2021-12-26 2021-12-22               1              021           
    ##  3 2021-12-26 2021-12-22               1              021           
    ##  4 2021-12-26 2021-12-22               1              021           
    ##  5 2021-12-26 2021-12-22               1              021           
    ##  6 2021-12-26 2021-12-22               1              021           
    ##  7 2021-12-26 2021-12-22               1              021           
    ##  8 2021-12-26 2021-12-22               1              021           
    ##  9 2021-12-26 2021-12-22               1              021           
    ## 10 2021-12-26 2021-12-22               1              021           
    ## # ℹ 109,693 more rows
    ## # ℹ 26 more variables: Empresa.modalidade <chr>, Veiculo.Numero <chr>,
    ## #   Veiculo.validador <chr>, Linha.Numero <chr>, Linha.jornada <chr>,
    ## #   Linha.num_operador <chr>, Linha.tabela <chr>, Linha.hora_abertura <chr>,
    ## #   Linha.hora_fechamento <chr>, Viagem.data_hora_abertura <chr>,
    ## #   Viagem.data_hora_fechamento <chr>, Viagem.catraca_inicio <chr>,
    ## #   Viagem.catraca_final <chr>, Viagem.sentido <chr>, …

### Convert data example

You can convert a XML to a friendly format like .csv or .rds using
convert_xml.

``` r
library(nestedXML)

xml_files<-list.files(
  pattern = "\\.xml",
  recursive = TRUE,
  full.names = TRUE
)
get_info(xml_files)
```

    ## # A tibble: 3 × 2
    ##   path            size     
    ##   <chr>           <chr>    
    ## 1 ./V20140101.xml 25.606 KB
    ## 2 ./V20140102.xml 80.102 KB
    ## 3 ./V20140113.xml 66.485 KB

``` r
ini<-Sys.time()
lapply(xml_files, convert_xml)
```

    ## [[1]]
    ## [1] TRUE
    ## 
    ## [[2]]
    ## [1] TRUE
    ## 
    ## [[3]]
    ## [1] TRUE

``` r
Sys.time()-ini
```

    ## Time difference of 3.524898 mins

``` r
get_info(list.files(pattern = ".csv",recursive = T))
```

    ## # A tibble: 3 × 2
    ##   path          size     
    ##   <chr>         <chr>    
    ## 1 V20140101.csv 23.021 KB
    ## 2 V20140102.csv 76.508 KB
    ## 3 V20140113.csv 62.694 KB

You can use parallel to convert data quickly, use .rds to generate
lightweight files.

``` r
library(nestedXML)
library(parallel)

xml_files<-list.files(
  pattern = "\\.xml",
  recursive = TRUE,
  full.names = TRUE
)
xml_files
```

    ## [1] "./V20140101.xml" "./V20140102.xml" "./V20140113.xml"

``` r
cl<-makeCluster(detectCores(logical = F))
```

``` r
ini<-Sys.time()
parLapply(cl=cl,xml_files, convert_xml, ext=".rds")
```

    ## [[1]]
    ## [1] TRUE
    ## 
    ## [[2]]
    ## [1] TRUE
    ## 
    ## [[3]]
    ## [1] TRUE

``` r
Sys.time()-ini
```

    ## Time difference of 1.850102 mins

``` r
get_info(list.files(pattern = ".rds",recursive = T))
```

    ## # A tibble: 3 × 2
    ##   path          size    
    ##   <chr>         <chr>   
    ## 1 V20140101.rds 1.550 KB
    ## 2 V20140102.rds 4.780 KB
    ## 3 V20140113.rds 4.011 KB
