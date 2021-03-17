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

#summary statistics for discrete variables
sort(table(df$Team))
sort(table(df$Opponent))
sort(table(df$Rank))
sort(table(df$Site))
sort(table(df$Tv))
sort(table(df$New.Coach))
sort(table(df$Tailgating))
sort(table(df$Opponent_Rank))
sort(table(df$Conference))
sort(table(df$Year))
sort(table(df$Month))
sort(table(df$Day))

#Correlation matrix for all continuous variables
copydf<-subset(df, select=c(Fill.Rate,precipitation,snow_in,snow_depth_in,temp_max_f,Attendance,
                            CurrentWins,Current.Losses,Stadium.Capacity,temp_min_f))
corr<-cor(copydf)
round(corr,2)
heatmap(corr)

#Data set graphical exploration
#distributions
hist(df$Attendance,breaks=25,col="blue")
plot(density(df$Attendance))#could not figure out how to put the kde on top of the histogram

SECdf<-df[which(df$Conference=='SEC'),]
B10df<-df[which(df$Conference=='Big-10'),]
PACdf<-df[which(df$Conference=='Pac-12'),]
B12df<-df[which(df$Conference=='Big-12'),]
ACCdf<-df[which(df$Conference=='ACC'),]

par(mfrow=c(3,2))
hist(SECdf$Attendance,breaks=25,col="green")
hist(B10df$Attendance,breaks=25,col="red")
hist(PACdf$Attendance,breaks=25,col="purple")
hist(B12df$Attendance,breaks=25,col="orange")
hist(ACCdf$Attendance,breaks=25,col="skyblue")

#Scatterplots
power5df<-df[which((df$Conference=='SEC')|
                   (df$Conference=='Big-10')|
                   (df$Conference=='Pac-12')|
                   (df$Conference=='Big-12')|
                   (df$Conference=='Acc')
                   ),]


Rankeddf<-power5df[which((power5df$Rank!='NR')&
                     (power5df$Opponent_Rank!='NR')
                   ),]
plot(Rankeddf$temp_max_f,Rankeddf$Attendance)#I couldn't figure out how to make the pairplot and the hue

plot(Rankeddf$Stadium.Capacity,Rankeddf$Attendance)

#barcharts
rankedChannels<-sort(table(Rankeddf$TV))
barplot(rankedChannels,xlab="Tv Channel",ylab="Number of Games on Channel",las=2)

times<-table(Rankeddf$Time)
barplot(times,xlab="Kickoff time of gameame",ylab='Amount of games kicked off at time',las=2)
barplot(times,las=2,xlab="Time of Kickoff",ylab="Amount of Games")

#Other plots
times<-table(df$Time)
plot(times,type="o",las=2,xlab="Time of Kickoff",ylab="Amount of Games")

#Overall, I will choose Python 9/10 over R