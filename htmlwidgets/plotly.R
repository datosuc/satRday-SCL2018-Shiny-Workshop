if(!require(ggplot2)) install.packages("ggplot2")
if(!require(plotly)) install.packages("plotly")

library(ggplot2)
library(plotly)

data(economics_long)

p <- ggplot(economics_long) +
  geom_line(aes(x = date, y = value, group = variable, color = variable)) +
  facet_wrap(vars(variable), scales = "free")

p

p +
  theme_minimal() +
  theme(legend.position = "bottom")
  
  
plotly::ggplotly(p)
  
  