# Set working directory to where you've saved these scripts
setwd("/Users/Jessie/Dropbox/Documents/Generating Reports using R/Basic Report")

# Read data file
dat <-read.csv("permadata.csv", stringsAsFactors = FALSE, na.strings = "")

# Create a variable that lists all IDs to produce a report for all participants
IDlist <- dat$id

# Alternatively, list the Participant IDs you want to produce a report for
# String IDs need to be wrapped with quotation marks & separated by commas, e.g.:
#IDlist <- c( 
#   "52QBHW6",
#     "S31ZS0D")

# Load packages, plot PERMA results, & knit the pdfs
source("producereport.R")