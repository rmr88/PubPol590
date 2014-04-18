### DV Graphs ###

#setwd("~/PubPol590")
library(ggplot2)
library(dplyr, warn.conflicts=FALSE)
library(grid)
library(gridExtra)

#Theme and Scale
bar.theme <- theme_bw() + theme(panel.grid.major.y=element_blank(), 
	panel.grid.major.x=element_line(color="gray80"),
	panel.border=element_blank(),
	axis.title.x=element_text(vjust=-0.2),
	axis.title.y=element_blank(),
	axis.ticks.x=element_blank(),
	axis.ticks.y=element_blank(),
	axis.line.y=element_line(color="black"),
	plot.title=element_text(vjust=1.05),
	plot.margin=unit(c(0.5,0.5,0.8,0), "lines"),
	legend.position="none")
scale <- scale_fill_manual(name="Insurance Status:",
	values=c("Insured"="dodgerblue1",
		"Voluntary Uninsured"="firebrick1",
		"Non-voluntary Uninsured"="green4"))

#Insurance status, detailed
dva <- read.csv("Descriptives\\tab_dv_a.csv")
dva <- filter(dva, Variable!="Total")
dva <- arrange(dva, Frequency)
dva$perc <- paste(round(dva$Percent, digits=1), "% ", sep="")
dva$Variable <- factor(dva$Variable, levels=dva$Variable, ordered=TRUE)

p <- ggplot(dva, aes(x=Variable, y=Frequency))
dva_fig <- p + geom_bar(stat="identity", aes(fill=Variable)) + 
	geom_text(aes(label=perc, hjust=ifelse(Percent>35,1,0))) +
	scale_fill_manual(name="", values=c("Employer-sponsored"="dodgerblue1",
		"Uninsured"="gray50",
		"Spouse's plan"="dodgerblue1",
		"Medicaid"="dodgerblue1",
		"Private insurance"="dodgerblue1",
		"School"="dodgerblue1", 
		"Active duty military"="dodgerblue1",
		"Union"="dodgerblue1",
		"Parents' plan"="dodgerblue1",
		"Don't know"="dodgerblue1",
		"Indian Health Service"="dodgerblue1")) +
	labs(x="", title="Insurance Status") + bar.theme + coord_flip()
ggsave(dva_fig, filename="Descriptives\\supplemental\\fig_dv_a.png",
	width=8, height=5, units="in")

#Reasons for being uninsured
dvb <- read.csv("Descriptives\\tab_dv_b.csv",
	header=FALSE)
colnames(dvb) <- as.character(unlist(dvb[1,c(1,2,3,4)]))
dvb <- filter(dvb, Variable!="Variable")
dvb$Frequency <- as.numeric(as.character(dvb$Frequency))
dvb$Percent <- as.numeric(as.character(dvb$Percent))
dvb$perc <- paste(round(dvb$Percent*100, digits=1), "% ", sep="")
dvb$Variable <- factor(dvb$Variable, levels=dvb$Variable, ordered=TRUE)
dvb <- arrange(dvb, Frequency)
dvb$Variable <- factor(dvb$Variable, levels=dvb$Variable, ordered=TRUE)

p <- ggplot(dvb, aes(x=Variable, y=Frequency, fill=Variable))
dvb_fig <- p + geom_bar(stat="identity") +
	geom_text(aes(label=perc, hjust=ifelse(Percent>0.5,1,0))) +
	scale_fill_manual(name="", values=c("Expensive"="green4",
		"Don't Want/ Need"="firebrick1",
		"No Offer"="green4",
		"Denied"="green4")) +
	labs(x="", title="Reasons for Being Uninsured") + bar.theme + coord_flip()
ggsave(dvb_fig, filename="Descriptives\\supplemental\\fig_dv_b.png",
	width=8, height=5, units="in")

ggsave(arrangeGrob(dva_fig, dvb_fig, ncol=2),file="Descriptives\\fig1_dv.png",
	width=8, height=5, units="in")

#Figure 1: Three Category Insurance Variable
dvc <- read.csv("Descriptives\\tab_dv_c.csv")
dvc <- filter(dvc, Variable!="Total")
dvc <- arrange(dvc, Frequency)
dvc$perc <- paste(" ", round(dvc$Percent), "% ", sep="")
dvc$Variable <- factor(dvc$Variable, levels=dvc$Variable, ordered=TRUE)

p <- ggplot(dvc, aes(x=Variable, y=Frequency, fill=Variable))
dvc_fig <- p + geom_bar(stat="identity") + 
	geom_text(aes(label=perc, hjust=ifelse(Percent>5,1,0))) +
	labs(x="", title="Categories of Dependent Variable") + 
	scale + bar.theme + coord_flip()
ggsave(dvc_fig, filename="Descriptives\\fig2_dv.png",
	width=8, height=5, units="in")

