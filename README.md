# Pub Pol 590 Project: Propitious Selection

## Data Source:

This data comes from the National Longitudinal Study of Adolescent Health (Add Health Study). Data and documentation can be downloaded from ICPSR, study number 21600.  

Download page: http://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/21600  

For this project, I used the wave 4 public access data (DS0023), the wave 4 weights (DS0029), the wave 1 public access data (DS0001), and the wave 1 contextual information (DS0019). Once downloaded, these sources can be merged using the DO file dataset_raw.do (see section on DO Files for more info).

## Directory Setup

You can set up the main directory for this project anywhere on your computer. For best performance, you should have the following subdirectories in the main directory, spelled and capitalized exactly as shown. Folders within these subfolders are indented where applicable.

*	DO_Files
*	Descriptives
*	R_Files
*	ICPSR_downloads (subfolders: DS0001, DS0019, DS0023, DS0029)

## DO Files

### proselectdir.ado

This ADO file defines a command to change Stata's working directory to whichever directory is specified in this file. Once you have set up your main directory and downloaded the appropriate files, you should first edit this file with the location of your main project directory. Then save a copy of this file in the ado "plus" folder on your system (for Windows users, this should be C:\ado\plus). You should put a "p" subfolder in the plus folder if one does not already exist. Save this file in that "p" subfolder. Then Stata should recognize and be able to run the command "proselectdir." All DO files call this command first to set the sorking directory. By using this ADO file, you will only have to specify your project directory in one location (rather than in every DO file).

### dataset_raw.do

*Datasets directly affected: raw_data.dta*  

This DO file merges the datasets downloaded from ICPSR into a single dataset. The labels are included in the ICPSR downloads, and are not affected by this DO file. This file also runs missing_data.do to handle missing values for the variables that will be used in analysis.

### missing_data.do

*Datasets directly affected: raw_data.dta*  

*Run by: dataset_raw.do *  

This DO file changes missing values from numeric codes like 7 or 9997 to Stata's missing value codes (., .d, etc.). It is based on code from the supplemental DO files that come with ICPSR downloads 21600-0001 (for wave 1 questions) and 21600-0023 (for wave 4). To preserve information about the type of missingness, I use missing value codes as follows (this legend is also found in the DO file):

*	. = legitimate skip/ no response (usually coded as 7). This includes those who were in Wave 1 but not Wave 4.
*	.r = refused (usually 6)
*	.d = don't know (usually 8)
*	.n = not applicable (usually 9) or not asked on wave 4 pretest (usually 5)

This DO file only affects the variables that will ultimately end up in clean_data.dta. The code to handle missing values for other variables is in the ICPSR supplemental DO files.

### dataset.do

*Datasets directly affected: clean_data.dta*  

This creates the clean data file for analysis. It keeps only varibles that are related to the analysis, and renames most of those variables so they are easier to remember and understand while working/coding.

### descriptives.do



## Makefile

The makefile for this project keeps track of changes to code used to generate all datasets and graphics. The only exception is that the proselectdir ADO file is not tracked. Use the makefile to automatically regenerate datasets and DO files that need to be changed based on changes to earlier dependencies.