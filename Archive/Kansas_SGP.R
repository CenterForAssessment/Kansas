###########################################################
###
### Kansas SGP Analysis
###
###########################################################

### Load SGP Package

require(SGP)
options(error=recover)


### Load data

load("Data/Kansas_Data_LONG.Rdata")


### Calculate SGPs

Kansas_SGP <- abcSGP(
		Kansas_Data_LONG,
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		save.intermediate.results=TRUE,
		sgPlot.demo.report=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=30, BASELINE_PERCENTILES=30, PROJECTIONS=14, LAGGED_PROJECTIONS=14, SUMMARY=30, GA_PLOTS=10, SG_PLOTS=1)))


### Save results

save(Kansas_SGP, file="Data/Kansas_SGP.Rdata")
