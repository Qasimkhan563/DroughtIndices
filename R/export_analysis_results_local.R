#' Export Analysis Results Locally
#'
#' @param raster_obj Raster object to be exported.
#' @param output_path File path where the raster will be saved.
#' @return Path to the saved raster file.
#' @examples
#' \dontrun{
#' B4_path <- system.file("extdata", "B4.tif", package = "DroughtIndices")
#' B5_path <- system.file("extdata", "B5.tif", package = "DroughtIndices")
#' B10_path <- system.file("extdata", "B10.tif", package = "DroughtIndices")
#' B11_path <- system.file("extdata", "B11.tif", package = "DroughtIndices")
#' precipitation_path <- system.file("extdata", "precipitation.tif", package = "DroughtIndices")
#' B4 <- raster(B4_path)
#' B5 <- raster(B5_path)
#' B10 <- raster(B10_path)
#' B11 <- raster(B11_path)
#' precipitation_raster <- raster(precipitation_path)
#' ndvi <- calculate_ndvi(B4, B5)
#' vci <- calculate_vci(ndvi)
#' lst <- calculate_lst(B4, B5, B10, B11)
#' tci <- calculate_tci(lst)
#' pci <- calculate_precipitation_index(precipitation_raster)
#' sdci <- calculate_sdci(vci, tci, pci)
#' output_sdci_path <- "D:/R_Package/sdci.tif"
#' export_analysis_results_local(sdci, output_sdci_path)
#' print(output_sdci_path)
#' }
#' @import raster
#' @export
export_analysis_results_local <- function(raster_obj, output_path) {
  writeRaster(raster_obj, filename = output_path, format = "GTiff", overwrite = TRUE)
  return(output_path)
}
