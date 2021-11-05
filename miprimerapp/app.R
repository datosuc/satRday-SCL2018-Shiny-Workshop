library(shiny)

ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of observations:", min = 0, max = 1000, value = 500)
    ),
    mainPanel(
      plotOutput("plot"),
      "otro grafico",
      verbatimTextOutput("summary"),
      tableOutput("tabla"), 
      "otro contenido"
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({ hist(rnorm(input$obs)) })
  output$summary <- renderText({ input$obs })
  output$tabla <- renderTable({ data.frame(input$obs) })
}

shinyApp(ui, server)