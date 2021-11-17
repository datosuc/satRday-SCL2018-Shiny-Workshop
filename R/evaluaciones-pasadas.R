# 1 -----------------------------------------------------------------------
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(jsonlite))  install.packages("jsonlite") 

library(tidyverse)
library(jsonlite)

obtener_indicadores <- function(empresa = "FALABELLA") { 
  
  url <- stringr::str_c("https://www.elmercurio.com/inversiones/json/json.aspx?categoria=", 
                        empresa, "&time=10&indicador=2") 
  
  df <- jsonlite::read_json(url)$Data %>% 
    stringr::str_split(";") %>% 
    dplyr::first() %>%
    I() %>% 
    readr::read_delim(delim = ",", col_names = c("fecha", "precio", "vol")) 
  
  df <- df %>% 
    mutate(
      fecha = lubridate::ymd_hms(fecha),
      anio = lubridate::year(fecha)
      ) 
  
  df 
  
  } 

d <- obtener_indicadores("FALABELLA") 

glimpse(d)

d %>%
  group_by(anio) %>% 
  summarise(mean(precio)) 

ggplot(d) +
  geom_line(aes(fecha, precio)) 
                   
lista_empresas <- c("NUEVAPOLAR", "SMU", "BESALCO", "COPEC", "FALABELLA", 
                    "BSANTANDER",  "CMPC", "CHILE", "SQM-B", "ENELAM", "CENCOSUD",
                    "BCI", "LTM",  "ENELCHILE", "SM-CHILE B", "CCU", "PARAUCO",
                    "ITAUCORP", "AGUAS-A",  "COLBUN", "ENTEL", "ECL", "CONCHATORO",
                    "RIPLEY", "AESGENER",  "ANDINA-B", "SONDA", "CAP", "ILC", 
                    "SALFACORP", "SECURITY", "VAPORES",  "ENELGXCH", "ANTARCHILE",
                    "BANMEDICA", "EMBONOR-B", "FORUS",  "IAM", "MASISA", "ORO BLANCO", 
                    "SK", "SMSAAM")


# 2 -----------------------------------------------------------------------
if(!require(tidyverse))  install.packages("tidyverse") 
if(!require(remotes))    install.packages("remotes")
if(!require(mindicador)) remotes::install_github("pachamaltese/mindicador")

library(tidyverse)
library(mindicador)

d <- mindicador::mindicador_importar_datos("uf", anios = 2015:2020) 

glimpse(d)

d <- d %>% 
  mutate(anio = lubridate::year(fecha)) 

d %>%
  group_by(anio) %>% 
  summarise(mean(valor)) 

ggplot(d) +
  geom_line(aes(fecha, valor)) 


lista_indicadores <- mindicador::mindicador_indicadores$codigo

# 3 -----------------------------------------------------------------------
if(!require(tidyverse))  install.packages("tidyverse") 
if(!require(quantmod))   install.packages("quantmod")
if(!require(TTR))        install.packages("TTR")

library(tidyverse)
library(quantmod)

descargar_symbol <- function(symbol  = "GOOG"){
  # https://rpubs.com/Alexis_Morales98/682486
  
  data_xts <- getSymbols(Symbols = symbol, auto.assign = FALSE)
  
  df <- tibble(fecha = index(data_xts)) %>% 
    bind_cols(as.data.frame(coredata(data_xts))) %>% 
    mutate(
      symbol = symbol, .before = 1,
      anio = lubridate::year(fecha)
      ) 
  
  names(df) <- str_remove(names(df), "\\.")
  names(df) <- str_remove(names(df), symbol)
  names(df) <- str_to_lower(names(df))
  
  df
  
}

d  <- descargar_symbol("GOOG")

glimpse(d)

d %>%
  group_by(anio) %>% 
  summarise(mean(close)) 

ggplot(d) +
  geom_line(aes(fecha, close)) 

list_de_simbolos <- TTR::stockSymbols()$Symbol


# extra -------------------------------------------------------------------





   - Le permita al usuario escoger que empresa estudiar. 
   - La aplicación debe mostrar a travéz de un gráfico la variación del indicador 
   algún dato asociado a la empresa respecto al tiempo. 
   - Además le debe permitir al usuario la posibilidad de escoger las fechas a visualizar. 
   - Mostrar una tabla con los datos utlizados para el gráficos. 
   - Utilizar algún paquete para cambiar el look de la aplicación. 
   - Finalmente utilice el servicio gratuiro de shinyapps.io para publicar la aplicación. 

   Importante/hints: 
   No se pide ningún paquete en particular, pero el ir utilizando más paquetes _pomposos_ 
   otorgará puntos los que pueden ayudar a compensar puntos no terminados. Recuerde que existe `dateInput` y `dateRangeInput`. 

   Enviar a más tardar el domingo 29 de noviembre el script y el link de la aplicación 
   al correo **jbkunst@gmail.com** con el asunto **Evaluación shiny Sección Reforzamiento** Indicando en el cuerpo del mail 
   los integrantes (a lo más 2). 

   .code50[ 
                   empresas <- c("NUEVAPOLAR", "SMU", "BESALCO", "COPEC", "FALABELLA", "BSANTANDER",  "CMPC", "CHILE", "SQM-B", "ENELAM", "CENCOSUD", "BCI", "LTM",  "ENELCHILE", "SM-CHILE B", "CCU", "PARAUCO", "ITAUCORP", "AGUAS-A",  "COLBUN", "ENTEL", "ECL", "CONCHATORO", "RIPLEY", "AESGENER",  "ANDINA-B", "SONDA", "CAP", "ILC", "SALFACORP", "SECURITY", "VAPORES",  "ENELGXCH", "ANTARCHILE", "BANMEDICA", "EMBONOR-B", "FORUS",  "IAM", "MASISA", "ORO BLANCO", "SK", "SMSAAM")` 
                   ] 


   - Le permita al usuario escoger que indicador a estudiar. 
   - La aplicación debe mostrar a travéz de un gráfico la variación del indicador 
   respecto al tiempo. 
   - Además le debe permitir al usuario la posibilidad de escoger las fechas a visualizar. 
   - Mostrar una tabla con los datos utlizados para el gráficos. 
   - Utilizar algún paquete para cambiar el look de la aplicación. 
   - Finalmente utilice el servicio gratuiro de shinyapps.io para publicar la aplicación. 

   Importante/hints: 
   - No se pide ningún paquete en particular, pero el ir utilizando más paquetes _pomposos_ 
   otorgará puntos los que pueden ayudar a compensar puntos no terminados. 
   - Puede revisar la lista de indicadores con `mindicador::mindicador_indicadores$codigo`. 
   - recuerde que existe `dateInput` y `dateRangeInput`. 

   Enviar a más tardar el domingo 15 de noviembre el script y el link de la aplicación 
   al correo **jbkunst@gmail.com** con el asunto **Evaluación shiny Sección B** Indicando en el cuerpo del mail 
   los integrantes (a lo más 2). 
   