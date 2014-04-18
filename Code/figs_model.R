### Conditional Probability Graphs ###

setwd("~/PubPol590")
library(ggplot2)
library(dplyr, warn.conflicts=FALSE)
library(scales)
library(grid)
library(gridExtra)

#Data and Theme
cond <- read.csv("Results\\probabilities.csv")
prob.theme <- theme_bw() + theme(panel.grid.major.x=element_line(color="gray80"),
	panel.grid.major.y=element_line(color="gray80"),
	panel.border=element_rect(color="black"),
	axis.title.x=element_text(vjust=-0.2),
	axis.title.y=element_text(vjust=0.2),
	axis.ticks.x=element_blank(),
	axis.ticks.y=element_blank(),
	plot.title=element_text(vjust=1.05),
	plot.margin=unit(c(0.5,0,0.8,0.5), "lines"))

#Full Graph
p <- ggplot(cond, aes(x=insur3x))
cond_fig <- p + geom_line(aes(y=insur3p1, linetype="Mean Estimate",
	color="Insured"), size=1) +
	geom_line(aes(y=ins3lp1, linetype="Poor Health", color="Insured"), size=1) +
	geom_line(aes(y=ins3hp1, linetype="Excellent Health",
		color="Insured"), size=1) +
	geom_line(aes(y=insur3p2, linetype="Mean Estimate",
		color="Vol. Uninsured"), size=1) +
	geom_line(aes(y=ins3lp2, linetype="Poor Health",
		color="Vol. Uninsured"),size=1) +
	geom_line(aes(y=ins3hp2, linetype="Excellent Health",
		color="Vol. Uninsured"), size=1) +
	geom_line(aes(y=insur3p3, linetype="Mean Estimate",
		color="Non-vol. Uninsured"), size=1) +
	geom_line(aes(y=ins3lp3, linetype="Poor Health",
		color="Non-vol. Uninsured"), size=1) +
	geom_line(aes(y=ins3hp3, linetype="Excellent Health",
		color="Non-vol. Uninsured"), size=1) +
	scale_color_manual(name="Insurance Status:",
		values=c("Insured"="dodgerblue1", 
			"Vol. Uninsured"="firebrick1",
			"Non-vol. Uninsured"="green4")) +
	scale_linetype_manual(name="Health Status:",
		values=c("Mean Estimate"="solid",
			"Poor Health"="dotted",
			"Excellent Health"="longdash")) +
	scale_y_continuous(labels=percent) +
	labs(x="Riskiness (\"I like to take risks\")", y="Probability",
		title="Conditional Probabilities from Model") +
	scale_x_discrete(breaks=1:5, labels=c("Strongly Disagree", "Disagree", 
		"Neither", "Agree", "Strongly Agree")) + prob.theme
ggsave(cond_fig, filename="Results\\fig6_model.png", 
	width=8, height=5, units="in")

#Voluntary Uninsured Only
cond_fig_d <- p + geom_line(aes(y=insur3p2, linetype="Mean Estimate",
	color="Vol. Uninsured"), size=1) +
	geom_line(aes(y=ins3lp2, linetype="Poor Health",
		color="Vol. Uninsured"), size=1) +
	geom_line(aes(y=ins3hp2, linetype="Excellent Health",
		color="Vol. Uninsured"), size=1) +
	scale_linetype_manual(name="Health Status:",
		values=c("Mean Estimate"="solid",
			"Poor Health"="dotted",
			"Excellent Health"="longdash")) +
	labs(x="Riskiness (\"I like to take risks\")", y="Probability",
		title="Conditional Probabilities, Voluntarily Uninsured Only") +
	scale_x_discrete(breaks=1:5, labels=c("Strongly Disagree", "Disagree", 
		"Neither", "Agree", "Strongly Agree")) +
	scale_y_continuous(labels=percent) + prob.theme
ggsave(cond_fig_d, filename="Results\\fig7_model_volunins.png", 
	width=8, height=5, units="in")

