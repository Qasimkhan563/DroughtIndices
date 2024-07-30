#' Calculate LST
#'
#' Calculates Land Surface Temperature (LST) from Landsat 8 bands B10 and B11.
#'
#' @param B4 Raster object representing the B4 (red) band.
#' @param B5 Raster object representing the B5 (NIR) band.
#' @param B10 Raster object representing the B10 (thermal) band.
#' @param B11 Raster object representing the B11 (thermal) band.
#' @param pv_coeff Coefficient for PV calculation. Default is 0.004.
#' @param lse_coeff Coefficient for LSE calculation. Default is 0.986.
#' @param unit Character string indicating the output unit ("K" for Kelvin, "C" for Celsius). Default is "K".
#' @return A `raster` object representing the LST.
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
#' print(lst)
#' }
#' @import raster
#' @export
calculate_lst <- function(B4, B5, B10, B11, pv_coeff = 0.004, lse_coeff = 0.986, unit = "K") {
  # Calculate NDVI for LSE calculation
  ndvi <- (B5 - B4) / (B5 + B4)

  # Calculate Proportional Vegetation (PV)
  pv <- (ndvi - 0.2) / (0.5 - 0.2)
  pv[pv < 0] <- 0
  pv[pv > 1] <- 1

  # Calculate Land Surface Emissivity (LSE)
  lse <- pv * pv_coeff + lse_coeff

  # Convert thermal bands to radiance (assuming bands are in top of atmosphere reflectance)
  radiance_B10 <- B10 * 0.0003342 + 0.1
  radiance_B11 <- B11 * 0.0003342 + 0.1

  # Calculate Brightness Temperature (BT) in Kelvin
  bt_B10 <- 1321.08 / log(774.89 / radiance_B10 + 1)
  bt_B11 <- 1321.08 / log(774.89 / radiance_B11 + 1)

  # Average of B10 and B11 BT
  bt <- (bt_B10 + bt_B11) / 2

  # Convert BT to LST
  lst <- bt / (1 + (10.8 * bt / 14380) * log(lse))

  # Convert to Celsius if needed
  if (unit == "C") {
    lst <- lst - 273.15
  }

  return(lst)
}
