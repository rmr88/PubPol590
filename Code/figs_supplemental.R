### Supplemental Figures ###

#setwd("~/PubPol590")

#Libraries
library(ggplot2)
library(dplyr, warn.conflicts=FALSE)
library(RColorBrewer)
library(grid)
library(gridExtra)
library(scales)
library(reshape2)

#Themes
bar.theme <- theme_bw() + theme(panel.grid.major.y=element_blank(), 
	panel.grid.major.x=element_line(color="gray80"),
	panel.border=element_blank(),
	axis.title.x=element_text(vjust=-0.2),
	axis.title.y=element_blank(),
	axis.ticks.x=element_blank(),
	axis.ticks.y=element_blank(),
	axis.line.y=element_line(color="black"),
	plot.title=element_text(vjust=1.05),
	plot.margin=unit(c(0.5,0,0.8,0), "lines"),
	legend.position="none")
bar.theme.vert <- theme_bw() + theme(panel.grid.major.x=element_blank(), 
	panel.grid.major.y=element_line(color="gray80"),
	panel.border=element_blank(),
	axis.ticks.x=element_blank(),
	axis.ticks.y=element_blank(),
	axis.title.x=element_blank(),
	axis.title.y=element_text(vjust=0.2),
	axis.line.y=element_line(color="black"),
	plot.title=element_text(vjust=1.05),
	plot.margin=unit(c(0.5,0,0,0.8), "lines"),
	legend.position="none")
limits <- aes(ymax=mean+se, ymin=mean-se, width=0.25)
scale <- scale_fill_manual(name="Insurance Status:",
	values=c("Insured"="dodgerblue1",
		"Voluntary Uninsured"="firebrick1",
		"Non-voluntary Uninsured"="green4"))
dodge <- position_dodge(width=0.9)
ivtab <- read.csv("Descriptives\\tab_demog.csv")

#Injury
injury <- read.csv("Descriptives\\tab_injury.csv")
n <- injury$Variable
injury <- as.data.frame(t(injury[,-1]))
colnames(injury) <- n
injury <- as.data.frame(
	cbind(injury, id=c(1,2,3,1,2,3,1,2,3,1,2,3,0),
		cat=rep(c("I","V","U","O","x"), times=c(3,3,3,3,1))))
injury <- reshape(filter(injury, id!=0), v.names="injury_past12", timevar="cat",
	idvar="id", direction="wide")
injury <- as.data.frame(t(select(injury, injury_past12.I, injury_past12.V, injury_past12.U)))
colnames(injury) <- c("mean","sd","N")
injury <- as.data.frame(cbind(injury,
	cat=c("Insured","Voluntary Uninsured",
		"Non-voluntary Uninsured"),
	se=injury$sd / sqrt(injury$N)))

p <- ggplot(injury, aes(x=cat, y=mean, fill=cat))
injury_fig <- p + geom_bar(stat="identity") + geom_errorbar(limits) +
	labs(y="Percent with Injury in Past Year",
		title="Recent Major Injuries by Insurance Status") +
	bar.theme.vert + scale + scale_y_continuous(labels=percent)
ggsave(injury_fig, filename="Descriptives\\supplemental\\injury_fig.png",
	width=8, height=5, units="in")

#Gender
gender <- filter(ivtab, Variable=="male")
n <- gender$Variable
gender <- as.data.frame(t(gender[,-1]))
colnames(gender) <- n
gender <- as.data.frame(
	cbind(gender, id=c(1,2,3,1,2,3,1,2,3,1,2,3,0),
		cat=rep(c("I","V","U","O","x"), times=c(3,3,3,3,1))))
gender <- reshape(filter(gender, id!=0), v.names="male", timevar="cat",
	idvar="id", direction="wide")
gender <- as.data.frame(t(select(gender, male.I, male.V, male.U)))
colnames(gender) <- c("mean","sd","N")
gender <- as.data.frame(cbind(gender,
	cat=c("Insured","Voluntary Uninsured",
		"Non-voluntary Uninsured"),
	se=gender$sd / sqrt(gender$N)))

p <- ggplot(gender, aes(x=cat, y=mean, fill=cat))
gender_fig <- p + geom_bar(stat="identity") + geom_errorbar(limits) + 
	labs(y="Percent Male", title="Gender by Insurance Status") +
	bar.theme + scale_y_continuous(labels=percent) + scale + coord_flip()
ggsave(gender_fig, filename="Descriptives\\supplemental\\gender_fig.png",
	width=8, height=5, units="in")

#Race
race <- filter(ivtab, grepl("race_\\w*", ivtab$Variable))
n <- race$Variable
race <- as.data.frame(t(race[,-1]))
colnames(race) <- n
race <- as.data.frame(
	cbind(race, id=c(1,2,3,1,2,3,1,2,3,1,2,3,0),
		cat=rep(c("I","V","U","O","x"), times=c(3,3,3,3,1))))
race <- reshape(filter(race, id!=0), v.names=c("race_hispanic","race_white",
	"race_black","race_native",
	"race_asian","race_other"),
	timevar="cat", idvar="id", direction="wide")
race <- as.data.frame(t(race[,-grep("race_\\w*.O", colnames(race))]))
race <- race[-1,]
colnames(race) <- c("mean","sd","N")
race <- as.data.frame(cbind(race, se=race$sd / sqrt(race$N),
	cat=rep(c("Insured","Voluntary Uninsured",
		"Non-voluntary Uninsured"),
		times=c(6,6,6)),
	race.name=rep(c("Hispanic","White","Black","Native",
		"Asian","Other"), times=3)))
race <- arrange(race, cat, mean)
race$race.name <- factor(race$race.name, levels=race$race.name, ordered=TRUE)

p <- ggplot(race, aes(x=race.name, y=mean, fill=cat))
race_fig <- p + geom_bar(stat="identity", position=dodge) + 
	geom_errorbar(limits, position=dodge) + scale_y_continuous(labels=percent) +
	scale + bar.theme + theme(legend.position="right") + 
	labs(y="Percent of Category", title="Race by Insurance Status") + coord_flip()
ggsave(race_fig, filename="Descriptives\\supplemental\\race_fig.png",
	width=8, height=5, units="in")

#Rent vs. Own
rent <- filter(ivtab, Variable=="rent_own")
n <- rent$Variable
rent <- as.data.frame(t(rent[,-1]))
colnames(rent) <- n
rent <- as.data.frame(
	cbind(rent, id=c(1,2,3,1,2,3,1,2,3,1,2,3,0),
		cat=rep(c("I","V","U","O","x"), times=c(3,3,3,3,1))))
rent <- reshape(filter(rent, id!=0), v.names="rent_own", timevar="cat",
	idvar="id", direction="wide")
rent <- as.data.frame(t(select(rent, rent_own.I, rent_own.V, rent_own.U)))
colnames(rent) <- c("mean","sd","N")
rent <- as.data.frame(cbind(rent,
	cat=c("Insured","Voluntary Uninsured",
		"Non-voluntary Uninsured"),
	se=rent$sd / sqrt(rent$N)))

p <- ggplot(rent, aes(x=cat, y=mean, fill=cat))
rent_fig <- p + geom_bar(stat="identity") + geom_errorbar(limits) +
	labs(x="Percent who own/ mortgage their home",
		title="Home Ownership by Insurance Status") +
	scale_y_continuous(labels=percent) + scale + bar.theme + coord_flip()
ggsave(rent_fig, filename="Descriptives\\supplemental\\rent_fig.png",
	width=8, height=5, units="in")

