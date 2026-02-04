###################################################################
### Kansas SGP Analysis - 2024
###################################################################

### Load required libraries
library(data.table)
library(SGP)

### Load Kansas data
load("Data/Kansas_Data_LONG.Rdata")
Kansas_Data_LONG <- Kansas_Data_LONG[YEAR <= "2024"]

### Source configurations
source("SGP_CONFIG/2024/MATHEMATICS.R")
source("SGP_CONFIG/2024/ELA.R")
KS_2024.config <- c(MATHEMATICS_2024.config, ELA_2024.config)

### Calculate SGPs
Kansas_SGP <- abcSGP(
    sgp_object=Kansas_Data_LONG,
    state="KS",
    steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
    sgp.percentiles=TRUE,
    sgp.projections=FALSE,
    sgp.projections.lagged=FALSE,
    sgp.percentiles.baseline=FALSE,
    sgp.projections.baseline=FALSE,
    sgp.projections.lagged.baseline=FALSE,
    sgp.config=KS_2024.config)

### Save results
save(Kansas_SGP, file="Data/Kansas_SGP.Rdata")
