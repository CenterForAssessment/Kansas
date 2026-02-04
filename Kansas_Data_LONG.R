################################################################################
### Data loading and preparation for Kansas
################################################################################

# Load libraries
require(data.table)
require(SGP)
require(foreign)

# Load source data set
if (!exists("Kansas_Data_LONG")) {
  Kansas_Data_LONG <- as.data.table(read.spss("Data/Base_Files/LongData2016-2025.sav", to.data.frame = TRUE))
}

# Tidy up data
setnames(Kansas_Data_LONG, c("VALID_CASE", "ID", "YEAR", "DISTRICT_NUMBER", "SCHOOL_NUMBER", "GRADE", "AYP_SUBJECT_ID", "CONTENT_AREA", "SCALE_SCORE", "ACHIEVEMENT_LEVEL_NUMBER", "ACHIEVEMENT_LEVEL", "API", "API_CATEGORY"))
Kansas_Data_LONG[,VALID_CASE:=as.character(VALID_CASE)][, VALID_CASE:="VALID_CASE"]
Kansas_Data_LONG[,ID:=as.character(ID)][, ID:=strTail(paste0("000000", ID), 7)]
Kansas_Data_LONG[,GRADE:=as.character(GRADE)]
Kansas_Data_LONG[,AYP_SUBJECT_ID:=NULL]
Kansas_Data_LONG[,CONTENT_AREA:=as.factor(CONTENT_AREA)]
setattr(Kansas_Data_LONG$CONTENT_AREA, "levels", c("ELA", "MATHEMATICS"))
Kansas_Data_LONG[,CONTENT_AREA:=as.character(CONTENT_AREA)]
Kansas_Data_LONG[,ACHIEVEMENT_LEVEL_NUMBER:=NULL]
Kansas_Data_LONG[,ACHIEVEMENT_LEVEL:=as.factor(ACHIEVEMENT_LEVEL)]
setattr(Kansas_Data_LONG$ACHIEVEMENT_LEVEL, "levels", c("Academic Warning", "Approaching Standard", "Approaching Standard", "Exceeds Standard", "Meets Standard", "Not Tested"))
Kansas_Data_LONG[,ACHIEVEMENT_LEVEL:=as.character(ACHIEVEMENT_LEVEL)]

### Setkey and save data (NOTE: No duplicates in this data set)
setkeyv(Kansas_Data_LONG, c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID"))
save(Kansas_Data_LONG, file="Data/Kansas_Data_LONG.Rdata")

###################################################################################
### Create knots/boundaries for SGPstateData
###################################################################################

KS_Knots_Boundaries <- SGP::createKnotsBoundaries(Kansas_Data_LONG[VALID_CASE=="VALID_CASE" & YEAR < "2025" & YEAR != "2021"])
KS_Knots_Boundaries_2025 <- SGP::createKnotsBoundaries(Kansas_Data_LONG[VALID_CASE=="VALID_CASE" & YEAR == "2025"])
names(KS_Knots_Boundaries_2025) <- c("ELA.2025", "MATHEMATICS.2025")
save(KS_Knots_Boundaries, file="/Users/conet/GitHub/DBetebenner/SGPstateData/master/Knots_Boundaries/KS_Knots_Boundaries.Rdata")
save(KS_Knots_Boundaries_2025, file="/Users/conet/GitHub/DBetebenner/SGPstateData/master/Knots_Boundaries/KS_Knots_Boundaries_2025.Rdata")