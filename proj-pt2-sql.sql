# DSCI-D532 Project Part 2
# Swapnali Gujar, Alexis Perez, Yeon-Soo Chung

# Create database and set it as default schema:
CREATE DATABASE datajobs;

# The preprocessed salary dataset (included in submission) needs to be imported to MySQL workbench before running the code in this file.

# Create relational tables

# Create jobs_title_field table containing info about job title and job field for all users.
CREATE TABLE job_title_field
AS SELECT user_id, job_title, job_field
FROM salaries_preprocessed;

# Create salaries table containing salary-related info for all users.
CREATE TABLE salaries
AS SELECT user_id, salary_in_usd
FROM salaries_preprocessed;

# Create employment type table whose unique values are primary keys.
CREATE TABLE emp_type_table (
    employment_type varchar(50),
    PRIMARY KEY (employment_type)
);

INSERT INTO emp_type_table (employment_type)
VALUES ('Freelance'), ('Part-time'), ('Contract'), ('Full-time');

# Create experience level table whose unique levels are primary keys.
CREATE TABLE exp_level_table (
    experience_level varchar(50),
    PRIMARY KEY (experience_level)
);

INSERT INTO exp_level_table (experience_level)
VALUES ('Entry-level'), ('Mid-level'), ('Senior-level'), ('Executive/Director');

# Create company size table whose unique sizes are primary keys.
CREATE TABLE comp_size_table (
    company_size varchar(50),
    PRIMARY KEY (company_size)
);

INSERT INTO comp_size_table (company_size)
VALUES ('Small'), ('Medium'), ('Large');

# Create remote ratio table whose unique values are primary keys
CREATE TABLE emp_mode_table (
    employment_mode varchar(50),
    PRIMARY KEY (employment_mode)
);

INSERT INTO emp_mode_table (employment_mode)
VALUES ('Onsite'), ('Hybrid'), ('Remote');

CREATE TABLE company_location_table (
    company_location varchar(50) NOT NULL,
    company_location_na varchar(50) NOT NULL,
    PRIMARY KEY (company_location)
);

INSERT INTO company_location_table (company_location, company_location_na)
VALUES ('United States', TRUE), ('Great Britain', FALSE), ('Germany', FALSE), ('Canada', TRUE),
          ('Turkey', FALSE), ('France', FALSE), ('Portugal', FALSE), ('Brazil', FALSE),
          ('Australia', FALSE), ('Spain', FALSE), ('Switzerland', FALSE), ('Andorra', FALSE),
          ('Netherlands', FALSE), ('Ecuador', FALSE), ('Mexico', FALSE), ('Israel', FALSE),
          ('India', FALSE), ('Nigeria', FALSE), ('Saudi Arabia', FALSE), ('Colombia', FALSE),
          ('Poland', FALSE), ('Norway', FALSE), ('Ghana', FALSE), ('Argentina', FALSE),
          ('Japan', FALSE), ('Russia', FALSE), ('South Africa', FALSE), ('Italy', FALSE),
          ('Hong Kong', FALSE), ('Central African Republic', FALSE), ('Finland', FALSE), ('Ukraine', FALSE),
          ('Ireland', FALSE), ('Singapore', FALSE), ('Sweden', FALSE), ('Slovenia', FALSE),
          ('Thailand', FALSE), ('Croatia', FALSE), ('Estonia', FALSE), ('Armenia', FALSE),
          ('Bosnia and Herzegovina', FALSE), ('Kenya', FALSE), ('Latvia', FALSE), ('Romania', FALSE),
          ('Pakistan', FALSE), ('Lithuania', FALSE), ('Iran', FALSE), ('Bahamas', FALSE),
          ('Hungary', FALSE), ('Austria', FALSE), ('Puerto Rico', FALSE), ('American Samoa', FALSE),
          ('Greece', FALSE), ('Denmark', FALSE), ('Philippines', FALSE), ('Belgium', FALSE),
          ('Indonesia', FALSE), ('Egypt', FALSE), ('United Arab Emirates', FALSE), ('Malaysia', FALSE),
          ('Honduras', FALSE), ('Czech Republic', FALSE), ('Algeria', FALSE), ('Iraq', FALSE),
          ('China', FALSE), ('New Zealand', FALSE), ('Chile', FALSE), ('Moldova', FALSE),
          ('Luxembourg', FALSE), ('Malta', FALSE);


# Queries for Project Part 2 submission

# Count jobs by job field
SELECT count(user_id) AS job_count, job_field
FROM salaries_preprocessed
GROUP BY job_field
ORDER BY count(user_id) DESC;

# Create view by joining salaries and job_title_field tables
CREATE VIEW user_job_salary
AS SELECT t1.salary_in_usd, t2.job_title, t2.job_field
FROM salaries t1
INNER JOIN job_title_field t2  ON t1.user_id = t2.user_id;
# View looks like: 
SELECT * FROM user_job_salary;

# Get minimum and maximum salaries for each job field
SELECT job_field as JOB_FIELD, min(salary_in_usd) as MIN_SALARY_IN_USD, max(salary_in_usd) as MAX_SALARY_IN_USD
FROM user_job_salary
group by job_field;

# average salaries by job field
SELECT avg(salary_in_usd) AS average_salary, job_field
FROM salaries_preprocessed
GROUP BY job_field
ORDER BY avg(salary_in_usd) DESC;

# average salaries by experience level
SELECT avg(salary_in_usd) AS average_salary, experience_level
FROM salaries_preprocessed
GROUP BY experience_level
ORDER BY avg(salary_in_usd) DESC;

# average salaries by company size
SELECT avg(salary_in_usd) AS average_salary, company_size
FROM salaries_preprocessed
GROUP BY company_size
ORDER BY avg(salary_in_usd) DESC;

# average salaries by remote ratio
SELECT avg(salary_in_usd) AS average_salary, employment_mode
FROM salaries_preprocessed
GROUP BY employment_mode
ORDER BY avg(salary_in_usd) DESC;

# count jobs by remote ratio
SELECT count(user_id) AS job_count, employment_mode
FROM salaries_preprocessed
GROUP BY employment_mode
ORDER BY count(user_id) DESC;

# count jobs by employment type
SELECT count(user_id) AS job_count, employment_type
FROM salaries_preprocessed
GROUP BY employment_type
ORDER BY count(user_id) DESC;

# average salary for each experience level for "data science" job field
SELECT avg(salary_in_usd)
FROM salaries_preprocessed
WHERE job_field = 'data science' AND experience_level = 'EN';

SELECT avg(salary_in_usd)
FROM salaries_preprocessed
WHERE job_field = 'data science' AND experience_level = 'MI';

SELECT avg(salary_in_usd)
FROM salaries_preprocessed
WHERE job_field = 'data science' AND experience_level = 'SE';

SELECT avg(salary_in_usd)
FROM salaries_preprocessed
WHERE job_field = 'data science' AND experience_level = 'EX';


# identify last row (e.g., confirm row added by app user)
select * from salaries_preprocessed
where user_id = (
	SELECT MAX(user_id) FROM salaries_preprocessed);

# for deleting last row (after adding new row to data in the app for testing)
DELETE FROM salaries_preprocessed
WHERE user_id = (
  SELECT user_id FROM (
    SELECT MAX(user_id) AS user_id FROM salaries_preprocessed
  ) AS subquery
);