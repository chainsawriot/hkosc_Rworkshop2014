# hello

# Strengths

## data frame
## data vis
## packages
## free?

# Oddities

## <- assignment
## loop function
## verbosity, compare to Matlab / SAS / Python

# Basic concepts

# RTFM

?mean
help.search("regex")

# I believe in demo rather than lecture.

# vector (array) and assignment

age <- c(21, 30, 40, 50, 60, 30, 50)
age
teenspirit <- c("kurt", "An albino", "A mosquito", "My libido", "Yeah", "Hey")
teenspirit

NANDgatelogic <- c(TRUE, TRUE, FALSE)
NANDgatelogic

# vectorization

age / 10
age > 30 # generate a logical vector

# indexing

age[1] ## start from 1, not 0
age[-1]
age[3]

# indexing and assignment

teenspirit[1]
teenspirit[1] <- "A mulatto"
teenspirit

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

head(participants)
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

mean(participants$age[participants$gender == "M"])
mean(participants$age[participants$gender == "F"])

## creating new column (variable)
participants$age30 <- participants$age > 30

participants$height <- c(120,120,130,140,142,132,166)
participants

## statistical analysis

htmodel <- lm(height~age+gender, data=participants)
summary(htmodel)

t.test(height~age30, data=participants)

## graphing

plot(participants$age, participants$height)
abline(lm(height~age, data=participants))

# packages management
## install.packages("plyr") ### from CRAN
## library(plyr)

## reading data from external source
## R data I/O manual: http://cran.r-project.org/doc/manuals/r-release/R-data.html

# Economic Journal Dataset: http://vincentarelbundock.github.io/Rdatasets/doc/Ecdat/Journals.html

econ <- read.csv("http://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/Journals.csv")

# Inspection

head(econ)
colnames(econ)
nrow(econ)
hist(econ$oclc)

# for loop

unique(econ$society)

## calculate the mean oclc for each category of journals

meanoclc <- c()
for (i in unique(econ$society)) {
    meanoclc[i] <- mean(econ$oclc[econ$society == i])
}
meanoclc

# R way of doing this: loop-function

# tapply(X=econ$oclc, INDEX=econ$society, FUN=mean)
tapply(econ$oclc, econ$society, FUN=mean)

### the syntax to create a function

# meansd <- function(x) {
#    paste0(round(mean(x), 2), " (", round(sd(x), 2), ")")
# }

# lambda (anonymous) function

tapply(econ$oclc, econ$society, FUN=function(x) {paste0(round(mean(x), 2), " (", round(sd(x), 2), ")")})

### do the actual analysis: the determinants of lib subs

#correlation between no of lib subs and pages
cor(econ$oclc, econ$pages)
plot(econ$pages, econ$oclc, xlab="No. of pages", ylab="Libray subscriptions")

# log scaled x and y
plot(econ$pages, econ$oclc, xlab="No. of pages (log)", ylab="Libray subscriptions (log)", log="xy")

# citations
hist(econ$citestot)
plot(econ$citestot, econ$oclc, xlab="No. of citations", ylab="Libray subscriptions")
plot(econ$citestot, econ$oclc, xlab="No. of citations (log)", ylab="Libray subscriptions (log)", log="xy")

# which one is the determinant of lib subs

econ.m1 <- lm(log(oclc)~log(pages), data=econ)
summary(econ.m1)

econ.m2 <- lm(log(oclc)~log(pages)+log(citestot), data=econ)
summary(econ.m2)

plot(log(econ$citestot), log(econ$pages))

### check regression assumptions: LINE

### L(inearity)

plot(predict(econ.m2), log(econ$oclc))

### I(ndependence of error)

acf(residuals(econ.m2), lag.max=50)

### N(ormality of error)

par(mfrow=c(1,2))
qqnorm(residuals(econ.m2))
qqline(residuals(econ.m2))
hist(residuals(econ.m2))

### Homogeneity of (E)rror - homoscedasticity

plot(predict(econ.m2), residuals(econ.m2))
abline(h=0)
abline(h=-1.96, lty=2)
abline(h=+1.96, lty=2)

### Actually, the build-in plot.lm()
par(mfrow=c(2,2))
plot(econ.m2, ask=FALSE)


### Extra analysis you can try yourself.

# oclc is actually a count, negative binomial regression might be better.

require(MASS)

econ.m3 <- glm.nb(oclc~log(pages)+log(citestot), data=econ)
summary(econ.m3) # count based model, similar conclusion
plot(log(predict(econ.m3, type="response")), log(econ$oclc))


# which model is better?

## RMS accuary

RMSe <- function(x, y) {
    return(sqrt(mean((x - y)^2, na.rm=TRUE)))
}

## property of RMS Error
RMSe(c(1,2,3,4), c(1,2,3,4))

RMSe(c(1,2,3,4), c(9,2,0,200))

RMSe(c(1,2,3,4), c(0.7,1.9,2.8,3.7)) ## always positive


## accuracy comparison

RMSe(exp(predict(econ.m2)), econ$oclc)
RMSe(predict(econ.m3, type="response"), econ$oclc) ### count model has a slightly better accuracy.

