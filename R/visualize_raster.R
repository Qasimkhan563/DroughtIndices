#' Visualize Raster
#'
#' Visualize a raster layer with a specified color gradient.
#'
#' @param raster_layer Raster object to visualize.
#' @param main_title Character string representing the title of the plot. Default is NULL, which generates a title based on the raster layer name.
#' @param xlab Character string representing the label of the x-axis. Default is "Longitude".
#' @param ylab Character string representing the label of the y-axis. Default is "Latitude".
#' @param color_palette Character vector representing the color palette. Default is c("green", "yellow", "red").
#' @return A plot of the raster layer.
#' @examples
#' \dontrun{
#' visualize_raster(precipitation)
#' visualize_raster(vci)
#' visualize_raster(ndvi)
#' visualize_raster(lst)
#' visualize_raster(sdci)
#' }
#' @import raster
#' @import rasterVis
#' @importFrom grDevices colorRampPalette
#' @export
visualize_raster <- function(raster_layer, main_title = NULL, xlab = "Longitude", ylab = "Latitude", color_palette = c("green", "yellow", "red")) {
  if (!requireNamespace("rasterVis", quietly = TRUE)) {
    stop("Package 'rasterVis' is required but not installed.")
  }

  # Ensure the min and max values are set
  raster_layer <- raster::setMinMax(raster_layer)

  # Generate the title based on the raster layer name if not provided
  if (is.null(main_title)) {
    main_title <- paste(names(raster_layer), "- Raster")
  }

  min_val <- raster::minValue(raster_layer)
  max_val <- raster::maxValue(raster_layer)

  rasterVis::levelplot(
    raster_layer,
    col.regions = colorRampPalette(color_palette)(100),
    main = main_title,
    xlab = xlab,
    ylab = ylab,
    at = seq(min_val, max_val, length.out = 101),
    scales = list(draw = TRUE, cex = 0.6),
    margin = FALSE,
    colorkey = list(space = "bottom", labels = list(cex = 0.8)),
    par.settings = list(
      layout.heights = list(
        top.padding = 2,
        main.key.padding = 1,
        key.axis.padding = 1,
        axis.xlab.padding = 1,
        xlab.key.padding = 1,
        bottom.padding = 2
      ),
      layout.widths = list(
        left.padding = 2,
        key.ylab.padding = 1,
        ylab.axis.padding = 1,
        axis.key.padding = 1,
        right.padding = 2
      )
    )
  )
}
