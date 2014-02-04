library(foreign)
library(ggplot2)

data <- read.dta("C:\\Users\\Robbie\\Documents\\PubPol 590 local\\raw_data_old.dta")

p <- ggplot(data=data, aes(x=H4PE35, fill=BIO_SEX))
p + geom_bar(position="dodge")
