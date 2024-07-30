#' Calculate VCI
#'
#' Calculates the Vegetation Condition Index (VCI) from NDVI.
#'
#' @param ndvi_raster Raster object representing the NDVI.
#' @return A `raster` object representing the VCI.
#' @examples
#' \dontrun{
#' B4_path <- system.file("extdata", "B4.tif", package = "DroughtIndices")
#' B5_path <- system.file("extdata", "B5.tif", package = "DroughtIndices")
#' B4 <- raster(B4_path)
#' B5 <- raster(B5_path)
#' ndvi <- calculate_ndvi(B4, B5)
#' vci <- calculate_vci(ndvi)
#' print(vci)
#' }
#' @import raster
#' @export
calculate_vci <- function(ndvi_raster) {
  min_ndvi <- cellStats(ndvi_raster, min)
  max_ndvi <- cellStats(ndvi_raster, max)
  vci <- (ndvi_raster - min_ndvi) / (max_ndvi - min_ndvi) * 100
  return(vci)
}
