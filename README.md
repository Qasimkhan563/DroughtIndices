# An R Package for Calculating Drought Indices

#### Muhammad Qasim

# Introduction and Motivation

Drought is a critical environmental issue affecting agriculture, water resources, and ecosystems. Monitoring and assessing drought conditions are essential for effective water management and mitigation strategies. The `DroughtIndices` package provides tools to calculate various drought indices using remote sensing data. This vignette demonstrates the use of the package to compute and analyze drought indices for the Garbahaarey district of Somalia as a case study, utilizing April 2021 datasets. The
results will be verified against the FAO Somalia drought index.

# Data Description and Exploration

The dataset includes satellite imagery bands and a climate data i.e., precipitation raster acquired using google earth engine script. The satellite data comprises of four Landsat 8 bands all in raster formats with cloud cover less than 1%:

-   B4: Red band
-   B5: Near-Infrared (NIR) band
-   B10: Thermal Infrared (TIR1) band
-   B11: Thermal Infrared (TIR2) band
-   Precipitation data from CHIRPS

These data files are included in the `inst/extdata` directory of the
package.

# Example Usage

## Define File Paths

Specify the paths to your input files:

B4_path <- system.file("extdata", "B4.tif", package = "DroughtIndices")

B5_path <- system.file("extdata", "B5.tif", package = "DroughtIndices")

B10_path <- system.file("extdata", "B10.tif", package = "DroughtIndices")

B11_path <- system.file("extdata", "B11.tif", package = "DroughtIndices")

precipitation_path <- system.file("extdata", "precipitation.tif", package = "DroughtIndices")

output_path <- tempfile(fileext = ".tif")

## Read Input Rasters

rasters <- read_input_rasters(B4_path, B5_path, B10_path, B11_path, precipitation_path)

B4 <- rasters$B4

B5 <- rasters$B5

B10 <- rasters$B10

B11 <- rasters$B11

precipitation_raster <- rasters$precipitation

# Print raster summaries

print(B4)

print(B10)

# The Analysis

The analysis involves calculating various drought indices: NDVI, VCI, LST, TCI, PCI, and SDCI.

## Calculate NDVI

The Normalized Difference Vegetation Index (NDVI) is calculated using the red and NIR bands:

ndvi <- calculate_ndvi(B4, B5)

print(ndvi)

## Calculate VCI

The Vegetation Condition Index (VCI) is derived from the NDVI:

vci <- calculate_vci(ndvi)

print(vci)

## Calculate LST

The Land Surface Temperature (LST) is calculated using thermal bands of Landsat 8:

lst <- calculate_lst(B4, B5, B10, B11)

print(lst)

## Calculate TCI

The Temperature Condition Index (TCI) is computed from the LST:

tci <- calculate_tci(last)

print(tci)

## Calculate PCI

The Precipitation Condition Index (PCI) is calculated from precipitation data:

pci <- calculate_precipitation_index(precipitation_raster)

print(pci)

## Calculate SDCI

The Standardized Drought Condition Index (SDCI) is calculated using VCI, TCI, and PCI:

sdci <- calculate_sdci(vci, tci, PCI)

print(sdci)

# Visualize the Raster Layers

Visualize any raster layer with a color gradient from green to yellow to red:

## Visualize the Precipitation raster

visualize_raster(precipitation_raster)

## Visualize the NDVI raster

visualize_raster(ndvi)

## Visualize the LST raster

visualize_raster(last)

## Visualize the SDCI raster

visualize_raster(sdci)

# Discussion of the Results

The calculated indices provide a comprehensive view of drought conditions in the region. NDVI indicates vegetation health, VCI, and TCI provide insights into vegetation and temperature conditions, respectively, while PCI reflects precipitation levels. The SDCI integrates these indices to give a standardized measure of drought conditions.

## Export Results

The results can be exported for further analysis and visualization:

export_analysis_results_local(sdci, output_path)

print(output_path)

# Conclusion

This vignette demonstrated how to use the `DroughtIndices` package to calculate and analyze various drought indices from remote sensing data. These indices are valuable tools for monitoring and assessing drought conditions, supporting effective water management and mitigation strategies.
