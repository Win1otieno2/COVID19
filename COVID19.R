library(dplyr)
library(magrittr)
library(plyr)
library(ggplot2)

data <- read.csv("datafile.csv")

data$Day <- as.Date(data$Day)
mu <- ddply(data, "Country", summarise, grp.mean=mean(Value))

ggplot(data, aes(x=Day,y=Value)) + 
geom_line(aes(color = Country, group = 1)) + 
facet_grid(Country ~.) + geom_point() + 
labs(title="Covid-19 Daily Deaths 05-May-20",y= "Deaths", x = "Day - (by Winstan, Data Soure: World Health Organization - https://covid19.who.int/)") + 
scale_x_date(date_breaks = "2 day",date_labels = "%b %d") +
geom_hline(data=mu, aes(yintercept=grp.mean, color=Country),linetype="dashed")+
theme(legend.position="none",axis.title.x = element_text(size = 8),plot.title = element_text(size = 11, colour = "red")) +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
