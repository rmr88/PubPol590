library(foreign)
library(ggplot2)

#Read in full dataset
data <- read.dta("C:\\Users\\Robbie\\Documents\\PubPol590\\R_files\\clean_data_old.dta")
data_sub = subset(x = data, subset = !is.na(insurance_status),
  select = c(insurance_status))
data_sub <- within(data_sub, insurance_status <- factor(insurance_status, 
  levels=names(sort(table(insurance_status), decreasing=FALSE))))

p <- ggplot(data=data_sub, aes(x=insurance_status))
require(scales)
p + geom_bar(aes(y = (..count..))) + 
  geom_text(aes(y = (..count..)/sum(..count..))) +
  scale_y_continuous(labels = percent_format()) + coord_flip()


#Uninsured
data_sub = subset(x = data, subset = !is.na(noins_no_offer) & !is.na(noins_denied)
                  & !is.na(noins_dont_want) & !is.na(noins_expensive),
                  select = c(noins_no_offer, noins_dont_want, noins_expensive,
                             noins_denied))
data_sub <- as.data.frame(table(data_sub))
p <- ggplot(data = data_sub, )
#Bike Helmets data frame
data_sub <- subset(x = data, select = c(insurance_status, helmet_bike), 
                   subset = !is.na(insurance_status) & !is.na(helmet_bike) & 
                     (insurance_status == "You get insurance through work" |
                        insurance_status == "You have no health insurance"))