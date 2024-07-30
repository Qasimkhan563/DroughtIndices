#' Calculate NDVI
#'
#' Calculates NDVI from the red (B4) and NIR (B5) bands.
#'
#' @param B4 Raster object representing the B4 (red) band.
#' @param B5 Raster object representing the B5 (NIR) band.
#' @return A `raster` object representing the NDVI.
#' @examples
#' \dontrun{
#' B4_path <- system.file("extdata", "B4.tif", package = "DroughtIndices")
#' B5_path <- system.file("extdata", "B5.tif", package = "DroughtIndices")
#' B4 <- raster(B4_path)
#' B5 <- raster(B5_path)
#' ndvi <- calculate_ndvi(B4, B5)
#' print(ndvi)
#' }
#' @import raster
#' @export
calculate_ndvi <- function(B4, B5) {
  ndvi <- (B5 - B4) / (B5 + B4)
  return(ndvi)
}
