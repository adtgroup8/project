# **WhatsMyWorth: A Shiny App That Provides Salary Insights Into Data-Related Jobs**

**Course Project for DSCI-D532: Applied Database Technologies**

**Summer 2023 Term @ Indiana University Bloomington**

**Group 8: Swapnali Gujar, Alexis Perez, Yeon Soo Chung**

## Introduction
Using a salary dataset from Kaggle containing records of various data science-related job types, experience level, employment type collected during 2020-2023, our database application will provide supplementary statistics aimed at professionals who are interested in using this data to explore the data science field as their career choice by getting insights into salary and thus professional growth. Our app is aimed at students interested in data-oriented fields and experienced professionals looking to make a career switch. Also, users such as hiring managers, recruiters and startup founders can benefit from our app by getting realistic salary expectations.

Our dataset was obtained from Kaggle (https://www.kaggle.com/datasets/arnabchaki/data-science-salaries-2023), and it includes ~5000 data points and the following attributes:

+ work_year: The year the salary was paid.
+ experience_level: The experience level in the job during the year.
+ employment_type: The type of employment for the role.
+ job_title: The role worked during the year.
+ salary: The total gross salary amount paid.
+ salary_currency: The currency of the salary paid as an ISO 4217 currency code.
+ salaryinusd: The salary in USD.
+ employee_residence: Employee's primary country of residence during the work year as an ISO 3166 country code.
+ remote_ratio: The overall amount of work done remotely.
+ company_location: The country of the employer's main office or contracting branch.
+ company_size: The median number of people that worked for the company during the year.

This repository includes three sets of code, which roughly divides our project into three parts:

1. Python code preprocessing the Kaggle dataset. We have included csv files of the original Kaggle dataset and the preprocessed dataset to this repository.
2. MySQL Workbench script that loads data and creates our database.
3. R code for our Shiny app, which is linked to our MySQL database.

Ultimately, we developed a Shiny app that includes the following features:

+ Contains a data table of all preprocessed data.
+ Users can add rows to the database with their job and salary information.
+ Users can filter the database by certain attributes and view plots that visualize the data.
+ Users can input specific attribute values, and the app will output a visual of salary progression by plotting median salaries by experience level.


## Data Preprocessing
The code file labelled "salaries_preprocessing.ipynb" is our Google Colab notebook that applies the following changes to the original "salaries.csv" dataset.

+ Created a “job_field” attribute which assigns each job title to a broader field or category.
+ Created a "user_id" attribute as our primary key.
+ Created a “company_location_na” attribute which takes the value of “True” if a job is in North America (US or Canada); and “False” if it is elsewhere.
+ The “remote_ratio” attribute takes values of 0, 50, or 100. We replaced those with “Onsite”, “Hybrid”, and “Remote”, respectively; and we renamed the attribute to "employment_mode".
+ Include only one column for salary in USD.
+ Unabbreviated all abbreviated values, such as country code, experience level acronyms, etc.


## MySQL Database
The code file labelled "proj-pt2-sql.sql" is our MySQL script. After creating the database in line 5, the "salaries_preprocessed.csv" dataset must be loaded into MySQL Workbench by right-clicking on the database name in the side panel and selecting "Table Data Import Wizard" (see image below). This must be done before running any subsequent code.

![mysql-import-data](https://github.com/adtgroup8/project/assets/137223955/514f908e-9073-43f6-825a-1967227a5f3b)

Lines 9-81 create the data tables that normalizes the imported dataset (please refer to the schema in our technical report).

The rest of the script, except the last two queries, are various queries that we executed per the requirements for Part 2 of this project.

The last two queries extract the last row of the imported "salaries_preprocessed" data table; and deletes the last row of the data table, respectively. They were written to confirm and delete the addition of new row(s) via the app.


## Shiny App Development
The code file labelled "WhatsMyWorth_V4.R" is the R code for our WhatsMyWorth Shiny app. Our app connects to the MySQL database via a local server.

One can run the app by opening this file in RStudio. Our app contains three tabs, whose functionalities and operations are explained in our technical report. Below are some screenshots of WhatsMyWorth.

![app-tab1](https://github.com/adtgroup8/project/assets/137223955/f2a9dff6-3afe-4da4-b1d0-2410a47d7a28)
Above is an image of the first tab, "Salary Insights". The app filters the dataset per the user inputs on the left, and it outputs the text and visuals on the right. The text at the top lists the job titles that are filtered based on the selected job field. The first plot contains two box plots of salaries that compare jobs based in North America and those that are not. The second plot contain salary box plots based on company size. The third plot are scatter plots of salaries based on experience level. All plots take into account relevant user inputs (for example, the second plot would not consider the company size selected by the user).

![app-tab2](https://github.com/adtgroup8/project/assets/137223955/200318b6-6527-47de-abe2-64eae1328fd2)
Above is an image of the second tab, "Update Data", which is where the user can add a row to the overall data table with their personal salary information. The user populates every field in the left side panel (a summary box at the bottom reviews what the user is about to enter), and then clicks on "Add Data" to update the data table. This update gets applied to the MySQL database. The user should reload the app for the plots in the other tabs to be updated with the new data.

![app-tab3a](https://github.com/adtgroup8/project/assets/137223955/16944ac6-593a-416c-8e2c-d4bc0b227e85)
Above is an image of the third tab, "Career Growth. Initially, the space where the plot is is empty, but once a user populates the fields in the side panel and clicks on "Whats My Worth!", a graph appears that plots the median salaries of jobs in the data table that meet the input critera. These are median salaries with respect to experience level, which provides the user with information on career progression. This tab also outputs filtered job titles based on user inputs. If you scroll down on this tab, there is a second table (imaged below) that outputs the filtered subset of the overall data table including all attributes.

![app-tab3b](https://github.com/adtgroup8/project/assets/137223955/65efb9c7-5e5a-4905-a8f5-7dfd7d4a240f)













