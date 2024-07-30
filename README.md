# An R Package for Calculating Drought Indices {#an-r-package-for-calculating-drought-indices .title .toc-ignore}

#### Muhammad Qasim {#muhammad-qasim .author}

::: {#cb1 .sourceCode}
``` {.sourceCode .r}
library(DroughtIndices)
```
:::

::: {#introduction-and-motivation .section .level1}
# Introduction and Motivation

Drought is a critical environmental issue affecting agriculture, water
resources, and ecosystems. Monitoring and assessing drought conditions
are essential for effective water management and mitigation strategies.
The `DroughtIndices` package provides tools to calculate various drought
indices using remote sensing data. This vignette demonstrates the use of
the package to compute and analyze drought indices for the Garbahaarey
district of Somalia as a case study, utilizing April 2021 datasets. The
results will be verified against the FAO Somalia drought index.
:::

::: {#data-description-and-exploration .section .level1}
# Data Description and Exploration

The dataset includes satellite imagery bands and a climate data i.e.,
precipitation raster acquired using google earth engine script. The
satellite data comprises of four Landsat 8 bands all in raster formats
with cloud cover less than 1%:

-   B4: Red band
-   B5: Near-Infrared (NIR) band
-   B10: Thermal Infrared (TIR1) band
-   B11: Thermal Infrared (TIR2) band
-   Precipitation data from CHIRPS

These data files are included in the `inst/extdata` directory of the
package.
:::

::::::: {#example-usage .section .level1}
# Example Usage

:::: {#define-file-paths .section .level2}
## Define File Paths

Specify the paths to your input files:

::: {#cb2 .sourceCode}
``` {.sourceCode .r}
B4_path <- system.file("extdata", "B4.tif", package = "DroughtIndices")
B5_path <- system.file("extdata", "B5.tif", package = "DroughtIndices")
B10_path <- system.file("extdata", "B10.tif", package = "DroughtIndices")
B11_path <- system.file("extdata", "B11.tif", package = "DroughtIndices")
precipitation_path <- system.file("extdata", "precipitation.tif", package = "DroughtIndices")
output_path <- tempfile(fileext = ".tif")
```
:::
::::

:::: {#read-input-rasters .section .level2}
## Read Input Rasters

Read the input raster bands:

::: {#cb3 .sourceCode}
``` {.sourceCode .r}
rasters <- read_input_rasters(B4_path, B5_path, B10_path, B11_path, precipitation_path)
B4 <- rasters$B4
B5 <- rasters$B5
B10 <- rasters$B10
B11 <- rasters$B11
precipitation_raster <- rasters$precipitation

# Print raster summaries
print(B4)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : B4.tif 
#> names      : B4
print(B5)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : B5.tif 
#> names      : B5
print(B10)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : B10.tif 
#> names      : B10
print(B11)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : B11.tif 
#> names      : B11
print(precipitation_raster)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : precipitation.tif 
#> names      : mean_precipitation
```
:::
::::
:::::::

::::::::::::::::::: {#the-analysis .section .level1}
# The Analysis

The analysis involves calculating various drought indices: NDVI, VCI,
LST, TCI, PCI, and SDCI.

:::: {#calculate-ndvi .section .level2}
## Calculate NDVI

The Normalized Difference Vegetation Index (NDVI) is calculated using
the red and NIR bands:

::: {#cb4 .sourceCode}
``` {.sourceCode .r}
ndvi <- calculate_ndvi(B4, B5)
print(ndvi)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : memory
#> names      : layer 
#> values     : -0.1305777, 0.5001485  (min, max)
```
:::
::::

:::: {#calculate-vci .section .level2}
## Calculate VCI

The Vegetation Condition Index (VCI) is derived from the NDVI:

::: {#cb5 .sourceCode}
``` {.sourceCode .r}
vci <- calculate_vci(ndvi)
print(vci)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : memory
#> names      : layer 
#> values     : 0, 100  (min, max)
```
:::
::::

:::: {#calculate-lst .section .level2}
## Calculate LST

The Land Surface Temperature (LST) is calculated using thermal bands of
Landsat 8:

::: {#cb6 .sourceCode}
``` {.sourceCode .r}
lst <- calculate_lst(B4, B5, B10, B11)
print(lst)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : memory
#> names      : layer 
#> values     : 291.869, 312.946  (min, max)
```
:::
::::

:::: {#calculate-tci .section .level2}
## Calculate TCI

The Temperature Condition Index (TCI) is computed from the LST:

::: {#cb7 .sourceCode}
``` {.sourceCode .r}
tci <- calculate_tci(lst)
print(tci)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : memory
#> names      : layer 
#> values     : 0, 100  (min, max)
```
:::
::::

:::: {#calculate-pci .section .level2}
## Calculate PCI

The Precipitation Condition Index (PCI) is calculated from precipitation
data:

::: {#cb8 .sourceCode}
``` {.sourceCode .r}
pci <- calculate_precipitation_index(precipitation_raster)
print(pci)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : memory
#> names      : mean_precipitation 
#> values     : 0, 100  (min, max)
```
:::
::::

:::::::: {#calculate-sdci .section .level2}
## Calculate SDCI

The Standardized Drought Condition Index (SDCI) is calculated using VCI,
TCI, and PCI:

::: {#cb9 .sourceCode}
``` {.sourceCode .r}
sdci <- calculate_sdci(vci, tci, pci)
print(sdci)
#> class      : RasterLayer 
#> dimensions : 3472, 5126, 17797472  (nrow, ncol, ncell)
#> resolution : 0.0002694946, 0.0002694946  (x, y)
#> extent     : 41.72073, 43.10216, 2.74588, 3.681566  (xmin, xmax, ymin, ymax)
#> crs        : +proj=longlat +datum=WGS84 +no_defs 
#> source     : memory
#> names      : layer 
#> values     : 15.79101, 77.81927  (min, max)
```
:::

#Visualize the Raster Layers

Visualize any raster layer with a color gradient from green to yellow to
red:

::: {#cb10 .sourceCode}
``` {.sourceCode .r}
# Visualize the Precipitation raster
visualize_raster(precipitation_raster)
```
:::

![](data:image/png;base64,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)

::: {#cb11 .sourceCode}
``` {.sourceCode .r}
# Visualize the NDVI raster
visualize_raster(ndvi)
```
:::

![](data:image/png;base64,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)

::: {#cb12 .sourceCode}
``` {.sourceCode .r}
# Visualize the LST raster
visualize_raster(lst)
```
:::

![](data:image/png;base64,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)

::: {#cb13 .sourceCode}
``` {.sourceCode .r}
# Visualize the SDCI raster
visualize_raster(sdci)
```
:::

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASAAAAEgCAMAAAAjXV6yAAAB71BMVEUAAAAAADoAAGYAOjoAOmYAOpAAZpAAZrYA/wAF/wAK/wAP/wAU/wAZ/wAe/wAk/wAp/wAu/wAz/wA4/wA6AAA6ADo6AGY6OgA6Ojo6OmY6OpA6ZpA6ZrY6kLY6kNs9/wBC/wBI/wBN/wBS/wBX/wBc/wBh/wBmAABmADpmAGZmOgBmOpBmZmZmkLZmtrZmtttmtv9n/wBs/wBx/wB2/wB7/wCA/wCF/wCL/wCQOgCQOjqQOmaQZgCQZjqQkGaQkLaQkNuQtpCQttuQtv+Q2/+Q/wCV/wCa/wCf/wCk/wCq/wCv/wC0/wC2ZgC2Zjq2ZpC2kDq2kGa2tma225C229u22/+2//+5/wC+/wDD/wDI/wDO/wDT/wDY/wDbkDrbkGbbtmbbtpDb27bb29vb/7bb///d/wDi/wDn/wDs/wDy/wD3/wD8/wD/AAD/BQD/CgD/DwD/FAD/GQD/HgD/JAD/KQD/LgD/MwD/OAD/PQD/QgD/SAD/TQD/UgD/VwD/XAD/YQD/ZwD/bAD/cQD/dgD/ewD/gAD/hQD/iwD/kAD/lQD/mgD/nwD/pAD/qQD/rwD/tAD/tmb/uQD/vgD/wwD/yAD/zgD/0wD/2AD/25D/27b/3QD/4gD/5wD/7AD/8gD/9wD//AD//7b//9v////kVnlcAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO19h4Mc93kdKBNRIhdJphLFjgxJJAjakuPwyhbFcYnDLbO7cJwibZ2z4wTT7dhxIwngyvY2u3PTqeng/aF5v927w5G4u7m2wFKeDyB4t9Pfft/73pvflHtHSVwa9970Dqx7JADFRAJQTCQAxUQCUEwkAMVEAlBMJADFRAJQTCQAxUQCUEwkAMVEAlBMJADFRAJQTCQAxcQqAPr8J/fuP7nN0ot46zd+eslM//VnN97A9WJ9AQJEH100z89/9LUEIMTXL5rn8b1fBID+149wjL/xEfl1caSH9+59iIl/itT4HsFv595b//lH97725UI6gfez73xhLYg//y4W/Xc/JfggAFHsuu4gVgfQ4Wmd7Cy/78XX/uKDxadv/4wcFIlXcu00/x5/cS3H85OVHAMUv647iJUBhH/+xROSBg/IP0gdHM7XFyj9dPkpOaj7Pz363+cufXScQWfWQpZ/cvQX98iiyxKLX9cdxEo56C//23cJkSxrbFFhOEoczjKndhYld97SJ/Hg6MxagMTb//N4npNkjFvXHcTqAPr8D06ZdmdZF/cXuXCm8l62qUW1LFF9CRAS5sxalp//0r8nMy0AumhddxurLLF7b//RXy7qitTY8vs+vHdlgN7+k+NfTtby8x8tl/wvxwBdtK67jZUBtOSGJfGQGlsewpKOlnExQID3z5a/nl0LIPrD7y5nO8mgc9d1t7EygJZNfXmAZP+/uzjgk0M9OrrwoI4ZbOfeKXGdrGUx9T8ty3XJQXHruoNYZQbdf/LznyzV3oIuFsf4+N5b/+Ho5x8QDC4HiPTyD4/OrAVY/dYTUmeni8av6w5ipRx0KofJL0vte6xdlrrmUoCAzdd+dnYtf/pSEh2e1UGXrOsOYrVd7O0/ORaJh6e+4ed/gGwicjgOIJJCX//CWv6CMNDCwhIJ/fZP49d1B/GaTnccrkynrDpeD0BgjtfmLu84XgdAC654ED/fWsZrAuit33oN21lJJKdcYyIBKCYSgGIiASgmEoBiIgEoJhKAYiIBKCYSgGIiASgmEoBiYuUA3ftKxJsE6Epz5bK5Fe/HpbH2AOVz2Uw2v+pduTjWH6BsNpfL5d9YFq07QMVCIZfJZdKZ9HZq1ftzbqw7QAUAlM9lUtlcZhsgrXqXXo11B6hUKObz+XQmX8xvp1Kp7Y1V79SXY80BovLFQjabzaSz+TTg2d549P7W1qr36wuxCoAenwzkLMaIP/vR2x999m/INTtfHt25wgbyxXIlnSE8ndrMpre3Hz58f+vR1utkoxUAdPj1oxe/87PlD0Dlzz968cef/dvv3QigYpEq5TKIfDqdymxtbD18uL25md56jWS0mhJbArTzu6cZ9L2dD18CdAWRuoxKOZ/NZ7a2trLoYuCfja1idnt7K/1oY2tr49HNd+86sRKAHh9fjUAukFqg8tn3ANn1M6hSyWdy+Y3tdDoLmLYLxSxoKJ15BKg2NjY3M5s33sOrx4pIemdxZQsQOVxA9dn3UG/XB6hcqJSpYj6VyqWy6c33QdOgodQ2tZna2tx8/+HDR9urT6NVcNCDY4AOz2QQSavrAlSi8qViBqggMun0VopwdQ5NbSuVfm9rq1qrZh5upDI33M0rxoq6GHj6x+TSnONhZQLQiw+uCxAUUK6UyWyltkDTW9vb24U8fkhlstupzdR2oRyKDzc2U6nVVtoa66BivkDlCukciiqVATzbW9ltaGoQUmqrQOdzvJ/eyGRz6a3t9AohWmeAspDQ2+ltZEwmm8mAoIuZXCmVS2coQaUKmTqTgpOlMuj62Wx6VYZ/fQHKUwW4eBx6FtBkM7kC8fXbBTS0dDE0yy2qWHiUq1YAXCaTy+YK1TL1mnfyDQNULBVz+VI+CweWyuRz+TRh523y+2Y2JzBcQG9lS8V8FgwOO1vIFmH7V5BGawxQpZjDIWcXMhqGNZfLppBBGxCK1aYbVlKlTJ7Kov9nC7mNQh4JVchWyum7dmprC1CpjC4PF5bfTudTxVKFVBv4B3ydT1XsWS1VTpeQObl0dpFAhWKxkCmizaVzd3tubW0BqpeparWcI6c6skWqQBXThXSBSm8/2tws0WYpS5WKxSpVKKULhRyyh6JKZVRhupDN322lrStA5RKafKtZLVbyVaoCrAASOTG0ub2dzQozsV4q5EHb21vkTBGyp1jMg6lzeSqf38wXCneH0boCRKVz2VKzVi6WsmXkR7lUBA1Tuc2tza0tznMCnsml85ntVC6PxCpQ2UIR/Q0aKVPIFgqVTK6Y46ur3sk3CVCGAvsWqXoFZoNC+ZTKcKpQQ8Wt7VKVC8VcOl3YzpQyhVwBWhFiqEQGP8inpWIlRxbxqoXCXZw3WlOAtuEtQDmVUhGlRAEdqkhl8CGyRJ3Uqe2trdxGOpWhNsuFNJUrFkHNsLK5SgmFBm1QzGVrFJV9tHF7jb2eAOW3yThGvl4s4WArFJpYqYCmn89nvO3UFhpbrgjy3s5S+BBdniohubLZQjqfA1SFDBkIKRRKrU1oglxjVTv5RgFKp2AxtgBLlTBQMYumj3aeSWUrKVTWVjnHVqGxMykqh/Qp16gc8KHSGwWkWLaQRb3l4UiyAhxuPl0sr2Yn3yBASB+kBY4d5FwukxxBm8oCrQwFJ08MKwtYmqBjGI96oVKuVzBfpYnOl6OytUazkGtQhUo+J5Sy2UqpWizSd7+TVwDoBbnd6PHNr5O/cAPpFBpWkUqXy/UqcqcMG0HVC1mKgm9NZ8qAi66W8lSzkIECSufKlWK5VCg3yqisXCZTqjUrlTw4qJJppjOVejkLy0LftNJuAdDhWx/t3H/y4oMbI3TRBuDci3mIm3y5UqVqpRKkIH4h1qOaTm9TmWKZalE1Kl+oVgqFQr1OZGS9BJByEJOpfLXSJH2vUC4HADabzWwWs8UqU70ZRDcH6POfPDjaITes3fhelIs2AD+aL0ICFSCmK9U6MVlwE0Q5os+X6rlSMVNs1OoNKp9l4NGqFBldLAGTzDb8K3of1WRbVDlHFZqNYim1lSqXi2yjQfPN+t3t5OWTSJAzhASgw1cAevzyBqedBzcYF4NDzRVKtUq9UauW6tA0RThSwITEyqXyZbT8VL5eKBertUo+X8nlapUyRHYBMyNfijlKqNN0pVag4fXFfCmbKRQrtSbDtliBZprS5Ud1HRSumEGPv/xQg9NxMXIv2IOja4+LZRH5cqEE7m1UKzWoPoibdKVKBqCz6XI+W0gVcpUCyAnApbbzLa6epcr5WhWqaStfLDPNOl1Bac7ZHNXMVXPlTLlaL3EVgWOYFsf6weXHdXUUrsZBO+fdDncM0Ge/+RcPrj0utlUswWBUq1Wqju+9wTbKtRIFK0bGoNHaMoUS5FC53ELjz5f1OpmtUi7VGwzXqjcrdV4SeYGmaSmoUi2uytC1aqPcwFSOxQRBcA1ddbQrIBOPwlW62PkPqjkeFwNMhycn7a8+LkaVyxRVrkIblurVeqsBgNCmitl8A02sAj8Bd1rKVkt0PZfnyrWQLVClxXyVit9g6ywrhhzdajWLpWKtSdfr5WaDaTVDQZAiLxJ93TB8RZnFHdtVULj9uBjJkuuOi32/UqGoHFUpg1mraEg15Ad+KRSAC2lZsKHFPOGlSi2b8yQhrFLlSqNaq9XrNaZW5WghckS6RZcqeRRWvdqot5rIHlaUIil0PM90HHOuzmbD4dWOZJXjYkcn44bXGRd7WANChTLsKZpRvVxt1mvVOgCCIyvBdBTR29HmSV/PZ7dr29vZaqXcLFZabJ2pVlp8k+ZbLG3RTAUSoVhrNRsAi+Z4yQ991/N8z4sCWzMMVZ7P5lfJoxsCdHzb9SLO62LLcbEvAHTFcbEcEoac5Sjmq9Vas16pI4eAWQm2vlpu5WFeYfKLhXyDKUFPbqby+Zor5OrNukDXWdK/JIFp1WuNWpmkFfiaa7CCJAKYMAyiKHJ9T3d1XRmPZU1R9VUBROJwUT6HN7/p+rwN/LCOUqkSUYO6gtipN9lGE0eKeqNKDEwXFHSWKtWqEIrNFGRRpSqIDFOuMgGKi27UBAaSp1pugJRqNaZZZUWO4cTID0Mf//CR6/im4xnT8WQqq4qlxvH1bdr88nb3nRs/u+i8DfxKFYdXJc6KKoFcgBEoCcarDDcPYYTuD/1YKVUyBeibfL5UaVZqbIlnQp7lQ9K9AEejFhgzWgKDiTV0L0l0vcC3TTP0TMOyTNO0/Iky6fUmY3nY77Tbz6+7k/GTSJyUzKtC8apxzga++c1aqVGulgkG+IsEqYGEIWpgNSi+0cyXQNHgolyhUinUa4VytVYv1xrlIJKkQBJpsHEzYppWj2ElusVQdZpFaw8k33Zd17Esj/xPM83ZbIQaGw1G/c7eXvugfSMUriAUSbwiFK8c52zg29+soMIqtQrbpCvlRQNrIGcAVpUSqGIJtdVsQhDWKrlCrgwOB81A47iiGPKeREdig6fxYz+URJFrsaUmzfCEoW3LsF3g4wW2qqiqMRmOpqPJcDruDnr9yXjW3d27PgrxHERSaOcuOehb33qn3qqzNKqMUHOtCg1ULZVK6FzFZrVYLTRr4O4yzCs5Qw+mrsKRsGLE8tCHbhRyrQbd5BVeFEWeA1M3Gs0mI3CRZ1lWZFuu4/iarM7nM1TXeCZPJ3J30O8P+p39p7vd/uSaKFxNKN7i6WmvbuAbv/brzTrTqKGy6vUKDRapNOrLegM3lVBrENh5OFd4r0w6Vy5WSiD1iKMbPGQyzzUZpt5oMTJEIdtqtEDXrUaVE4LIBjFbjm+HnqoqE2U2Hk9Gk+kYSTQcj4eDTuf5wUFnMD4HorU6YfbOO99u1BssXDewaNUrDQYJ1KAWoppkFbCqUoUi+bdIBpsrsF90w2ZZGlwMlm61asgYRgqQQFSl3uLZUqlVFYUwCDzN0w3bsx1zOuzNZrPxZDaVJ+O5NpWnw267sw8q6o8Hk1ea2loB9OgH79L1ZjNqVJkmWnWtCcaplKgCGdWo0mjZzUY+B7MBQ4HCq3DNRouzdNvneY7zQdM8zzICw4gR36i0GJrmeV9Eg/MsHX8n06GsqvJo3On0J/2pMhgPesPhoNft9waDdvfT3R5Kbqo6uq5fupNXmkTiVCveWRd7591336s2Ww2uRjdbrTpFZEwV6hklVWVaNAPlVyZniQqg7zJRQM1ak9dcV0LySEHIMy0Bdcbgn5nQgMEQJCnyWT4KLd1S9fF0JGuaPBkAmX4fDWzYnw1Ho0F3MBj0Dzp7XXwwUhXH1dSxfBcAHcfNu/wrG3j34fcfNcEhAo3WBLapMzUYjlKxmK8U6wxdrUEhw9mX0M2qkAJUtd4QLMf2Q5HlhFBgOZpmRQFyiJXmTKPJsi3W9wPe92xwtDybTKeorekAadMHSMPRfIQfhwfg6F5/vzcaqkND0TRD13RZnl8BhSuW2OMLH6saF1/awPe//c7DRqvW8IRWAx6hXKrSNER1BR0sU6RqsGQQPSV4MWpxlr5YrtTZwHXCSBQiifFDQYSH5yX8YVrhsIr2X294ri/wvuXpM1udKvPpZDLsA6ERqmswHk3lTq/bG417gyHqbiR3x1NVh6LUVVWTZTkOhSsCdGdC8d0fPnxfbElSQxI5JFIduYSeX62QMQ0qD0VUq7dqVK2IEkP3KlfrLVqUWmEUiBIjwqxznEB6mRQxDC12GJqBjA4CFwTNQUM7s/FIlcfydIyY9obTCTKoP+z1UG09CMZuv92ZdKczVbMsRVNNZabMFe0uALqzc9IPf/DuRqNB1xsVvkU32FazWSN+qpEvZEldQVFX67UiVarCyaKzVVBPTJ2NIjStKBR4T4QgEuBLA4Fr0aYkobmJkgiHyvuwYZqqoG/JiowGj77Vn4xm8z6KqyMrhj4aD/vdvYP+YKLMVduEltQ0RVZmqmHfGqAXH9xRiT16f/Phu7xE857gSw2eoZtNmkbfpotZyOYCWj0EUb1Sy1fKpXIRbhXikKFZ5FqNEyJ0LpZn4TQ4PhKRWj6SSWw0NF/3gtA3rMA2jPlkMpnJg+G43xkOJuMJurvSHY2RVyOUXafdGajyDD7E9R3X9W3wkWu5t+9iN1eKX9jAxqOHW+/y0HxoRbwk8K4Ikq02oBipQj5dyKDd16gi8fWVUrPZotmqK/I6j2QRaK4lhm4U+S0aOcOJPEvTT+2oxfORrime5NhAx7VkZS7LqjaSR51uF3XV63YB1VwZjbs9bdDe7w3kwUTXHd1zEJ6lzE3T0ddGB2VSGw/foyFkaDAIGwheyDF0vV6qARY0+myRIu0L8MCgQRPVOQFZYQto8MRUSFLoOx7TYllegEpsNESN5hk+sm3bCQMXOjoCs2iyos7RxlBl4Gok0Kg70QagJFnr7Pa6aG1Tx7TtKLRhbG1dU11bukUG/fZHi//fDUlvpB5tbD/k2UjiaY7nLCNkkUKNCkxZvljI5AuLYUJ4VboGBdRsNT0h9F0xCpAmKEakTxhwyB+4dy4SWYabhhwbsoYTGV7gWK5tW/pcN8C7E4igUaff6XT3B/vd/mg80qfqoDvuDKCJFMkwTds1LdtyDFPT/eD2AL1K0ifjYuRRkPefXG1cbCu3+YN3H9IthmmJ8E605DghLBasfRO5A3ggh6hyKV9q1dh6o8E0Rc/0Alh0zMUxDdLLoggeFSwkwXUwoc9KLB+ojhdKnhnYjgWSnmuaOh1P5yCcTnd4sNtud3sdiKBep70/HnSn/b6r6Zqz0E1o9sDUcG4K0OOXp1y/PPR8o/vFHm1svffe+xx8GBcJrsDxguDyNN+q1uvkas58tlQsEdNR58p0hUfK8JIXKI4XgJXpOsMJIuv4EQ+uFqQw4nleYTgpiuboZm6kGXYwN+azuaGpc2jDUbfTPWg/P+gBnG6nP0Qva/cHnalmqoZmORBXKE1TMzxPuwUHnWTQudN+5ySrdj680rgYlc1lt9M5McTx+SEiEgMzEkSOgT5uwpTXqxAAzSpUNk83uDCCL/dU25EEhoN4RvZInuNKgqKovhoGAh8okm7AghmRH/gmOHpmwMTL8mw6JKc3DvYP9p7v9zrDPvIH5bY7bk8nM603nk4nFjgdCQRFjYRbDUk/Ps2qw6UGiB0Xy6cz6c08DwIRXSn0DCHyvNAIhJATWOjjVp2m61DXNYFlBQ8WlJxFdS0bKQNa5shJQ5gKG37VRbFJUI6K7Wmm7rlexHqh7QS2bkwVlBfoudc7aLfb+3uf7pH66nb2+/t7u7udTrs76MPgoypNFzlkaLoK47rKcbGXNiRuXKxUgFjeTkEKh4wguug8SCQThxoKnMBAPcKr0s1KhYOLkFqeE0iSYziGiPySCKfzrhTYkMz+wnYEkcRpJmlgtu+5DuyGFejqfEbO/yikeQGd/f3dZ8/aB51ur90f7u7vfnqwj0bfm8kzUI+DJQ1DMU3oxRsP+zy40M2fjot9/pMTSOLGxUrkEt9siudFkg2h46KHBa6khz6aOFtvAR6WYcDYmIHzfLCMZTiorybTZAWxIfJBGARR4EZeIHpRiN7v666Bg0T/cjzJlshpaHU0Gs6GvYN+Z7/d7uzvfvL0oL3fbXc7z3ef7z7r7u7jR8hq2/Qd2zRcELRlGcYqMuhkXOzx2ZHVy8bFKhS1kS5uboqChCKTIItxtH7ow1q7gUgUNYBoMbBiPqlCjg9N2/dDlgYS+FXkeMd3+RBLqJIASYS/pkX+SEGAJuY4ganrij4aKsNhb29/OOzu7z7d+/jZwd5+B0g9f/Z8bzjYR2Z15z50YuRY6PBII9e5eRe7Ux0EZ0WVyjlGEmCmwLl8RFpRGM10LwykmtigGzRKDGwtQBeyoocahL3CjBCFBCHRd3wxBEJgILhVX/JkxbSBkO97gedYvqEprjacTAZt9Pb2qLv36dNPnz3d3dvvtfeeP0Xu4E/noN1VoZp003UcVXfIAJFxG6txoQ66LkDVMseVOaZsBZLnCr7rglVt1VAmpmFbIBTUFRRgS+DgtThaEDhIP9ivAOUW8hInhaLkBiTtyOUJBFqsx8KiluMDJZ+HxhZQLLCqM8AwHI/l4acfP3u298n+HqGjvf2Dfr8tQ0eP5dkMFgN+3tI0E37D9/0V6KBrA9RoMU1wTIU0G0nyBQg118VeovNYaGYS2j0vMjwaGM8xDJSgL8FxsbyIdJN4pJrkO5oaSrCp4CzRtwPbHZkgWStwAs+yHdP3fHU2JC0eKno0GoyeQQR98unT3d3nB7u7B2jz+7Afo8FgPJ2pqqtp5KyHbRJBvRoddC2AYL5aTfTxsuWYnu+LnuS7hgUZYpuq64ShIPBCUwLRoLjAOdDH6HaSRH6RJORX5EeeDVKCw3CBmATv5blDZTLWTQga1zJUHCtMmDKVlSEZzOgPCDvvfvrJJ58+f95+9rwrd/f3+iNyLm00nSkzzVUVzSRayPLWwayCWoAR0zI0xzEdMfD5yA3BqnPV1DXTU0VJCMVIIowDHUmjscOR8qBzwkBo+KJpejZkUUSuARKI0MTiqBG9rYBPHG2uhKY6w+pkRVfH45kMadhG5/qnv//42fPnz3cPxv3x3gEs7Ah/Z7PZXLZ0HU7DtNTI9G4B0EmfvyUHtcj1KU2q3oRChPYLWB6Nx/V1fPPOVF/WmChKHCOEUMURTwZLGYjDFul1IjSBD2fiSYEXohLhw0I0OEO3NUNVVFsDLLOZo00UwmmTyXA0GwwH/V4bvesfP9492N3b6wxgOIaT6Xgy6COBZH+maIquq5ruBtAKtwDo8f0nO+S9Ojd+Iv1yAzS5DqNONeqwm6brB7QYsqHjGJZqwCJYQSCiVUce8gVYiALDtjiaFqARoSLJBNtHJwvDwEM+iWIATW37sOOWbuofqzAXk6ls6rI2mwynw3F/iD/9fu8petfHn7Sf7x8cDNqj3f3BYDIZj0aYeT6ZK3NF1TVdjzxLv8UZRXKB9CG5DPiWY/OOFzWbkHnRQJ1CyWn6TJXnk9lopEwG+twydQN6T9f8QEfn9gLLcEMXvgtexCO2UtGdCN0mcMzQQyVyUeBYHroXlDCOdExOLc8sA/1JHo1Hg/Gw3wYVd/ee7e1/ip4PKb3b7rd7I3KOmlzL0BvKUwA5mg6naoTvSLnd1R3kNMbiVMbNAQo86JiIVEjnaX88kDVDl6cjRUPPHfVHhqnPdccwVE3VTCsCBnBbgU8kcxD6lud4tg3V4vle6BqEogEQGWIGK+syENLH87E6ng9GMxz3ZNgdkbGfXq8z2B0+7yGVJoMDeA3U1lhB+UFqD/tdoDWeDocOyA1JfLurO0gnux1AohiFUDKuF4advc5oPFENuT+bTSdzeShPFBQZpIylKzBGbig69kIbSw7ETrS4ps5QF1fWoVm5vosezwK+wDJd4DyfadqkP0Y6Gv3pRJblqTyWtUF/0mnP9vf3ut3xfDQftffbvQm0EZAEPlq/1x0MhlN5Ymhgd0O/xRnFhUJ8/OCWJeYHkoBWDlaeD+UBvl+bdJuZ0oW17KsEH93SLewrjGjgwYB4HKQPmnkU+R4YHGbEsSO479DyHR5dX4xsG9oZRkOGF59O1Nnc0CfoW0iQcbvXPtjt9IcyBHVvDvc+ODjYO+iOx5P+ZDTu9QeDbr9PFBE86xSlqUm3AYh4dXSyW42skksrJdvRrNBrd7uj4WA819BE5iCgyVgjllyHINGmqgUyhv2CpYBMkkQWxgJWyQ4cw8Y/yB8LSgjNDMwNksbccwXkM59OwEHmFzfbgynd2+8iRceD/rCzNxgNJv3BdEiIGlpxArg0XyZLqo77pi9eCMAoLiy3FUVdfH/y4GBOrj6dT2cTGUrN1iEXI22m6LbrWo4boLaQJkgiaMQQxhv0Devve67t6q4nRiAOiZzgsBxjjjUpz9CYZsYF2x9NBoNOp0uG6Xvj6WjUm4x6Q+ihsW3ZszM7ecn+rzawAZSGA3Yx7CjsHMAS7ffmpN9Ox6oKyWbIE4BjqBD+qm/BfwSeL0D8QAjB00L7gJlV03Y83bJMxUFpmUDK8QMApKJlj9Wn3fFUdmL3ZDAcEgaCHhqcs5OX7P9V4jZunnFdWzUdL/DD9u5etzPZ7xgDeTgbyIoymyjj8VQZTi1D0TVyKt1xPQlUDPNBVLQEp+7ZhqLoHuQSzKhmhq5t6jZW5jqmBuM1kUfDiSzH78mlO3mTSWfjNgBF6DdwTGIUCbu7z8Cj3T4YoDfuTbQpuhAkkaIqUEKOrsNNWAuD7kMDcYLE0bzruPrivIRmGRDOANH34G8dZKXvAGC0wU9HE3V6w9072cmbTDobtwCIDsA+KiwhiOjZ7vO9Tme/0+2DKPHdg2MVcBH4CKrfUHXbtqCRPdCQ54giuWoMPxArallwFJZijRUFPAUPB7oiZ1kJQY93u1BAN9y945280aSzcQlAyzfJXTwuxvpo0KAgJ/Ld53v7B929550eOstwDE+tz6FgZBymQ6620EOYDw9yyXeghODBBCmQoAkdzVQgCkHmMxkd34I9scnIujefEdvQ6XfV9QVoOUB2ybgYR7uerzmaG0T7z/d29/cO9p/2oWqnA0PXQC4jGc1XNg0kkWPrHgSyRHSgT0ZRFxcsBJIPLQnFo+mKLGtkNMu0UHlh6Crz6ahPrvyJv9vg0lhxiQGgS8fFBCiW0IVIft5GF2t32nsHbdCqohuTsQJvNhiOYD5kiBocv2mrNqyY44cRw/JkvCfiAsP1bdeXfNAykLNdcuUB8gwKAH1wPuqNR1fG4rooXD6qccnNLC/j8b2r3C8WuH74bH+/024fHOyOR1BrymwGEoJI6fXgOfSZCec5101FsSzbAw/BczUZKeKJhzMDJwRte5aG1IGkhsBG+3ccdTqdyzJkzpVwuDBWrYN2rni/2N7+3uBg99kujNB4pvZHylAeQ8T1IW4VDS3c0E0NROMiSRw4f0YSOD5wI0lAT/fgQVjf1YJhqr8AAApHSURBVC0QOWgc8/jQ58Z4Nle7k17ndgewSoBe3jh2pfvF+p8+63YHxFLLB2Cf8X67A3c9m8pzVBjcmKrCHZmOEzisQC755aQIeigMfT8KpciFBgBAsGc+OeUKNaCOR5+Y4+4Vb5y7KFaaQY9PXoB5jfvFeqPOpN0djNuD3nQwhu6HgZ1MBwNdm07g7oMQx0/8hCfxgsAJoe27CwcC8vGsRTJBMYHPQ1eXx+68Pzj3BoOrxxqck34lOt3BsP8UjESu8x6q00l/OOmo2nw4AT4w8UHEB2IARyZIIh9EKDLoay8IFibDDy0LDc/yTF2GOBqNbqcT1xIgEt3OQXs+7/WhG9XxdEyGYcy5poURv7j0AzbDFfiA5gVWYoBXBJMmAJwwCEQ3IGMZnjM2bGs06K1uJ98oQCQ64/G42xuOp/O5BgE4V0zTlwAPOYcvRR7PMQ2WpfmmIPKha0Uh2j/SKfIDz7Z0W9ZgZGT5lgm01gAhJoPBoAvdqGmWOlcMk4hEPwI05MoPnm3wHM2wIqEkHy0f4Hls6EWOY89N0+NUfSKrq9vJdQDo6Kg9nA6mrmZYuolmD4A832dpQXIikeOaLMcxAgdoyFlXMojqeFIUBFBBtsUZqqHOf+EBIjFRNdUwYOwdzw3hbDkycuh7IdtkaDoMQhC1E9iu5cCtBZIUeo7iEJRsbar8gpfYacw0bTafWx5ksygwDDmtyPNus9EUJehqH+A4EImWFwpC4MCSqZVmYJva5JZN/qsD0NERhLThqqaNMhKjlihGQsTwHCsIoih6EEEeGZ2HQ6NB1o7jVgAPOX27wp1cM4BI2LoZOp7pR0KL5VgpaAEmEQ4/ImfzTZdnQ1bkvUDSg4ZlOBa0020p6CsGEIIIZ47jBUkQBRZulRPhNALPs0zP4ll8KLmurgUROZ9vKYqywp1cT4COjkxLhMfgRJrnQnJRfeRFkeSSsxwiJ8GFOAeoNzfU4ezN+T9HgBAcJ/k8jQ7PizwPeQiBSGysJKL3S6blS2Qo0UQx3hqfryhAJHioIT4SeDYIpMC3yTWXaPGC33dcj9QcOpv9zxqgoyOWYzi2Re4CXyBkkauoJj3Ltn1II5fckuJYq9zJtQcIQdNMC11MJBez2rauOaELI++GouhYDnj6okHVO9nJrwJAJODvIzd0ZNP2YNQ8x5m7jm8HyCjbjF86Ln4BADo6kkI/UA2kjOuRa6sMKAHf9x3J8W6/7hUAtLxNjPz0mDwC7lbvF7tyyLYKloaGBhPZhktSifDQ7Ve8AoCWt4mRH+4/wd/bvF/semGgxmxzMYZv+6IU+ZF/+5WuqMQW7zz67DefHN7q/WLXDtdyybhqAO/hCSEb3L6JrQig49vEDk9uib7h+8VuEqgzeNeQ8wMpXNMSO71NjFwkvLyA8YbvF7tphEAo4sBC61lip7eJ7Tw4fWbpjd4vdovwyQi+dwdNbBUALW8Te/HjJ6SdLUG52fvFbhdSIK0pQHex7fWJNwrQVyLeIECxW1q3z2822x3EugGRAHTDz2822x3EugGRAHTDz2822x3EugGRAHTDz2822x3EugGxdgB9RSMBKCYSgGIiASgmEoBiIgEoJhKAYiIBKCZWCtDiHo6Tpwm+HGD8DjlFdd7DQDD/6YDkmQdYXml+8hamr8es/2SfXt4DeOmsi1glQIvX3hwe30l1ZoDxNy94SAGZ/+WA5MsHWN7V/GeWObkH8LJZl7FCgBZvZvv8jz7//eP3tJ0OMF6wV4v5Seycvhvww6vPv/O7pxl0yVGfLHNyD+CbBOjkzWzHAJ0ZYCR5/eoNeqdvcjs8eXb1yQMsrzQ/GaZbInvB/GeXOb0H8OJZT2J1AJ28me0YoDMDjOd/bSfznz4+//QBllean4CzBOyStHj5triduFlPYqUkfTaDzgwwXrhXhw9eDkieeYDlleY/fJlBlx41ljlzD+C6APTFAcbvnH6Pr85/OiB55gGWV5qfZMeZurnwsX2HD87eA3jprItIdFBMJADFRAJQTCQAxUQCUEwkAMVEAlBMJADFRAJQTCQAxUQCUEwkAMVEAlBMJADFRAJQTCQAxUQCUEysHUDxL25f3O5w+OXBrMObv9D80vgKAkTi1XtCEoC+EAlAR2QgbXE+/cUHv/fB8nz/43v33vrDtz4COORk+/3/Q0BaILWznLAc1rnxS3bOj/UF6BCgkBfgvvgAh76D/x5/7Wf4cAHQ0cl/i39OJizm+uw7d4vQ2gJE3sewKBzyag/y5pPly08evwrQmQmLRW7+/P3zYm0BWh42/j3BYXngh68CdDphSUO3eIvMebHmAOH4T3DYuQig0wmHxzd//XMC6AYZdMextgCd4aCzVLNzFqCz5HQ84c5jbQE608W+1KxOwPn8J/fJiP+Hi+Z12sUIW9/l/qwfQEseeXBGB53IHUz62n//2s+Of77/hDwQ/Pde0UF328TWD6CYuOMmHh9fHYAWVLOUOq8zvjoALUrublv4VeIrBNCbiQSgmEgAiokEoJhInt2xiDcJ0L/8V9/4xi//8q/86q/+2je/+a1vffvXf/2dd77/gx/88Ifvvvfew4fvP3q0sbG5tbW9nUqnM9lsLpcvFIpFqlQqlyvVaq1WbzSazRZNMyxLnn4riKIURWG4eHCQ6zi2bZmmoeuapirKfD6TyXsyx+Q9a4NBv9/rdhdvgtnf29vdff7s2dOnn37yyccf/9M//uM//MPf/93f/b+//du/+Zv/+9d//Vd/lQCUAJQAlACUAJQAlACUAJQAlACUAJQAlACUAJQAlACUAJQAlACUAJQAlACUAJQAlAz7XCNutBuvb6G7mf82kQB0820lAMVsKwEoZlsJQDHbSgD6ykYCUEwkAMVEAlBMJADFRAJQTLwegMg9ph8uHoH8yp0Eh/fIbSjnTlo+2/S8KYt7Vp+cN4k8z/LBuQst7yZ7cP6WLo7XAhC5/YTczPX46y+f1Hocn/3rjxb3X5wz6Whxf8+5U44fg3vOpMf3n5BVnru6o4u3dHG8FoAOF9/2hy9++6OTB95+IfD5uZMOfwmfnDvl8YPj5b48iXx0/pTFx+RGqgt24qJ4bRxEbok7Pt4vxw6+9XMmff77/wOfnjvlPy5+P2fSyQOHz98SNnTRpAvjtQF0AQqET9766Nzd3nnw2QUAvfjt7947f6HD+3+2eBz7uVtaPDl4XQEid95etG9ghnMmvfjxk4sAIixDnil+DkDkiexvfXTBV0HSa00BWtwsedG+4bNzJj1eJsL1Fjpmu/MX2iHcvJ4ALe/cvhZJk/stEddkdvLrhe1gQe1rSdKkJEic02FJ4yXPBT+3+S7fYH+thQDCRb38+OHl69jmlzfqknuVX9VoO8vbcM+btAToegsdP/j8vIVOJMB5W7o4EqsREwlAMZEAFBMJQDGRABQTCUAxkQAUEwlAMZEAFBMJQDGRABQTCUAxkQAUEwlAMZEAFBMJQDGRABQTCUAxkQAUEwlAMZEAFBMJQDGRABQTCUAx8f8BMZnwbM1UEIgAAAAASUVORK5CYII=)
::::::::
:::::::::::::::::::

::::: {#discussion-of-the-results .section .level1}
# Discussion of the Results

The calculated indices provide a comprehensive view of drought
conditions in the region. NDVI indicates vegetation health, VCI and TCI
provide insights into vegetation and temperature conditions,
respectively, while PCI reflects precipitation levels. The SDCI
integrates these indices to give a standardized measure of drought
conditions.

:::: {#export-results .section .level2}
## Export Results

The results can be exported for further analysis and visualization:

::: {#cb14 .sourceCode}
``` {.sourceCode .r}
export_analysis_results_local(sdci, output_path)
#> [1] "C:\\Users\\hp\\AppData\\Local\\Temp\\RtmpuylSoT\\file2e701be62782.tif"
print(output_path)
#> [1] "C:\\Users\\hp\\AppData\\Local\\Temp\\RtmpuylSoT\\file2e701be62782.tif"
```
:::
::::
:::::

::: {#conclusion .section .level1}
# Conclusion

This vignette demonstrated how to use the `DroughtIndices` package to
calculate and analyze various drought indices from remote sensing data.
These indices are valuable tools for monitoring and assessing drought
conditions, supporting effective water management and mitigation
strategies.
:::
