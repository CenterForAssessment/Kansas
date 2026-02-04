###################################################################
### Kansas SGP Analysis - 2025
###################################################################

### Load required libraries
library(data.table)
library(SGP)

### Load Kansas data
load("Data/Kansas_SGP.Rdata")
load("Data/Kansas_Data_LONG.Rdata")
Kansas_Data_LONG_2025 <- Kansas_Data_LONG[YEAR == "2025"]

### Source configurations
source("SGP_CONFIG/2025/MATHEMATICS.R")
source("SGP_CONFIG/2025/ELA.R")
KS_2025.config <- c(MATHEMATICS_2025.config, ELA_2025.config)

### Calculate SGPs
Kansas_SGP <- updateSGP(
    what_sgp_object=Kansas_SGP,
    with_sgp_data_LONG=Kansas_Data_LONG_2025,
    state="KS",
    steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
    sgp.percentiles=TRUE,
    sgp.projections=FALSE,
    sgp.projections.lagged=FALSE,
    sgp.percentiles.baseline=FALSE,
    sgp.projections.baseline=FALSE,
    sgp.projections.lagged.baseline=FALSE,
    sgp.config=KS_2025.config)

### Save results
save(Kansas_SGP, file="Data/Kansas_SGP.Rdata")