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

# Compute subscales and create a new data frame with participant IDs and scale scores
P <- rowMeans(dat[,2:4]) # Calculate the mean score across columns 2-4 (i.e., the three Positive Emotions items) and assign it to a new variable "P"
E <- rowMeans(dat[,5:7])
R <- rowMeans(dat[,8:10])
M <- rowMeans(dat[,11:13])
A <- rowMeans(dat[,14:16])
N <- rowMeans(dat[,17:19])
permascores <- data.frame(cbind(IDlist,P,E,R,M,A,N)) # Create a new data frame with participant IDs and the six subscale scores only

# Create function to plot bar graph
plotperma <- function(participantID) {
  indivscores<-data.frame(permascores[permascores$IDlist == participantID,]) # subset permascores for a specific participant
  indivscores <- gather(indivscores) # transform data from wide to long format
  indivscores <- indivscores[-1,] # get rid of the first row
  names(indivscores)[1] <- 'scale' # rename column name
  names(indivscores)[2] <- 'score' # rename column name
  indivscores$score <- as.numeric(paste(indivscores$score)) # coerce to numeric form
  permaplot <- ggplot(data=indivscores, aes(x=scale, y=score, fill=scale))
  permaplot <- permaplot + geom_bar(stat = "identity", position="dodge", width=0.8)
  permaplot <- permaplot + xlab("") + ylab("")
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
  permaplot <- permaplot + scale_y_continuous(limits=c(0, 10),breaks=seq(0,10,by=1)) 
  permaplot <- permaplot + theme(plot.title = element_text(size=25, face="bold", margin= 
                                                             margin(20,0,20,0)),
                                 panel.background = element_rect(fill = 'white'),
                                 plot.background = element_rect(fill = 'white'),
                                 axis.ticks = element_line(colour='black', size = 1),
                                 axis.text = element_text(size=15, colour = 'black' ),
                                 axis.text.x =  element_text(vjust = 0.5, angle = 0, size=15),
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
