# participant-reports

Purpose: One way to compensate research participants is to offer them feedback based on the questionnaires they completed for your study. Whether it's information about their personality or wellbeing (or anything else you're researching), people find it interesting to learn more about themselves and how they compare to others. However, generating these reports manually (e.g., using a Word template) can be time-consuming. These R scripts work with LaTeX to pump out personalised PDF reports for several participants at once. These scripts can be easily modified to suit your data and needs.

Required Software:
1. R ≥ Version 3.3.1 (https://www.r-project.org/) and (optional but helpful) RStudio (https://www.rstudio.com/)
2. Full installation of LaTeX (https://www.latex-project.org/)

How Does it Work?
1. In producereport.R, set working directory to where you've saved the folder on your computer
2. In producereport.R, you can either enter specific participant ID codes or choose to generate reports for the whole list of 5 participant IDs
3. Run producereport.R to see how it works - the PDF report will appear in a folder named Reports
4. Modify the data source, aesthetics of the bar chart (plotperma.R), and text in the report (report.rnw) to suit your needs!

Acknowledgements: These scripts build off a more extensive version written by Rowan Jacques-Hamilton.
