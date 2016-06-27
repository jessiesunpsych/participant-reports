########################
###   Load Packages  ###
########################

# Install packages by uncommenting them if they're not already installed
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("lubridate")
#install.packages("reshape2")
#install.packages("knitr")
#install.packages("tidyr")

# Load required packages (assumes these are already installed)
require(ggplot2)
require(dplyr)
require(lubridate)
require(reshape2)
require(knitr)
require(tidyr)

#########################################
###   Compute and Plot PERMA results  ###
#########################################

# Read data file with comparison scores
comparison <- read.csv("permacomparisondata.csv",stringsAsFactors = FALSE)

# Compute subscales and create a new data frame with participant IDs and scale scores
P <- rowMeans(dat[,2:4]) # Calculate the mean score across columns 2-4 (i.e., the three Positive Emotions items) and assign it to a new variable "P"
E <- rowMeans(dat[,5:7])
R <- rowMeans(dat[,8:10])
M <- rowMeans(dat[,11:13])
A <- rowMeans(dat[,14:16])
N <- rowMeans(dat[,17:19])
id <- dat[1]
permascores <- data.frame(cbind(id,P,E,R,M,A,N)) # Create a new data frame with participant IDs and the six subscale scores only

# Create function to plot bar graph
plotperma <- function(participantID) {
  indivscores<-data.frame(permascores[permascores$id == participantID,]) # subset permascores for a specific participant
  indivscores2<-rbind(indivscores[,-1], comparison[,-1]) # combine individual scores with comparison M & SD, and remove header rows & first columns for both
  zscores<-sapply(indivscores2, function(x){((x[1]-x[2])/x[3])}) # calculate z score
  pscores<-sapply(zscores, function(x){pnorm(x)*100}) # convert z score into percentile, assuming a normal distribution
  pscoredat<-data.frame(pscores) # create data frame of p scores
  pscoredat$scale <- rownames(pscoredat) # add column of subscale names
  
  # Create bar graph
  permaplot <- ggplot(data=pscoredat, aes(x=scale, y=pscores, fill=scale))
  permaplot <- permaplot + geom_bar(stat = "identity", position="dodge", width=0.8)
  permaplot <- permaplot + xlab("") + ylab("Percentile")
  #permaplot <- permaplot + ylab("")
  permaplot <- permaplot + scale_x_discrete(limits=c("P",
                                                     "E",
                                                     "R",
                                                     "M",
                                                     "A",
                                                     "N")) +
    scale_fill_manual(values=c("#0099FF", # Colours for individual bars
                               "#FFFF00",
                               "#FF9933",
                               "#FF3333",
                               "#00FF00",
                               "#9900FF")) +
    guides(fill=FALSE) # Turn off legends
  permaplot <- permaplot + scale_y_continuous(limits=c(0, 100),breaks=seq(0,100,by=10)) 
  permaplot <- permaplot + theme(plot.title = element_text(size=25, face="bold", margin= 
                                                             margin(20,0,20,0)),
                                 panel.background = element_rect(fill = 'white'),
                                 plot.background = element_rect(fill = 'white'),
                                 axis.ticks = element_line(colour='black', size = 1),
                                 axis.text = element_text(size=15, colour = 'black' ),
                                 axis.text.x =  element_text(vjust = 0.5, angle = 0, size=15),
                                 axis.title.y = element_text(size=15),
                                 axis.line.x = element_line(color="black", size = 1),
                                 axis.line.y = element_line(color="black", size = 1),
                                 plot.margin = unit(c(1,0,0,0), "cm")
  )
  permaplot <- permaplot + theme(panel.grid.major.x = element_blank(), # get rid of vertical grid lines
                                 panel.grid.major.y = element_line( size=.1, color="grey70" ) 
                                 # explicitly set the horizontal lines (or they will disappear too)
  )
  return(permaplot)
}

###########################################
###   Create function to knit the pdfs  ###
###########################################

#Takes in a single ID code, prints the plots, and pumps out a pdf with the participant ID as the title.
knitreport <- function(ID){
  permaplot <- plotperma(ID)
  knit2pdf("../report.rnw",
           output = paste("./", ID, ".tex", sep=""))
}  

#Remove extraneous files created by this process
removetexjunk <- function(ID){
  if(file.exists(paste(ID, ".tex", sep=""))){file.remove(paste(ID, ".tex", sep=""))}
  if(file.exists(paste(ID, ".aux", sep=""))){file.remove(paste(ID, ".aux", sep=""))}
  if(file.exists(paste(ID, ".log", sep=""))){file.remove(paste(ID, ".log", sep=""))}
  if(file.exists(paste(ID, ".out", sep=""))){file.remove(paste(ID, ".out", sep=""))}
}

###########################################
###         Produce the report!         ###
###########################################

# Set working directory to Reports subfolder
setwd(paste(getwd(),"/Reports",sep=""))

# Runs the knitreport function on each ID in the ID list
lapply(IDlist, knitreport)
lapply(IDlist, removetexjunk)

# Delete unnecessary new folder
unlink("figure", recursive = TRUE, force = FALSE)

# Reset working directory to main folder for convenience
setwd("../")
