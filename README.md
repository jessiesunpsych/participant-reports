# participant-reports

Purpose: One way to compensate research participants is to offer them feedback based on the questionnaires they completed for your study. Whether it's information about their personality or wellbeing (or anything else you're researching), people find it interesting to learn more about themselves and how they compare to others. However, generating these reports manually (e.g., using a Word template) can be time-consuming. These R scripts work with LaTeX to pump out personalised PDF reports (see examplereport.pdf) for several participants at once. These scripts can be easily modified to suit your data and needs.

How Does it Work?

1. In idlist.R, set the working directory to where you've saved these scripts. Then, you can choose to generate reports for the whole list of 5 participant IDs (the default) or enter specific ID codes for the participants you want to generate for.

2. Run producereport.R through the final line of idlist.R to produce reports for those participants - the PDF report will appear in a folder named Reports.

3. Modify the data source (in idlist.R), details for computing scales and the aesthetics of the bar chart (in producereport.R), and text in the report (report.rnw) to suit your needs!

Required Software:

1. R ≥ Version 3.3.1 (https://www.r-project.org/) and (optional but helpful) RStudio (https://www.rstudio.com/)

2. Full installation of LaTeX (https://www.latex-project.org/)

3. R packages (can be installed by uncommmenting relevant lines in producereport.R): ggplot2, dplyr, lubridate, reshape2, knitr, ezknitr, tidyr

Contributions: Rowan Jacques-Hamilton created a super-comprehensive version of these scripts; Jessie Sun then pared them back for simplicity.
