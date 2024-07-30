#' Read Input Rasters
#'
#' Reads specified raster bands and precipitation data, and returns them as a list of `raster` objects.
#'
#' @param B4_path Path to the B4 (red) band raster file.
#' @param B5_path Path to the B5 (NIR) band raster file.
#' @param B10_path Path to the B10 (thermal) band raster file.
#' @param B11_path Path to the B11 (thermal) band raster file.
#' @param precipitation_path Path to the precipitation raster file.
#' @return A list of `raster` objects: B4, B5, B10, B11, and precipitation.
#' @examples
#' \dontrun{
#' B4_path <- system.file("extdata", "B4.tif", package = "DroughtIndices")
#' B5_path <- system.file("extdata", "B5.tif", package = "DroughtIndices")
#' B10_path <- system.file("extdata", "B10.tif", package = "DroughtIndices")
#' B11_path <- system.file("extdata", "B11.tif", package = "DroughtIndices")
#' precipitation_path <- system.file("extdata", "precipitation.tif", package = "DroughtIndices")
#' rasters <- read_input_rasters(B4_path, B5_path, B10_path, B11_path, precipitation_path)
#' print(rasters)
#' }
#' @import raster
#' @export
read_input_rasters <- function(B4_path, B5_path, B10_path, B11_path, precipitation_path) {
  B4 <- raster(B4_path)
  B5 <- raster(B5_path)
  B10 <- raster(B10_path)
  B11 <- raster(B11_path)
  precipitation <- raster(precipitation_path)

  return(list(B4 = B4, B5 = B5, B10 = B10, B11 = B11, precipitation = precipitation))
}
