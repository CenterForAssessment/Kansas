##############################################
###
### Script for preparing Kansas_Data_LONG
###
##############################################

### Load packages

require(SGP)
require(foreign)


### Load data

Kansas_Data_LONG <- read.spss("Data/Base_Files/Kansas_25_Percent_Sample_Data.sav", to.data.frame=TRUE, use.value.labels=TRUE)


### Tidy up variables

names(Kansas_Data_LONG)[1] <- "ID"
Kansas_Data_LONG$ID <- as.character(Kansas_Data_LONG$ID)

Kansas_Data_LONG$YEAR <- as.character(Kansas_Data_LONG$YEAR)

levels(Kansas_Data_LONG$CONTENT_AREA) <- gsub(' +$', '', levels(Kansas_Data_LONG$CONTENT_AREA))
Kansas_Data_LONG$CONTENT_AREA <- as.character(Kansas_Data_LONG$CONTENT_AREA)

Kansas_Data_LONG$GRADE <- as.integer(as.character(Kansas_Data_LONG$GRADE))
Kansas_Data_LONG$GRADE[Kansas_Data_LONG$GRADE==9] <- 11L

levels(Kansas_Data_LONG$ACHIEVEMENT_LEVEL) <- c("Academic Warning (Unsatisfactory)", "Approaching Standard (Basic)", "Exceeds Standard (Advanced)", "Exemplary", 
	"Meets Standard (Proficient)", "Not Tested or Missing")
ordered.levels <- c("Academic Warning (Unsatisfactory)", "Approaching Standard (Basic)", "Meets Standard (Proficient)", "Exceeds Standard (Advanced)", "Exemplary", "Not Tested or Missing")
Kansas_Data_LONG$ACHIEVEMENT_LEVEL <- factor(Kansas_Data_LONG$ACHIEVEMENT_LEVEL, levels=ordered.levels, ordered=TRUE)

levels(Kansas_Data_LONG$FIRST_NAME) <- gsub(' +$', '', levels(Kansas_Data_LONG$FIRST_NAME))
Kansas_Data_LONG$FIRST_NAME[Kansas_Data_LONG$FIRST_NAME==""] <- NA
Kansas_Data_LONG$FIRST_NAME <- factor(Kansas_Data_LONG$FIRST_NAME)
levels(Kansas_Data_LONG$FIRST_NAME) <- sapply(levels(Kansas_Data_LONG$FIRST_NAME), capwords)

levels(Kansas_Data_LONG$LAST_NAME) <- gsub(' +$', '', levels(Kansas_Data_LONG$LAST_NAME))
levels(Kansas_Data_LONG$LAST_NAME) <- sapply(levels(Kansas_Data_LONG$LAST_NAME), capwords)

levels(Kansas_Data_LONG$DISTRICT_NAME) <- gsub(' +$', '', levels(Kansas_Data_LONG$DISTRICT_NAME))
levels(Kansas_Data_LONG$DISTRICT_NAME) <- sapply(levels(Kansas_Data_LONG$DISTRICT_NAME), capwords)

levels(Kansas_Data_LONG$SCHOOL_NAME) <- gsub(' +$', '', levels(Kansas_Data_LONG$SCHOOL_NAME))
levels(Kansas_Data_LONG$SCHOOL_NAME) <- sapply(levels(Kansas_Data_LONG$SCHOOL_NAME), capwords)

Kansas_Data_LONG$EMH_LEVEL <- factor(Kansas_Data_LONG$EMH_LEVEL, levels=c(0,2,3,4,7), labels=c("Central Office", "High School", "Junior High School", "Elementary School", "Middle School"))

levels(Kansas_Data_LONG$GENDER) <- gsub(' +$', '', levels(Kansas_Data_LONG$GENDER))

levels(Kansas_Data_LONG$ETHNICITY) <- gsub(' +$', '', levels(Kansas_Data_LONG$ETHNICITY))
Kansas_Data_LONG$ETHNICITY[Kansas_Data_LONG$ETHNICITY==""] <- NA
Kansas_Data_LONG$ETHNICITY <- factor(Kansas_Data_LONG$ETHNICITY)
levels(Kansas_Data_LONG$ETHNICITY) <- c("African American", "American Indian", "Asian", "Hispanic", "Multi Race", "NHPI", "White")

levels(Kansas_Data_LONG$FR_LUNCH_STATUS) <- c("Free/Reduced Price Lunch: No", "Free/Reduced Price Lunch: Yes") 
levels(Kansas_Data_LONG$IEP_STATUS) <- c("IEP: No", "IEP: Yes") 
levels(Kansas_Data_LONG$ELL_STATUS) <- c("ELL: No", "ELL: Yes") 
levels(Kansas_Data_LONG$GT_STATUS) <- c("Gifted and Talented Status: No", "Gifted and Talented Status: Yes") 
Kansas_Data_LONG$VALID_CASE <- factor(Kansas_Data_LONG$VALID_CASE, levels=c("INVALID_CASE", "VALID_CASE"))
Kansas_Data_LONG$VALID_CASE <- as.character(Kansas_Data_LONG$VALID_CASE)

Kansas_Data_LONG$SCHOOL_ENROLLMENT_STATUS <- factor(1, levels=1:2, labels=c("Enrolled School: Yes", "Enrolled School: No"))
Kansas_Data_LONG$DISTRICT_ENROLLMENT_STATUS <- factor(1, levels=1:2, labels=c("Enrolled District: Yes", "Enrolled District: No"))
Kansas_Data_LONG$STATE_ENROLLMENT_STATUS <- factor(1, levels=1:2, labels=c("Enrolled State: Yes", "Enrolled State: No"))

### Mark INVALID cases

#Kansas_Data_LONG$VALID_CASE[!Kansas_Data_LONG$GRADE %in% 3:8] <- "INVALID_CASE"
Kansas_Data_LONG$VALID_CASE[Kansas_Data_LONG$EMH_LEVEL=="Central Office"] <- "INVALID_CASE"
Kansas_Data_LONG <- as.data.table(Kansas_Data_LONG)
setkeyv(Kansas_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(Kansas_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
invisible(Kansas_Data_LONG[which(duplicated(Kansas_Data_LONG))-1, VALID_CASE := "INVALID_CASE"])


### Save results

Kansas_Data_LONG <- as.data.frame(Kansas_Data_LONG)
save(Kansas_Data_LONG, file="Data/Kansas_Data_LONG.Rdata")
