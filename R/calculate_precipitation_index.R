#' Calculate Precipitation Index
#'
#' Reads and processes precipitation data to calculate PCI.
#'
#' @param precipitation_raster Raster object representing the precipitation data.
#' @return A `raster` object representing the PCI.
#' @examples
#' \dontrun{
#' precipitation_path <- system.file("extdata", "precipitation.tif", package = "DroughtIndices")
#' precipitation <- raster(precipitation_path)
#' pci <- calculate_precipitation_index(precipitation)
#' print(pci)
#' }
#' @import raster
#' @export
calculate_precipitation_index <- function(precipitation_raster) {
  min_precip <- cellStats(precipitation_raster, min)
  max_precip <- cellStats(precipitation_raster, max)
  pci <- (precipitation_raster - min_precip) / (max_precip - min_precip) * 100
  return(pci)
}
