#' Calculate SDCI
#'
#' Calculates the Standardized Drought Condition Index (SDCI).
#'
#' @param vci Raster object representing the Vegetation Condition Index (VCI).
#' @param tci Raster object representing the Temperature Condition Index (TCI).
#' @param pci Raster object representing the Precipitation Condition Index (PCI).
#' @return A raster object representing the SDCI.
#' @examples
#' \dontrun{
#' vci <- raster(system.file("extdata", "VCI.tif", package = "DroughtIndices"))
#' tci <- raster(system.file("extdata", "TCI.tif", package = "DroughtIndices"))
#' pci <- raster(system.file("extdata", "PCI.tif", package = "DroughtIndices"))
#' sdci <- calculate_sdci(vci, tci, pci)
#' print(sdci)
#' }
#' @import raster
#' @export
calculate_sdci <- function(vci, tci, pci) {
  sdci <- 0.5 * tci + 0.3 * pci + 0.2 * vci
  return(sdci)
}
