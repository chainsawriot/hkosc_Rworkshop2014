# Hong Kong Open Source Conference - 2014 R workshop

## Target audience

those who are interested in data analysis but with very little experience in R.

## Learning outcomes

1. how to work with the most important R data structures: vector and data frame
2. how to get data into R from common sources such as csv files
3. how to make data analysable
4. master the SAC (split-apply-combine) strategy to work with data
5. basic of data viz

## This course will not teach you

1. Big data
2. Machine learning (or any advance stat)
3. Grammar of graphics
4. GIS

## Preparation

1. Install R on your computer
2. Use your own text editor
3. Install some recommended R packaes

## R installation

### Linux

The easiest way is to your package management, may not be the most update version

```{bash}
sudo apt-get install r-base-dev
```

If you need the most updated version, there is a [deb source](http://cran.r-project.org/bin/linux/ubuntu/README.html) for that.

### Mac OS X

Download the latest version of binary from any cran mirror, such as [r-studio](http://cran.rstudio.com/bin/macosx/).

Install the binary by double click it, and [there's no step three](http://www.youtube.com/watch?v=6uXJlX50Lj8).

### Windows

I can only provide you with [this link](http://cran.rstudio.com/bin/windows/), limited support can be provided, sorry.

## Your text editor (Your mileage may vary)

Yeah, you can use your own text editor but you will definitely get better productivity with either

1. emacs + ess
2. R studio

They are cross platform. Your instructor will use the above two.

Mac OS X binary come with decent code editor. Windows version, well... it has a code editor but you know...

## Required external R packages

1. plyr
2. plyr
3. plyr

### Cool, but how can I install package?

Inside R

```r
install.packages("plyr")
```

### And how to use it?

```s
require(plyr)
# or library(plyr)
```

