# WhatsMyWorth App
**An App That Provides Salary Insights Into Data-Related Jobs**

**Course Project for DSCI-D532: Applied Database Technologies**

**Summer 2023 Term @ Indiana University Bloomington**

**Group 8: Swapnali Gujar, Alexis Perez, Yeon Soo Chung**

Using a salary dataset from Kaggle containing records of various data science-related job types, experience level, employment type collected during 2020-2023, our database application will provide supplementary statistics aimed at professionals who are interested in using this data to explore the data science field as their career choice by getting insights into salary and thus professional growth. Our app is aimed at students interested in data-oriented fields and experienced professionals looking to make a career switch. Also, users such as hiring managers, recruiters and startup founders can benefit from our app by getting realistic salary expectations.

Our dataset was obtained from Kaggle (https://www.kaggle.com/datasets/arnabchaki/data-science-salaries-2023), and it includes ~5000 data points and the following attributes:

+ work_year: The year the salary was paid
+ experience_level: The experience level in the job during the year
+ employment_type: The type of employment for the role
+ job_title: The role worked during the year
+ salary: The total gross salary amount paid
+ salary_currency: The currency of the salary paid as an ISO 4217 currency code
+ salaryinusd: The salary in USD
+ employee_residence: Employee's primary country of residence during the work year as an ISO 3166 country code
+ remote_ratio: The overall amount of work done remotely
+ company_location: The country of the employer's main office or contracting branch
+ company_size: The median number of people that worked for the company during the year

This repository includes three sets of code, which roughly divides our project into three parts:

1. Python code preprocessing the Kaggle dataset. We have included csv files of the original Kaggle dataset and the preprocessed dataset to this repository.
2. MySQL Workbench script that loads data and creates our database.
3. R code for our Shiny app, which is linked to our MySQL database.

Ultimately, we developed a Shiny app that includes the following features:

+ Contains a data table of all preprocessed data
+ Users can add rows to the database with their job and salary information
+ Users can filter the database by certain attributes and view plots that visualize the data
+ Users can input specific attribute values, and the app will output a visual of salary progression by plotting median salaries by experience level


## Data Preprocessing
The code file labelled "salaries_preprocessing.ipynb" 

