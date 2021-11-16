<!-- --- -->
  
  <!-- class: center, middle, inverse -->
  
  <!-- # Evaluación -->
  
  <!-- --- -->
  
  <!-- # Evaluación -->
  
  <!-- Con el siguiente script: -->
  
  <!-- .code70[ -->
                  <!-- ```{r, eval=FALSE} -->
                  <!-- if(!require(tidyverse)) install.packages("tidyverse") -->
                  <!-- if(!require(jsonlite))  install.packages("jsonlite") -->
                  
                  <!-- obtener_indicadores <- function(empresa = "FALABELLA") { -->
                      
                      <!--   url <- stringr::str_c( -->
                                                      <!--     "https://www.elmercurio.com/inversiones/json/json.aspx?categoria=", -->
                                                      <!--     empresa, "&time=10&indicador=2") -->
                        
                        <!--   df <- jsonlite::read_json(url)$Data %>% -->
                          <!--     stringr::str_split(";") %>% -->
                          <!--     dplyr::first() %>% -->
                          <!--     readr::read_delim(delim = ",", col_names = c("fecha", "precio", "vol")) -->
                          
                          <!--   df <- df %>% -->
                            <!--     mutate(fecha = lubridate::ymd_hms(fecha), anio = lubridate::year(fecha)) -->
                            
                            <!--   df -->
                            
                            <!-- } -->
                  
                  <!-- d <- obtener_indicadores("FALABELLA") -->
                  
                  <!-- d %>% -->
                  <!--   group_by(anio) %>% -->
                  <!--   summarise(mean(precio)) -->
                  
                  <!-- ggplot(d) + geom_line(aes(fecha, precio)) -->
                  <!-- ``` -->
                  <!-- ] -->
  
  <!-- .code70[ -->
                  <!-- ```{r, eval=FALSE} -->
                  <!-- if(!require(tidyverse)) install.packages("tidyverse") -->
                  <!-- if(!require(mindicador)) install.packages("mindicador") -->
                  <!-- if(!require(highcharter)) install.packages("highcharter") -->
                  <!-- if(!require(DT)) install.packages("DT") -->
                  
                  <!-- library(tidyverse); library(lubridate); library(ggplot2) -->
                  
                  <!-- d <- mindicador::mindicador_importar_datos("uf", anios = 2015:2020) -->
                  
                  <!-- hchart(d, "line", hcaes(fecha, valor)) -->
                  
                  <!-- ggplot(d) + -->
                  <!--   geom_line(aes(fecha, valor)) -->
                  
                  <!-- dres <- d %>% -->
                  <!--   group_by(year(fecha)) %>% -->
                  <!--   summarise(valor_mean = mean(valor)) -->
                  
                  <!-- d -->
                  
                  <!-- DT::datatable(d) -->
                  <!-- ``` -->
                  <!-- ] -->
  
  <!-- --- -->
  
  <!-- # Cree una shinyapp que: -->
  
  <!-- - Le permita al usuario escoger que empresa estudiar. -->
  <!-- - La aplicación debe mostrar a travéz de un gráfico la variación del indicador -->
  <!-- algún dato asociado a la empresa respecto al tiempo. -->
  <!-- - Además le debe permitir al usuario la posibilidad de escoger las fechas a visualizar. -->
  <!-- - Mostrar una tabla con los datos utlizados para el gráficos. -->
  <!-- - Utilizar algún paquete para cambiar el look de la aplicación. -->
  <!-- - Finalmente utilice el servicio gratuiro de shinyapps.io para publicar la aplicación. -->
  
  <!-- Importante/hints: -->
  <!-- No se pide ningún paquete en particular, pero el ir utilizando más paquetes _pomposos_ -->
  <!-- otorgará puntos los que pueden ayudar a compensar puntos no terminados. Recuerde que existe `dateInput` y `dateRangeInput`. -->
  
  <!-- Enviar a más tardar el domingo 29 de noviembre el script y el link de la aplicación -->
  <!-- al correo **jbkunst@gmail.com** con el asunto **Evaluación shiny Sección Reforzamiento** Indicando en el cuerpo del mail -->
  <!-- los integrantes (a lo más 2). -->
  
  <!-- .code50[ -->
                  <!-- empresas <- c("NUEVAPOLAR", "SMU", "BESALCO", "COPEC", "FALABELLA", "BSANTANDER",  "CMPC", "CHILE", "SQM-B", "ENELAM", "CENCOSUD", "BCI", "LTM",  "ENELCHILE", "SM-CHILE B", "CCU", "PARAUCO", "ITAUCORP", "AGUAS-A",  "COLBUN", "ENTEL", "ECL", "CONCHATORO", "RIPLEY", "AESGENER",  "ANDINA-B", "SONDA", "CAP", "ILC", "SALFACORP", "SECURITY", "VAPORES",  "ENELGXCH", "ANTARCHILE", "BANMEDICA", "EMBONOR-B", "FORUS",  "IAM", "MASISA", "ORO BLANCO", "SK", "SMSAAM")` -->
                  <!-- ] -->
  
  
  <!-- - Le permita al usuario escoger que indicador a estudiar. -->
  <!-- - La aplicación debe mostrar a travéz de un gráfico la variación del indicador -->
  <!-- respecto al tiempo. -->
  <!-- - Además le debe permitir al usuario la posibilidad de escoger las fechas a visualizar. -->
  <!-- - Mostrar una tabla con los datos utlizados para el gráficos. -->
  <!-- - Utilizar algún paquete para cambiar el look de la aplicación. -->
  <!-- - Finalmente utilice el servicio gratuiro de shinyapps.io para publicar la aplicación. -->
  
  <!-- Importante/hints: -->
  <!-- - No se pide ningún paquete en particular, pero el ir utilizando más paquetes _pomposos_ -->
  <!-- otorgará puntos los que pueden ayudar a compensar puntos no terminados. -->
  <!-- - Puede revisar la lista de indicadores con `mindicador::mindicador_indicadores$codigo`. -->
  <!-- - recuerde que existe `dateInput` y `dateRangeInput`. -->
  
  <!-- Enviar a más tardar el domingo 15 de noviembre el script y el link de la aplicación -->
  <!-- al correo **jbkunst@gmail.com** con el asunto **Evaluación shiny Sección B** Indicando en el cuerpo del mail -->
  <!-- los integrantes (a lo más 2). -->