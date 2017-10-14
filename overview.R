#import source data file
setwd("/Users/sethmoore/Google Drive/Research/Tuition : Federal Aid")
library(gdata)
library(dplyr)
compiled_data <- read.xls("Compiled Data.xlsx", header = TRUE)

# Correlations of a few key indicators
enrollment_v_aid <- cor(compiled_data$Total.Enrollment, compiled_data$Aid.per.Student)
enrollment_v_tuition <- cor(compiled_data$Total.Enrollment, compiled_data$Tuition.and.required.fees..All.insti.tutions)

# create new column "decade" so we can group by the decade
compiled_data <- mutate(compiled_data, decade = ifelse(Year < 1980, "seventies", ifelse(Year < 1990, "eighties", ifelse(Year < 2000, "ninties", ifelse(Year < 2200, "two_thousands")))))

# group by our newly minted decade column and run our correlations again
correlation_by_decade <- summarise(group_by(compiled_data, decade), enrollment_v_aid = cor(Total.Enrollment, Aid.per.Student), enrollment_v_tuition = cor(Total.Enrollment, Tuition.and.required.fees..All.insti.tutions),
                                   aid_v_tuition = cor(Aid.per.Student, Tuition.and.required.fees..All.insti.tutions))

#export data
write.csv(correlation_by_decade, file = "correlations_by_decade.csv")
