## Checking multicollinearity of data
library("raster")

bio1 <- raster("bio_1.asc")
bio2 <- raster("bio_2.asc")
bio3 <- raster("bio_3.asc")
bio4 <- raster("bio_4.asc")
bio5 <- raster("bio_5.asc")
bio6 <- raster("bio_6.asc")
bio7 <- raster("bio_7.asc")
bio8 <- raster("bio_8.asc")
bio9 <- raster("bio_9.asc")
bio10 <- raster("bio_10.asc")
bio11 <- raster("bio_11.asc")
bio12 <- raster("bio_12.asc")
bio13 <- raster("bio_13.asc")
bio14 <- raster("bio_14.asc")
bio15 <- raster("bio_15.asc")
bio16 <- raster("bio_16.asc")
bio17 <- raster("bio_17.asc")
bio18 <- raster("bio_18.asc")
bio19 <- raster("bio_19.asc")


layers.stack <- raster::stack(bio1, bio2, bio3, bio4, bio5, bio6, bio7, bio8, bio9, bio10, bio11, bio12, bio13, bio14, bio15, bio16, bio17, bio18, bio19)

## Now you can resample your rasters to be exactly like your target raster
bio1b <- resample(bio1,bio2)
bio2b <- resample(bio2, bio2)
bio3b <- resample(bio3, bio2)
bio4b <- resample(bio4, bio2)
bio5b <- resample(bio5, bio2)
bio6b <- resample(bio6, bio2)
bio7b <- resample(bio7, bio2)
bio8b <- resample(bio8, bio2)
bio9b <- resample(bio9, bio2)
bio10b <- resample(bio10, bio2)
bio11b <- resample(bio11, bio2)
bio12b <- resample(bio12, bio2)
bio13b <- resample(bio13, bio2)
bio14b <- resample(bio14, bio2)
bio15b <- resample(bio15, bio2)
bio16b <- resample(bio16, bio2)
bio17b <- resample(bio17, bio2)
bio18b <- resample(bio18, bio2)
bio19b <- resample(bio19, bio2)

stack.rasters <- stack(bio1b, bio2b, bio3b, bio4b, bio5b, bio6b, bio7b, bio8b, bio9b, bio10b, bio11b, bio12b, bio13b, bio14b, bio15b, bio16b, bio17b, bio18b, bio19b)

# Define a custom function to calculate Pearson correlation
custom_corr <- function(x) {
  cor_matrix <- cor(x, use = "pairwise.complete.obs")
  return(cor_matrix[1, 2])  # Return the correlation coefficient of interest
}

# Calculate Pearson correlations between the layers in the raster stack
corr <- raster::layerStats(layers.stack, 'pearson', na.rm = TRUE)

write.csv(correlations, "correlations.csv")

# Calculate Pearson correlations between the layers in the raster stack
corr <- raster::layerStats(layers.stack, 'pearson', na.rm = TRUE)

# Write the correlations to a CSV file
write.csv(corr, "correlations.csv")
# Write the resampled raster to a file
writeRaster(bio1b, filename = "bio1b.asc", overwrite = TRUE)
writeRaster(bio2b, filename = "bio2b.asc", overwrite = TRUE)
writeRaster(bio3b, filename = "bio3b.asc", overwrite = TRUE)
writeRaster(bio4b, filename = "bio4b.asc", overwrite = TRUE)
writeRaster(bio5b, filename = "bio5b.asc", overwrite = TRUE)
writeRaster(bio6b, filename = "bio6b.asc", overwrite = TRUE)
writeRaster(bio7b, filename = "bio7b.asc", overwrite = TRUE)
writeRaster(bio8b, filename = "bio8b.asc", overwrite = TRUE)
writeRaster(bio9b, filename = "bio9b.asc", overwrite = TRUE)
writeRaster(bio10b, filename = "bio10b.asc", overwrite = TRUE)
writeRaster(bio11b, filename = "bio11b.asc", overwrite = TRUE)
writeRaster(bio12b, filename = "bio12b.asc", overwrite = TRUE)
writeRaster(bio13b, filename = "bio13b.asc", overwrite = TRUE)
writeRaster(bio14b, filename = "bio14b.asc", overwrite = TRUE)
writeRaster(bio15b, filename = "bio15b.asc", overwrite = TRUE)
writeRaster(bio16b, filename = "bio16b.asc", overwrite = TRUE)
writeRaster(bio17b, filename = "bio17b.asc", overwrite = TRUE)
writeRaster(bio18b, filename = "bio18b.asc", overwrite = TRUE)
writeRaster(bio19b, filename = "bio19b.asc", overwrite = TRUE)

# Assuming your bioclimatic variables are stored in a data frame called 'bioclim_data'
correlation_matrix <- cor(bioclim_data)
# Set the correlation threshold
threshold <- 0.7

# Identify correlated variable pairs
correlated_pairs <- which(custom_corr > threshold & correlation_matrix < 1, arr.ind = TRUE)
# Create a list of variable names to keep (remove one from each correlated pair)
variables_to_keep <- colnames(bioclim_data)[-unique(correlated_pairs[, 2])]

# Create a new data frame with correlated variables removed
bioclim_data_filtered <- bioclim_data[, variables_to_keep]


