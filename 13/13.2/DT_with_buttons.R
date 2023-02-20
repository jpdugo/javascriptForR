library(DT)
library(shiny)
library(glue)
library(dplyr)
library(stringr)

mtcars2 <- mtcars |> tibble::rowid_to_column()

# on click function
onclick <- glue(
  "Shiny.setInputValue('click', '{rownames(mtcars)} - {mtcars2$rowid}')"
)

# button with onClick function
button <- glue(
  "<a class='btn btn-danger' onclick=\"{onclick}\">
        <i class=\"fas fa-trash\" role=\"presentation\" aria-label=\"trash icon\"></i> Borrar
      </a>"
)

# add button to data.frame
mtcars2 <- mtcars2 |> mutate(` ` = button, .before = "mpg")

ui <- fluidPage(
  br(),
  fontawesome::fa_html_dependency(),
  DTOutput("table"),
  strong("Clicked Model:"),
  verbatimTextOutput("model")
)

server <- function(input, output) {

  my_values <- reactiveValues(
    mtcars = mtcars2
  )

  output$table <- renderDT({
    datatable(
      data      = my_values$mtcars, # use proxy to avoid flickering
      escape    = FALSE,
      selection = "none",
      rownames  = FALSE,
      style     = "bootstrap"
    )
  })

  observeEvent(input$click, {
    index <- str_extract(input$click, "- ([0-9]+)",group = 1)
    my_values$mtcars <- my_values$mtcars |> filter(!rowid == index)
  })

  output$model <- renderPrint({
    print(input$click)
  })
}

shinyApp(ui, server)