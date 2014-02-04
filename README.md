# Hong Kong Open Source Conference - R workshop

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

### Cool, but how can I install a package.

Inside R

```{r}
install.packages("plyr")
```

### And how to use it?

```{r}
require(plyr)
# or library(plyr)
```

