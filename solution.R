# RTFM

?mean
help.search("regex")

# singular / scaler

r <- 10
r^2 * 3.1416
r > 100

r <- TRUE
!r
r & FALSE
r & TRUE
r | FALSE

### string manipulation is a larger topic
r <- "hello"
r

# vector (array) and assignment

age <- c(21, 30, 40, 50, 60, 30, 50)
age
teenspirit <- c("An albino", "A mosquito", "My libido", "Yeah", "Hey", "kurt", "cobain")
teenspirit

NANDgatelogic <- c(TRUE, TRUE, FALSE)
NANDgatelogic

# vectorization

age / 10
age > 30 # generate a logical vector
age <= 30 & teenspirit == "An albino"

# indexing

age[1] ## start from 1, not 0
age[-1]
age[3]

# indexing and assignment

teenspirit[1]
teenspirit[1] <- "A mulatto"
teenspirit

# Quiz #1: Change the last two elements of the teenspirit vector to "courtney" and "love" 1 min
# hint: length(c(1,2,3)) will return 3

# operation on vector


mean(age)
sd(age)
min(age)
range(age)
cumsum(age)


# data frame: tabular spreadsheet-like data structure
# technically: list of vectors with equal length

gender <- c("M", "F", "M", "F", "F", "F", "M")
gender
participants <- data.frame(gender, age)
participants

# typical operations

head(participants, n = 3)
names(participants) #colnames(participants)
nrow(participants)
ncol(participants)

#data frame indexing: positional
participants$gender
participants[1,]
participants[,1]
participants[c(2,3),2]

#data frame indexing using logical vector

participants$gender == "M"

participants[participants$gender == "M",]

participants$age[participants$gender == "M"]

### Quiz #2: Calculation the mean age of Male and Female participants (1 min)

# mean(participants$age[participants$gender == "M"])
# mean(participants$age[participants$gender == "F"])

## creating new column (variable)

participants$age30 <- participants$age > 30

participants$height <- c(120,120,130,140,142,132,166)
participants

### Quiz #3: replace the height column in the participants from cm to inch
### hint: 1 inch = 2.54cm (2 mins)

### generation of data

seq(1,31)
rep(123, 3)
rep(c(1,2,3), 3)

### Quiz #4: generate a number sequence of

# c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5)
# Using a combination of seq() and rep()
# Hint: ?rep and look up for "each"

# 2 mins

# Ans: rep(seq(1,5), each = 4)


### Aim: Study the correlation between AQHI and visibility


### Quiz #5.1: read.csv()
### read csv file into a data.frame
### download the Jan csv file from
### http://www.aqhi.gov.hk/en/aqhi/statistics-of-aqhi/past-aqhi-records.html
### look at the help of read.csv
### and try

### rubbish <- read.csv("201401_Eng.csv", stringsAsFactors = FALSE)
### you can also use
### rubbish <- read.csv("http://www.aqhi.gov.hk/epd/ddata/html/history/2014/201401_Eng.csv", stringsAsFactors = FALSE)
### head(rubbish)

### describe what went wrong and diagnose the reason for this
### hints: you can use unix tools like head (3 mins)

### Quiz #5.2: how to solve it?
### read ?read.csv. Hints: skip (2 mins)

### Quiz #5.3: read in the data as a data frame called AQHIraw, look at the data and each group report one problem of the data. (3 mins)

AQHIraw <- read.csv("201401_Eng.csv", stringsAsFactors = FALSE, skip=7)

### data cleansing

## 1a. Removal of "*"
## 1b. Change 10+ to 11
## 2. Date

### removal of *
KT <- AQHIraw$Kwun.Tong

KT

### Quiz 6.1: look up gsub and try to remove "*" in "4*"
### hint: use escape characters for the regex

KT <- gsub("\\*", "", KT)

### Quiz 6.2: change "10+" to "11" using vector selection and subsitution operations
KT[KT == "10+"] <- "11"

### function definition

cleansing <- function(dirtyaqhi) {
    cleanaqhi <- gsub("\\*", "", dirtyaqhi)
    return(cleanaqhi)
}

KT <- AQHIraw$Kwun.Tong
cleansing(KT)

### Quiz 6.3: modify cleansing so that it will also change 10+ to 11

cleansing <- function(dirtyaqhi) {
    dirtyaqhi[dirtyaqhi == "10+"] <- "11"
    cleanaqhi <- gsub("\\*", "", dirtyaqhi)
    return(cleanaqhi)
}

### class of data
cleanKT <- cleansing(KT)
class(cleanKT)
mean(cleanKT)

cleanKTnum <- as.numeric(cleanKT)
class(cleanKTnum)
mean(cleanKTnum)

### Quiz 6.4: further modify cleansing so that it will return a numeric vector
### test with
# mean(cleansing(AQHIraw$Kwun.Tong))

cleansing <- function(dirtyaqhi) {
    dirtyaqhi[dirtyaqhi == "10+"] <- "11"
    cleanaqhi <- gsub("\\*", "", dirtyaqhi)
    return(as.numeric(cleanaqhi))
}



head(AQHIraw)

AQHIraw[1:5,3:17]

apply(AQHIraw[1:5,3:17], 2, cleansing) ### applying the cleansing function across columns

### concept of higher order function
### function that take another function as argument

### Quiz 7: replace column 3 to 17 in the AQHIraw with the cleansed version
### test with

# mean(AQHIraw[,3])
# ?mean for na.rm and try
# mean(AQHIraw[,6], na.rm=TRUE)

AQHIraw[,3:17] <- apply(AQHIraw[,3:17], 2, cleansing)

### Quiz 7.1: calculate the mean score for each region
### the meaning of ... in apply is the additional argument what will be passed to FUN

apply(AQHIraw[,3:17], 2, mean, na.rm=TRUE)

### Quiz 7.2: which region have the higest mean AQHI?
### hint: ?rank or ?order

rank(apply(AQHIraw[,3:17], 2, mean, na.rm=TRUE))


### Quiz 7.3: consult ?apply and explain what is going on with:

apply(AQHIraw[, 3:17], 1, mean, na.rm = TRUE)

### Quiz 7.4: put the result from the above command to the AQHIraw data.frame as aqhi and change AQHIraw to AQHI

AQHIraw$aqhi <- apply(AQHIraw[, 3:17], 1, mean, na.rm = TRUE)
AQHI <- AQHIraw

### basic plotting
plot(AQHI$aqhi)
plot(AQHI$aqhi, type = "l")

### concept of SAC
# Split
# Apply
# combine

### calculate the hourly mean aqhi

require(plyr)
hourlyaqhi <- ddply(AQHI, .(Hour), summarize, meanAQHI = mean(aqhi))
hourlyaqhi

### (split) the data by Hour and (apply) the mean function to calculate the meanaqhi, and (combine) the final result into a data frame.

# ddply = input is data.frame and output is also a data.frame

plot(hourlyaqhi$Hour, hourlyaqhi$meanAQHI, type = "l")
plot(hourlyaqhi$Hour, hourlyaqhi$meanAQHI, type = "l", xlab = "Hour", ylab = "mean AQHI")


### Quiz 8: major one
### calculate the daily mean AQHI using ddply and plot it as a graph
### You cannot use Date
### refer to Quiz 3 on how to generate date sequence with repeat

AQHI$day <- rep(seq(1,31), each = 24)

dailyaqhi <- ddply(AQHI, .(day), summarize, meanAQHI = mean(aqhi))

### Let's try

dailyaqhi <- ddply(AQHI, .(day), summarize, meanAQHI = mean(aqhi), medianAQHI = median(aqhi))

plot(dailyaqhi$day, dailyaqhi$meanAQHI, type ="l", xlab = "day", ylab = "AQHI")
lines(dailyaqhi$day, dailyaqhi$medianAQHI, col = "red")

### Quiz 9: Read in the jan_weather.csv and plot the meanAQHI and reduced.vis
### google for how to use ylim

weather <- read.csv("jan_weather.csv")
plot(dailyaqhi$day, dailyaqhi$meanAQHI, type ="l", xlab = "day", ylab = "AQHI", ylim=c(0, 24))
lines(weather$reduced.vis, col = "red")

### Quiz 10: calculate the correlation between reduced.vis and meanAQHI
### hint: ?cor

cor(dailyaqhi$meanAQHI, weather$reduced.vis)


### home assignment

#?abline
#?lm

### plot this:

pdf("corAQHIvis.pdf")
plot(dailyaqhi$meanAQHI, weather$reduced.vis, xlab = "mean AQHI", ylab = "Reduced Vis.")
abline(lm(weather$reduced.vis~dailyaqhi$meanAQHI))
dev.off()
