# Pub Pol 590 Project: Propitious Selection

## Data Source:

This data comes from the National Longitudinal Study of Adolescent Health (Add Health Study). Data and documentation can be downloaded from ICPSR, study number 21600.  

Download page: http://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/21600  

For this project, I used the wave 4 public access data (DS0023), the wave 4 weights (DS0029), the wave 1 public access data (DS0001), and the wave 1 contextual information (DS0019). Once downloaded, these sources can be merged using the DO file dataset_raw.do (see section on DO Files for more info).

## Directory Setup

You can set up the main directory for this project anywhere on your computer. For best performance, you should have the following subdirectories in the main directory, spelled and capitalized exactly as shown. Folders within these subfolders are indented where applicable.

*	Code
*	Descriptives
*	ICPSR_downloads (subfolders: DS0001, DS0019, DS0023, DS0029)
*	Results

## DO Files

### proselectdir.ado

This ADO file defines a command to change Stata's working directory to whichever directory is specified in this file. Once you have set up your main directory and downloaded the appropriate files, you should first edit this file with the location of your main project directory. Then save a copy of this file in the ado "plus" folder on your system (for Windows users, this should be C:\ado\plus). You should put a "p" subfolder in the plus folder if one does not already exist. Save this file in that "p" subfolder. Then Stata should recognize and be able to run the command "proselectdir." All DO files call this command first to set the sorking directory. By using this ADO file, you will only have to specify your project directory in one location (rather than in every DO file).

### dataset_raw.do

*Datasets directly affected: raw_data.dta*  

This DO file merges the datasets downloaded from ICPSR into a single dataset. The labels are included in the ICPSR downloads, and are not affected by this DO file. This file also runs missing_data.do to handle missing values for the variables that will be used in analysis.

### missing_data.do

*Datasets directly affected: raw_data.dta*  

*Run by: dataset_raw.do*  

This DO file changes missing values from numeric codes like 7 or 9997 to Stata's missing value codes (., .d, etc.). It is based on code from the supplemental DO files that come with ICPSR downloads 21600-0001 (for wave 1 questions) and 21600-0023 (for wave 4). To preserve information about the type of missingness, I use missing value codes as follows (this legend is also found in the DO file):

*	. = legitimate skip/ no response (usually coded as 7). This includes those who were in Wave 1 but not Wave 4.
*	.r = refused (usually 6)
*	.d = don't know (usually 8)
*	.n = not applicable (usually 9) or not asked on wave 4 pretest (usually 5)

This DO file only affects the variables that will ultimately end up in clean_data.dta. The code to handle missing values for other variables is in the ICPSR supplemental DO files.

### dataset.do

*Datasets directly affected: clean_data.dta*  

This creates the clean data file for analysis. It keeps only varibles that are related to the analysis, and renames most of those variables so they are easier to remember and understand while working/coding.

### imputations.do

*Files created: impcomp1.xml, impcomp2.xml, and impcomp3.xml in imputations subfolder of Results folder*

*Run by: models.do*

Some of the variables used in analysis had significant amounts of missing data. This DO file summarizes patterns of missingness for all variables used in the analysis and generates imputations for income. This DO file, if run on its own or with the "1" argument from another DO file (see below), generates regression output tables in "Results." These tables compare models using missing values of income, models using dummies for income categories (including the .d and .r categories), and models using imputations  for missing values of income. The mi impute command specifies a random number seed, so the imputations created will be the same every time this DO file is run. The imputations are not saved in clean_data.dta at any point in this project. 

*Running this DO file with arguments*

This DO file can be run with 0 as an argument to suppress the comparison tables. Use this feature if you want to run this DO file from another DO file and only run the imputations. If you want to generate the imputations without running the comparison models and exporting those results, use the 0 argument (see models.do for an example). If you want to run the entire imputations DO file, either run it on its own or with an argument other than 0. As a precaution, I suggest always specifying an argument when running imputations.do from another DO file, Stata's command line, or in batch mode from the command prompt. I follow this convention in all of my code (see, for example, the makefile).

### descriptives.do

*Files created: all tab_\*.csv files in Descriptives, and supplemental_stats.csv and additive_index.csv in supplemental*

This DO file creates tables of descriptive statistics, including the summary tables found in the paper and a table of supplemental statistics that may be of interest. The tables are exported to CSV files, created directly by the DO file. This is done using the tabmatrix and mat2txt programs I wrote, described below. 

### factors.do

This DO file performs confirmatory factor analysis on the Big Five personality measures. The purpose is to confirm that adiditve indices are appropriate for use in the model.

### models.do

*Files created: table1.xml, table2.xml, table3.xml, and probabilities.csv (in Results)*

All of the models in the paper are generated by this DO file, along with various model statistics (some of which also appear in the paper). The DO file writes model results to XML files. Some models mentioned but not included in the paper are also generated here. Finally, the conditional probability graphs based on the multinomial logit models are generated here.

At the beginning of the DO file, Stata is told to execute imputations.do (with argument 0, see imputations.do section above). When income is included as a covariate, I use imputed values of income in the model by specifying "mi estimate" and using hh_income_copy rather than hh_income2006.

### page_stats.do

*File created: page_stats.csv*

There are various statistics in the paper which are mentioned on their own and are not found in any descriptive or model tables. Most of these numbers come directly from my data. This DO file creates those statistics. Other numbers in the paper which come from other sources are cited appropriately.

### tabmatrix.do

This DO file contains a program I wrote to put the results of a cross-tabulation (from the tabulate command) into a matrix. This matrix is used by the mat2txt command, described below, to export the results to a CSV file.

### mat2txt.do

The program contained in this DO file writes a Stata matrix to a CSV file, including any row and column labels and a title and table note if specified by the user. I adapted this code from code previously written by Ben Jann and M. Blasnik.

### R Code for Figures

*Files created: All .png files in the Descriptives and Results folders*

The .R files in the Code folder contain R code to generate final versions of figures and graphs. These R code files can be run on their own, as long as the data files are in the proper locations.

## Makefile

The makefile for this project keeps track of changes to code used to generate all datasets, tables, and graphics. Use the makefile to automatically (re)generate datasets and output files that need to be changed based on changes to earlier dependencies. Changes to tabmatrix.do, mat2txt.do, and proselectdir.ado files are not tracked.

## Required Software

To run all the code in this project, you will need the following software packages:

*	[Stata 13](http://www.stata.com/) or higher
*	Latest version of [R](http://www.r-project.org/)
*	Latest version of GNU Make ([Windows](http://gnuwin32.sourceforge.net/packages/make.htm); Mac users should already have this since it's usually a standard Mac OS feature).

Prior to running the Makefile or any of the DO files, you should install the required Stata packages by running required_packages.do (in the Code folder). You should also install the required R libraries by running required_libraries.R (also in Code).

You may need to add Stata, R, and Make to your system environment's path variable. Tutorial on how to do that in Windows [here](http://www.computerhope.com/issues/ch000549.htm).

I also recommend having Microsoft Office (though Open Office or Corel software will probably work as well), a good text editor(like [Notepad++](http://notepad-plus-plus.org/) or [Sublime Text](http://www.sublimetext.com/)), and [R Studio](https://www.rstudio.com/).

## To do:

*	write page_stats code
	*	add page_stats table, put in descriptives, add to makefile
*	be sure makefile is completely up to date
*	this would be a good time to figure out how to do better reference lists with TeX...
*	Models with related variables on impulsivity
*	Models with wave 1 or wave 3 risk measures to show that this is not just due to measurement error
*	Long term (probably after the semester ends): get full dataset from Add Health
