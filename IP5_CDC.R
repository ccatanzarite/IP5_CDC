#import packages
library(datasets)
library(tidyverse)
library(psych)

#Beginning the exploration
df<-read.csv("CFBattendance.csv")
head(df)
names(df)[names(df) == "PRCP"] <- "precipitation"
names(df)[names(df) == "SNWD"] <- "snow_depth_in"
names(df)[names(df) == "TMAX"] <- "temp_max_f"
names(df)[names(df) == "TMIN"] <- "temp_min_f"
names(df)[names(df) == "SNOW"] <- "snow_in"
str(df)

#Summary statistics for continuous variables
describe(df["Attendance"])
describe(df["CurrentWins"])
describe(df["Current.Losses"])
describe(df["Stadium.Capacity"])
describe(df["Fill.Rate"])
describe(df["precipitation"])
describe(df["snow_in"])
describe(df["snow_depth_in"])
describe(df["temp_max_f"])
describe(df["temp_min_f"])

