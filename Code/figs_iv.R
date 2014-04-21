### Main IV Graphs ###

setwd("~/PubPol590")

#Libraries
library(ggplot2)
library(dplyr, warn.conflicts=FALSE)
library(RColorBrewer)
library(grid)
library(gridExtra)
library(scales)
library(reshape2)

#Themes and Other Common Aesthetics
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
lim <- aes(ymax=mean+se, ymin=mean-se, width=0.25)
scale <- scale_fill_manual(name="Insurance Status:",
	values=c("Insured"="dodgerblue1",
		"Voluntary Uninsured"="firebrick1",
		"Non-voluntary Uninsured"="green4"), limits=c(2,4))
dodge <- position_dodge(width=0.9)

#Figure 3: Risk Propensity
risky <- read.csv("Descriptives\\tab_risky.csv")
n <- risky$Variable
risky <- as.data.frame(t(risky[,-1]))
colnames(risky) <- n
risky <- as.data.frame(
	cbind(risky, id=c(1,2,3,1,2,3,1,2,3,1,2,3,0),
		cat=rep(c("I","V","U","O","x"), times=c(3,3,3,3,1))))
risky <- reshape(filter(risky, id!=0), v.names="pers_risky", timevar="cat",
	idvar="id", direction="wide")
risky <- as.data.frame(t(select(risky, pers_risky.I, pers_risky.V, pers_risky.U)))
colnames(risky) <- c("mean","sd","N")
risky <- as.data.frame(cbind(risky,
	cat=c("Insured","Voluntary Uninsured",
		"Non-voluntary Uninsured"),
	se=risky$sd / sqrt(risky$N)))

p <- ggplot(risky, aes(x=cat, y=mean, fill=cat))
risky_fig <- p + geom_bar(stat="identity") + geom_errorbar(lim) +
  labs(y="Mean Risk Propensity (Range is 1-5)",
	  title="Risk Propensity by Insurance Status") +
  bar.theme + scale  + scale_y_continuous(limits=c(2,4), oob=rescale_none) +
	coord_flip()
ggsave(risky_fig, filename="Descriptives\\fig3_risky.png",
	width=8, height=5, units="in")

#Figure 4: General Health
health <- read.csv("Descriptives\\tab_health.csv")
n <- health$Variable
health <- as.data.frame(t(health[,-1]))
colnames(health) <- n
health <- as.data.frame(
	cbind(health, id=c(1,2,3,1,2,3,1,2,3,1,2,3,0),
		cat=rep(c("I","V","U","O","x"), times=c(3,3,3,3,1))))
health <- reshape(filter(health, id!=0), v.names="gen_health", timevar="cat",
	idvar="id", direction="wide")
health <- as.data.frame(t(select(health, gen_health.I, gen_health.V, gen_health.U)))
colnames(health) <- c("mean","sd","N")
health <- as.data.frame(cbind(health,
	cat=c("Insured","Voluntary Uninsured",
		"Non-voluntary Uninsured"),
	se=health$sd / sqrt(health$N)))

p <- ggplot(health, aes(x=cat, y=mean, fill=cat))
health_fig <- p + geom_bar(stat="identity") + geom_errorbar(lim) +
	labs(y="Mean Health (Range is 1-5)",
		title="Subjective General Health by Insurance Status") +
	bar.theme + scale + scale_y_continuous(limits=c(2,4), oob=rescale_none) +
	coord_flip()
ggsave(health_fig, filename="Descriptives\\fig4_health.png",
	width=8, height=5, units="in")

#Figure 5: Income
ivtab <- read.csv("Descriptives\\tab_demog.csv")
income <- filter(ivtab, grepl("inc\\d*", ivtab$Variable))
n <- income$Variable
income <- as.data.frame(t(income[,-1]))
colnames(income) <- n
income <- as.data.frame(
	cbind(income, id=c(1,2,3,1,2,3,1,2,3,1,2,3,0),
		cat=rep(c("I","V","U","O","x"), times=c(3,3,3,3,1))))
income <- reshape(filter(income, id!=0), 
	v.names=c("inc1","inc2","inc3","inc4",
		"inc5","inc6","inc7","inc8",
		"inc9","inc10","inc11","inc12"),
	timevar="cat", idvar="id", direction="wide")
income <- as.data.frame(t(income[,-grep("inc\\d*.O", colnames(income))]))
income <- income[-1,]
colnames(income) <- c("mean","sd","N")
income <- as.data.frame(cbind(income, se=income$sd / sqrt(income$N),
	cat=rep(c("Insured    ","Voluntary Uninsured    ",
		"Non-voluntary Uninsured    "),
	times=c(12,12,12)),
	inc.level=rep(c("<$5,000",
		"$5,000-\n$9,999",
		"$10,000-\n$14,999",
		"$15,000-\n$19,999",
		"$20,000-\n$24,999",
		"$25,000-\n$29,999",
		"$30,000-\n$39,999",
		"$40,000-\n$49,999",
		"$50,000-\n$74,999",
		"$75,000-\n$99,999",
		"$100,000-\n$149,999",
		"$150,000+"), times=3)))
income$inc.level <- factor(income$inc.level,
	levels=income$inc.level, ordered=TRUE)

p <- ggplot(income, aes(x=inc.level, y=mean, fill=cat))
income_fig <- p + geom_bar(stat="identity", position=dodge) + 
	geom_errorbar(lim, position=dodge) +
	labs(x="Annual Household Income, 2006", title="Income by Insurance Status") +
	bar.theme.vert + scale_fill_manual(name="Insurance Status:",
		values=c("Insured    "="dodgerblue1",
			"Voluntary Uninsured    "="firebrick1",
			"Non-voluntary Uninsured    "="green4")) + 
	scale_y_continuous(labels=percent) +
	theme(legend.position="bottom", axis.text.x=element_text(size=8))
ggsave(income_fig, filename="Descriptives\\fig5_income.png",
	width=8, height=5, units="in")

