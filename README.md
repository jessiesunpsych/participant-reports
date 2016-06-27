# participant-reports

**Purpose:** One way to compensate research participants is to offer them feedback based on the questionnaires they completed for your study. Whether it's information about their personality or wellbeing (or anything else you're researching), people find it interesting to learn more about themselves and how they compare to others. However, generating these reports manually (e.g., using a Word template) can be time-consuming. These R scripts work with LaTeX to pump out personalised PDF reports based on participants' raw scores [**(see example)**](https://github.com/jessiesunpsych/participant-reports/blob/master/basic-report/Reports/examplereport.pdf) or percentile scores [**(see example)**](https://github.com/jessiesunpsych/participant-reports/blob/master/percentile-report/Reports/examplepercentilereport.pdf) for several participants at once. These scripts can be easily modified to suit your data and needs.

**How does it work?**
These scripts (1) compute scores and create individual bar charts based on these scores, (2) insert these bar charts into a LaTeX template, and (3) produce a PDF report for each participant. You can choose to generate reports for all participants (the default) or enter specific ID codes for the participants you want to generate reports for.

**How do I use it?**

1. Decide on whether you want to show participants their raw scores or percentile scores. Download the corresponding [**`basic-report`**](https://github.com/jessiesunpsych/participant-reports/blob/master/basic-report/) or  [**`percentile-report`**](https://github.com/jessiesunpsych/participant-reports/blob/master/percentile-report/) scripts.

2. For either version, `idlist.R` is the control script. This is where you set the working directory to where you've saved these scripts, then specify which participants you want to generate reports for (if not all).

3. Run `producereport.R` via the final line of `idlist.R` to produce reports for those participants - the PDF report will appear in a folder named Reports.

4. Modify the data source (in `idlist.R`), details for computing scales and the aesthetics of the bar chart (in `producereport.R`), and text in the report (`report.rnw`) to suit your needs!

**Required software:**

1. [R ≥ Version 3.3.1](https://www.r-project.org/) with [RStudio](https://www.rstudio.com/)

2. Full installation of [LaTeX](https://www.latex-project.org/)

3. R packages (can be installed by uncommenting relevant lines in `producereport.R`): `ggplot2`, `dplyr`, `lubridate`, `reshape2`, `knitr`, `ezknitr`, `tidyr`

**Contributions:** Rowan Jacques-Hamilton created a super-comprehensive version of these scripts; Jessie Sun then pared them back for simplicity to create basic and percentile versions.
