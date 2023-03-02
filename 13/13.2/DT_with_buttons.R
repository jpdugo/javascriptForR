library(DT)
library(shiny)
library(glue)
library(dplyr)
library(stringr)
library(purrr)
library(shinyjs)

mtcars2 <- mtcars |> tibble::rowid_to_column()

# on click function
onclick <- glue(
  "Shiny.setInputValue('click', '{rownames(mtcars)} - {mtcars2$rowid}'); this.style.backgroundColor = 'gray';"
)

# button with onClick function

button <- map_chr(
  .x = onclick,
  .f = \(.x) div(
    class = "btn-group",
    a(
      class   = "btn btn-danger",
      onclick = .x,
      icon("trash"),
      "Delete"
    )
  ) |> as.character()
)

# add button to data.frame
mtcars2 <- mtcars2 |>
  mutate(` ` = button, .before = "mpg")

ui <- fluidPage(
  useShinyjs(),
  br(),
  fontawesome::fa_html_dependency(),
  DTOutput("table")
)

server <- function(input, output) {
  my_values <- reactiveValues(
    mtcars = mtcars2
  )

  output$table <- renderDT({

    optns <- list(
      columnDefs = list(
        list(visible = FALSE, targets = c("rowid")),
        list(className = 'dt-center', targets = 1)
      )
    )

    datatable(
      data      = isolate(my_values$mtcars),
      escape    = FALSE,
      selection = "none",
      rownames  = FALSE, # https://github.com/rstudio/DT/issues/992
      style     = "bootstrap",
      options   = optns
    )
  })

  dproxy <- dataTableProxy(outputId = "table")

  observeEvent(input$click, {
    index <- str_extract(input$click, "- ([0-9]+)$", group = 1)
    my_values$mtcars <- my_values$mtcars |> filter(!rowid == index)

    replaceData(
      proxy          = dproxy,
      data           = my_values$mtcars,
      rownames       = FALSE,
      resetPaging    = FALSE,
      clearSelection = FALSE
    )

    updateFilters(dproxy, my_values$mtcars)

    alert(
      glue(
        "{input$click} deleted"
      )
    )
  })
}

shinyApp(ui, server)