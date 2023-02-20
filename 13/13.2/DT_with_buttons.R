library(DT)
library(shiny)
library(glue)

ui <- fluidPage(
  br(),
  DTOutput("table"),
  strong("Clicked Model:"),
  verbatimTextOutput("model")
)

server <- function(input, output) {
  output$table <- renderDT({
    # on click function
    onclick <- glue(
      "Shiny.setInputValue('click', '{rownames(mtcars)}')"
    )

    # button with onClick function
    button <- glue(
      "<i class=\"fas fa-trash\" role=\"presentation\" aria-label=\"trash icon\"><a class='btn btn-primary' onclick=\"{onclick}\">  Click me </a></i>"
    )

    # add button to data.frame
    mtcars$button <- button

    datatable(
      data      = mtcars,
      escape    = F,
      selection = "none",
      rownames  = FALSE,
      style     = "bootstrap"
    )
  })

  output$model <- renderPrint({
    print(input$click)
  })
}

shinyApp(ui, server)