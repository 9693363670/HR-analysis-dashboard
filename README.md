# HR Analytics Dashboard — Workforce Attrition Study

**Turning employee data into actionable workforce insights using Power BI, SQL, and Python.**

**Author:** Ritik Kumar Gupta  
**Project Type:** HR Analytics | Workforce Attrition Analysis | Business Intelligence  
**Tools:** Power BI, SQL, Python, Pandas, NumPy, GitHub
**Linkdiln:** Linkdiln[https://www.linkedin.com/in/ritik-kumar-gupta-287a85280/]
---

## 1. Project Overview

The **HR Analytics Dashboard** is an interactive business intelligence project developed to analyze employee attrition patterns and understand the factors associated with workforce turnover.

Employee attrition is a major challenge for organizations because frequent employee departures can increase recruitment costs, disrupt operations, reduce productivity, and lead to the loss of organizational knowledge. However, employee data often remains scattered across reports and spreadsheets, making it difficult for HR teams to identify meaningful patterns.

This project transforms employee-level data into structured analytical insights through SQL queries, data analysis, and interactive Power BI visualizations.

Using a dataset containing **1,470 employee records**, structured around the IBM HR Analytics dataset format, the project explores attrition across age groups, departments, job roles, salary bands, tenure, and training participation.

The dashboard is designed to help HR teams move beyond descriptive reporting and make more informed, data-driven workforce decisions.

## 2. Business Problem

Organizations need to understand not only how many employees leave but also which employee groups experience higher attrition and what patterns may be associated with those departures.

The project addresses the following business questions:

- What is the overall employee attrition rate?
- Which departments and job roles experience higher attrition?
- How does attrition vary across different age groups?
- Is employee salary associated with differences in attrition?
- At what stage of an employee's tenure are departures more concentrated?
- How does training participation relate to employee retention?
- Which employee characteristics can be used to prioritize further HR investigation?

By answering these questions, the dashboard helps HR stakeholders identify areas that may require further investigation and targeted retention strategies.

## 3. Project Objectives

The primary objectives of this project are to:

1. Analyze workforce attrition using employee-level data.
2. Calculate key HR performance indicators and summarize workforce trends.
3. Identify employee segments with comparatively higher attrition.
4. Use SQL to perform structured analysis, aggregations, and segmentation.
5. Build interactive Power BI visuals for exploring workforce patterns.
6. Develop a six-factor, rule-based flight-risk score for exploratory prioritization.
7. Examine the relationship between training participation and attrition.
8. Translate analytical findings into practical questions for HR decision-making.

## 4. Dataset Description

The project uses **1,470 employee records** from a dataset structured around the IBM HR Analytics attrition dataset format.

The dataset contains employee-related attributes suitable for exploring workforce composition, job characteristics, compensation, training, satisfaction, tenure, and attrition status.

### Key analytical dimensions

| Dimension | Purpose |
|---|---|
| Attrition | Identifies whether an employee left the organization |
| Department | Compares workforce turnover across departments |
| Job Role | Identifies roles with comparatively higher attrition |
| Age | Examines attrition patterns across age groups |
| Monthly Income | Compares attrition across compensation bands |
| Years at Company | Examines tenure and early employee departures |
| Training Times Last Year | Explores the relationship between training participation and attrition |
| Job Satisfaction | Supports analysis of employee satisfaction patterns |

**Data note:** The dataset follows the IBM HR Analytics dataset structure and should be treated as a dataset for analytical demonstration rather than a representation of a specific organization's current workforce. Results depend on the supplied data and its definitions.

## 5. Technology Stack

### Power BI
Used to build an interactive dashboard featuring KPI cards, comparative charts, filters, and workforce attrition visualizations.

### SQL
Used for structured data analysis, including aggregations, conditional grouping, segmentation, common table expressions (CTEs), and window functions.

### Python
Python with Pandas and NumPy supports data inspection, data preparation, and numerical analysis.

### Git and GitHub
Used for source control, project organization, and sharing the analysis and dashboard files.

## 6. Key Performance Indicators

The dashboard highlights key workforce metrics to provide a quick overview of attrition patterns.

| KPI | Reported Value |
|---|---:|
| Employee Records | 1,470 |
| Overall Attrition Rate | 8.6% |
| Sales Department Attrition Rate | 9.2% |
| Attrition Rate Among Employees Aged 18–25 | 22.1% |
| Sales Representative Attrition Rate | 11.9% |

These metrics provide an overview of the workforce and help identify employee segments that may warrant closer examination.

## 7. Analytical Findings

The analysis highlights several patterns in the dataset.

### 7.1 Attrition by Age Group

Employees aged 18–25 show a reported attrition rate of **22.1%**.

This indicates that younger employees in the dataset experience comparatively higher turnover. Possible areas for further investigation include onboarding, career development opportunities, role expectations, compensation, and early employee engagement.

### 7.2 Attrition by Department

The Sales department has a reported attrition rate of **9.2%**.

This finding can help HR teams investigate whether workload, performance expectations, compensation structures, or career progression differ across departments. The dashboard identifies a pattern but does not establish its cause.

### 7.3 Attrition by Job Role

Sales Representatives show a reported attrition rate of **11.9%**.

Role-level analysis helps distinguish broad departmental patterns from the experiences of specific employee groups. This can support more focused investigation into job responsibilities, working conditions, and retention challenges.

### 7.4 Attrition by Salary Band

Employees earning below $40,000 show approximately **2.3 times the attrition rate** of employees earning $80,000 or more, based on the reported analysis.

This suggests a relationship between compensation bands and attrition in the dataset. However, compensation alone should not be assumed to cause employee departures. Job role, tenure, career opportunities, and other factors may also influence the observed pattern.

### 7.5 Attrition by Tenure

Employees with **0–1 years of tenure account for approximately 31% of departures**.

This highlights the importance of examining the early employee experience. Structured onboarding, regular feedback, role clarity, and early engagement reviews are potential areas for further investigation.

### 7.6 Training and Retention

Employees with three or more training sessions show approximately **18% lower attrition** in the reported analysis.

This association may justify further investigation into training accessibility, skill development, and employee engagement. It does not establish that training alone reduces attrition; additional factors may contribute to the difference.

## 8. Dashboard Features

### A. Workforce Overview
Presents headline workforce metrics and attrition indicators to help stakeholders understand the overall dataset at a glance.

### B. Attrition Breakdown
Explores attrition across departments, age groups, job roles, and salary bands to identify segments with different turnover patterns.

### C. Flight-Risk Analysis
Includes a six-factor, rule-based flight-risk scoring approach designed to prioritize employee segments for further analytical review.

The score is an exploratory prioritization mechanism, not a validated predictive model. It should not be interpreted as a definitive prediction that an individual employee will leave.

### D. Training and Retention Analysis
Examines how training participation relates to observed attrition patterns and helps identify questions for future workforce-development analysis.

### E. Interactive Filtering
Power BI slicers support exploration of the data by available dimensions, including department, age, and salary. This enables users to investigate particular workforce segments without rebuilding the analysis.

## 9. SQL Analysis

The project includes a collection of **10 SQL queries** covering common HR analytics use cases.

The analysis uses techniques such as:

- `SELECT`, `WHERE`, and `ORDER BY` for data exploration.
- `GROUP BY` and aggregate functions for KPI calculation.
- `CASE` expressions for categorizing employees into analytical segments.
- Common table expressions (CTEs) for organizing multi-step analysis.
- Window functions for comparative and ranked analysis.
- Conditional aggregation for comparing attrition across employee groups.

These queries demonstrate how SQL can convert employee-level records into structured outputs suitable for reporting and dashboard development.

## 10. Repository Structure

The repository is organized as follows:

```text
HR-Analytics-Dashboard/
│
├── hr_data.csv
├── analysis.sql
├── README.md
│
└── dashboard/
    └── HR_Analytics.pbix
```

### File descriptions

- **`hr_data.csv`** — Employee dataset used for the analysis.
- **`analysis.sql`** — SQL queries for calculating metrics and exploring attrition patterns.
- **`README.md`** — Project overview, methodology, findings, and setup instructions.
- **`dashboard/HR_Analytics.pbix`** — Power BI dashboard file.

## 11. How to Run the Project

### Prerequisites

Install or prepare the following tools:

- SQLite for executing the supplied SQL queries.
- Power BI Desktop for opening and exploring the dashboard.
- Python with Pandas and NumPy if you want to reproduce the Python-based data preparation.

### Step 1: Clone the Repository

```bash
git clone <YOUR_REPOSITORY_URL>
cd HR-Analytics-Dashboard
```

Replace `<YOUR_REPOSITORY_URL>` with the actual URL of your GitHub repository.

### Step 2: Prepare the SQL Database

Create a SQLite database and import the CSV data. One possible approach is to use SQLite's command-line interface:

```bash
sqlite3 hr.db
```

Inside the SQLite prompt, create or import a table from `hr_data.csv` using the `.import` command and the appropriate table schema. Ensure that the table name and column names match those referenced in `analysis.sql`.

### Step 3: Execute the SQL Queries

After creating the database and importing the data, exit the SQLite prompt and run:

```bash
sqlite3 hr.db < analysis.sql
```

The queries should run against the expected table and column structure. Review the query output to verify that the metrics match the dataset.

### Step 4: Open the Power BI Dashboard

1. Open Power BI Desktop.
2. Open `dashboard/HR_Analytics.pbix`.
3. If Power BI requests a data source, connect it to the supplied dataset or the location configured in the file.
4. Refresh the data if necessary.
5. Explore the dashboard using its charts, filters, and slicers.

**Note:** The exact import procedure depends on the schema and commands contained in `analysis.sql`. If your SQL file creates tables itself, follow its instructions rather than creating duplicate tables.

## 12. Business Recommendations

Based on the patterns identified in the dataset, the following areas could be explored further:

- **Strengthen early-tenure support:** Review onboarding processes, role clarity, and feedback mechanisms for employees in their first year.
- **Investigate high-attrition roles:** Examine working conditions, expectations, and career progression in job roles with comparatively higher turnover.
- **Review compensation patterns:** Compare compensation with job responsibilities, experience, and internal pay structures before drawing conclusions.
- **Evaluate training programs:** Assess whether training participation is associated with improved engagement, performance, and retention over time.
- **Monitor workforce indicators:** Use regular reporting to track attrition trends and investigate meaningful changes across employee segments.

These are data-informed investigation priorities, not claims that a particular intervention will necessarily reduce attrition.

## 13. Limitations and Responsible Use

This project is intended for analytical demonstration and learning.

- The findings depend on the dataset and its underlying definitions.
- Observed relationships do not establish causation.
- The rule-based flight-risk score is not a validated machine-learning model.
- The analysis should not be used to make employment decisions about individual employees.
- Any real-world HR deployment should include data privacy safeguards, appropriate access controls, validation, and human review.

The project demonstrates analytical workflows and dashboard design rather than a production-ready employee risk assessment system.

## 14. Skills Demonstrated

This project demonstrates practical experience in:

- HR analytics and workforce attrition analysis.
- KPI definition and metric interpretation.
- SQL querying, aggregation, segmentation, and window functions.
- Data preparation using Python, Pandas, and NumPy.
- Power BI dashboard development and interactive reporting.
- Exploratory analysis and business insight communication.
- GitHub-based project organization and documentation.

## 15. Future Enhancements

Potential future improvements include:

- Add a time-based attrition trend if reliable date fields become available.
- Incorporate additional employee engagement and exit-survey information.
- Validate the flight-risk scoring methodology against suitable historical outcomes.
- Add automated data-quality checks and repeatable data preparation.
- Develop a documented refresh process for updated datasets.
- Improve dashboard accessibility and provide more detailed metric definitions.

Any predictive model added in the future should be properly evaluated for accuracy, fairness, privacy, and appropriate use.

## 16. Conclusion

The HR Analytics Dashboard demonstrates how employee data can be transformed into useful workforce insights through SQL, Python, and Power BI.

By examining attrition across age groups, departments, job roles, salary bands, tenure, and training participation, the project provides a structured way to identify patterns that deserve further investigation.

It combines data preparation, analytical querying, interactive visualization, and business interpretation in a single project—showcasing practical skills relevant to Data Analyst, BI Analyst, and HR Analytics roles.

---

**Developed by Ritik Kumar Gupta**  
**Focus:** Data Analytics | Business Intelligence | HR Analytics

If you find this project useful, consider starring the repository on GitHub.
