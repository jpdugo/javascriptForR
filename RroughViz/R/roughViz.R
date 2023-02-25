#'
#' @import htmlwidgets
#'
#' @export
roughViz_bar <- function(labels, values, width = NULL, height = NULL, elementId = NULL) {
  # forward options using x
  x <- list(
    data = list(
      labels = labels,
      values = values
    )
  )

  attr(x, "TOJSON_FUNC") <- gio_serialiser

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
gio_serialiser <- function(x) {
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
