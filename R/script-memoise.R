gran_funcion <- function(valor){
  
  Sys.sleep(sample(5:10, size = 1))
  
  2 * valor 

}

gran_funcion(120)

gran_funcion(120)


library(memoise)

gran_funcion_memoizada <- memoise(gran_funcion)

gran_funcion_memoizada

gran_funcion_memoizada(120)

gran_funcion_memoizada(120)


gran_funcion_memoizada(2)

gran_funcion_memoizada(2)


gran_funcion(10)

gran_funcion(10)


runif(15)

runif(15)


runif_m <- memoise(runif)

runif_m(15)

runif_m(15)

memoise::cache_filesystem(path = "")



