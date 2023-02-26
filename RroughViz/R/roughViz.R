#' @title Create a Bar Plot
#'
#' @param data \code{list} A list of named vectors containing the data to be supplied.
#' @param roughness \code{character} More roughness correspond to a sloppier looking graph
#' @param width
#' @param height
#' @param elementId
#' @param ... Additional optional arguments passed to roughViz.Bar. see \url{https://github.com/jwilber/roughViz#roughvizbar}
#'
#' @import htmlwidgets
#' @examples
#' roughViz(
#'   data = list(
#'     labels = c("one", "two"),
#'     values = 1:2
#'   ),
#'   roughness = 1,
#'   type = "Donut",
#'   color = "red",
#'   font = "gaegu",
#'   highlight = "orange"
#' )
#' @export
roughViz <- function(data,
                         roughness,
                         type = c("Bar", "BarH", "Donut", "Line", "Pie", "Scatter", "StackedBar"),
                         width = NULL,
                         height = NULL,
                         elementId = NULL,
                         ...) {
  match.arg(type, c("Bar", "BarH", "Donut", "Line", "Pie", "Scatter", "StackedBar"))

  # forward options using x
  x <- list(
    data = data,
    roughness = roughness,
    type = type,
    ...
  )

  attr(x, "TOJSON_FUNC") <- serialiser

  # create widget
  htmlwidgets::createWidget(
    name = "roughViz",
    x,
    width = width,
    height = height,
    package = "RroughViz",
    elementId = elementId
  )
}

# serialiser
serialiser <- function(x) {
  jsonlite::toJSON(x, dataframe = "columns")
}

#' Shiny bindings for roughViz
#'
#' Output and render functions for using roughViz within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a roughViz
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name roughViz-shiny
#'
#' @export
roughVizOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "roughViz", width, height, package = "RroughViz")
}

#' @rdname roughViz-shiny
#' @export
renderRoughViz <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, roughVizOutput, env, quoted = TRUE)
}
