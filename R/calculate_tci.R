#' Calculate TCI
#'
#' Calculates the Temperature Condition Index (TCI) from LST.
#'
#' @param lst_raster Raster object representing the LST.
#' @return A `raster` object representing the TCI.
#' @examples
#' \dontrun{
#' B4_path <- system.file("extdata", "B4.tif", package = "DroughtIndices")
#' B5_path <- system.file("extdata", "B5.tif", package = "DroughtIndices")
#' B10_path <- system.file("extdata", "B10.tif", package = "DroughtIndices")
#' B11_path <- system.file("extdata", "B11.tif", package = "DroughtIndices")
#' B4 <- raster(B4_path)
#' B5 <- raster(B5_path)
#' B10 <- raster(B10_path)
#' B11 <- raster(B11_path)
#' lst <- calculate_lst(B4, B5, B10, B11)
#' tci <- calculate_tci(lst)
#' print(tci)
#' }
#' @import raster
#' @export
calculate_tci <- function(lst_raster) {
  min_lst <- cellStats(lst_raster, min)
  max_lst <- cellStats(lst_raster, max)
  tci <- (max_lst - lst_raster) / (max_lst - min_lst) * 100
  return(tci)
}
