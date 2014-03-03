### DAQ, data cleansing scenario

library(XML)
hkotables <- readHTMLTable("http://www.hko.gov.hk/wxinfo/pastwx/metob201312.htm", stringsAsFactors = FALSE)

hkotables[[1]]
hkotables[[8]]

nrow(hkotables[[8]])

sapply(hkotables, nrow) ### good table should be with the nrow around 30

meat <- hkotables[sapply(hkotables, nrow) > 30 & sapply(hkotables, nrow) < 40]

meat[[1]]


meat[[1]][,1]   
meat[[2]][,1]

### filter out rows with 1st column not in the 1-31

meat[[1]][,1] %in% seq(1, 31)

realmeat1 <- meat[[1]][meat[[1]][,1] %in% seq(1, 31),]

### change the col names
colnames(realmeat1) <- c("date", "pressure", "max.temp", "mean.temp", "min.temp", "dew.pt", "relHum", "cloud", "rainfall")
realmeat2 <- meat[[2]][meat[[2]][,1] %in% seq(1, 31),]
colnames(realmeat2) <- c("date", "reduced.vis", "sunshine", "sol.rad", "evapor", "wind.dir", "wind.speed")

realmeat2[,3] ### they are characters(strings)

## covert them to numbers

realmeat1[,2:8]

realmeat1[,2:8] <- apply(realmeat1[,2:8], 2, as.numeric)

realmeat2[,c(2,3,4,5,7)] <- apply(realmeat2[,c(2,3,4,5,7)], 2, as.numeric)

### I don't know how to code the "trace" rainfall and the winddir, just keep it string

### generate date seq

dateseq <- seq(from = as.Date("2013-12-01"), by = 1, length.out = 31)

### hackery

dateseq <- dateseq[1:nrow(realmeat1)]

### replace the first col with dateseq

realmeat1[,1] <- dateseq
realmeat2[,1] <- dateseq


### make the whole thing a function

HKOextract <- function(month, year) {
    fixedmonth <- sprintf("%02d", month)
    url <- paste0("http://www.hko.gov.hk/wxinfo/pastwx/metob", year, fixedmonth, ".htm")
    hkotables <- readHTMLTable(url, stringsAsFactors = FALSE)
    meat <- hkotables[sapply(hkotables, nrow) > 30 & sapply(hkotables, nrow) < 40]
    realmeat1 <- meat[[1]][meat[[1]][,1] %in% seq(1, 31),]
    colnames(realmeat1) <- c("date", "pressure", "max.temp", "mean.temp", "min.temp", "dew.pt", "relHum", "cloud", "rainfall")
    realmeat2 <- meat[[2]][meat[[2]][,1] %in% seq(1, 31),]
    colnames(realmeat2) <- c("date", "reduced.vis", "sunshine", "sol.rad", "evapor", "wind.dir", "wind.speed")
    realmeat1[,2:8] <- apply(realmeat1[,2:8], 2, as.numeric)
    realmeat2[,c(2,3,4,5,7)] <- apply(realmeat2[,c(2,3,4,5,7)], 2, as.numeric)
    dateseq <- seq(from = as.Date(paste0(year, "-", fixedmonth, "-01")), by = 1, length.out = 31)
    dateseq <- dateseq[1:nrow(realmeat1)]
    realmeat1[,1] <- dateseq
    realmeat2[,1] <- dateseq
    return(cbind(realmeat1, realmeat2[2:ncol(realmeat2)]))
}

require(plyr)

### lather, rinse, repeat

data2013 <- ldply(1:12, HKOextract, year = 2013, .progress = "text")
