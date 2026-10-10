-- ============================================================
-- HR Analytics — Attrition & Workforce Intelligence
-- Author: Ritik Kumar Gupta
-- Dataset: 1,470 employee records across 3 departments
-- Tool: SQLite / PostgreSQL / MySQL compatible
-- ============================================================


-- TABLE SETUP
CREATE TABLE hr_data (
    EmployeeID            INTEGER PRIMARY KEY,
    Age                   INTEGER,
    Department            VARCHAR(50),
    JobRole               VARCHAR(50),
    Education             INTEGER,
    EducationField        VARCHAR(50),
    Gender                VARCHAR(10),
    MaritalStatus         VARCHAR(15),
    BusinessTravel        VARCHAR(20),
    MonthlyIncome         INTEGER,
    AnnualSalary          INTEGER,
    OverTime              VARCHAR(5),
    JobSatisfaction       INTEGER,
    WorkLifeBalance       INTEGER,
    PerformanceRating     INTEGER,
    YearsAtCompany        INTEGER,
    YearsInCurrentRole    INTEGER,
    YearsWithCurrManager  INTEGER,
    TrainingTimesLastYear INTEGER,
    NumCompaniesWorked    INTEGER,
    Attrition             VARCHAR(5),
    DistanceFromHome      INTEGER,
    StockOptionLevel      INTEGER,
    JobLevel              INTEGER,
    EnvironmentSatisfaction INTEGER,
    RelationshipSatisfaction INTEGER
);


-- ============================================================
-- Q1: OVERALL ATTRITION SNAPSHOT
-- The headline number every HR dashboard needs
-- ============================================================
SELECT
    COUNT(*)                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN Attrition = 'No'  THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
    2) AS attrition_rate_pct,
    ROUND(AVG(AnnualSalary), 0)                      AS avg_annual_salary,
    ROUND(AVG(Age), 1)                               AS avg_age,
    ROUND(AVG(YearsAtCompany), 1)                    AS avg_tenure_years
FROM hr_data;


-- ============================================================
-- Q2: ATTRITION BY DEPARTMENT
-- Which team is bleeding talent?
-- ============================================================
SELECT
    Department,
    COUNT(*)                                                           AS headcount,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)               AS left_count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / COUNT(*), 1)                                               AS attrition_pct,
    ROUND(AVG(AnnualSalary), 0)                                       AS avg_salary,
    ROUND(AVG(JobSatisfaction), 2)                                    AS avg_satisfaction
FROM hr_data
GROUP BY Department
ORDER BY attrition_pct DESC;


-- ============================================================
-- Q3: AGE GROUP ANALYSIS
-- Young employees leave more — by how much?
-- ============================================================
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25 (Early Career)'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35 (Growth Phase)'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45 (Experienced)'
        ELSE '46+ (Senior)'
    END AS age_group,
    COUNT(*)                                                           AS headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / COUNT(*), 1)                                               AS attrition_pct,
    ROUND(AVG(AnnualSalary), 0)                                       AS avg_salary,
    ROUND(AVG(YearsAtCompany), 1)                                     AS avg_tenure
FROM hr_data
GROUP BY age_group
ORDER BY MIN(Age);


-- ============================================================
-- Q4: SALARY BAND vs ATTRITION
-- Does paying more actually retain people?
-- ============================================================
SELECT
    CASE
        WHEN AnnualSalary < 40000  THEN 'Under $40K'
        WHEN AnnualSalary < 60000  THEN '$40K-$60K'
        WHEN AnnualSalary < 80000  THEN '$60K-$80K'
        WHEN AnnualSalary < 100000 THEN '$80K-$100K'
        ELSE 'Over $100K'
    END AS salary_band,
    COUNT(*)                                                           AS headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / COUNT(*), 1)                                               AS attrition_pct,
    ROUND(AVG(JobSatisfaction), 2)                                    AS avg_satisfaction
FROM hr_data
GROUP BY salary_band
ORDER BY MIN(AnnualSalary);


-- ============================================================
-- Q5: WINDOW FUNCTION — Salary rank within department
-- Who's underpaid relative to peers?
-- ============================================================
SELECT
    EmployeeID,
    Department,
    JobRole,
    AnnualSalary,
    RANK() OVER (PARTITION BY Department ORDER BY AnnualSalary DESC) AS salary_rank_in_dept,
    ROUND(AVG(AnnualSalary) OVER (PARTITION BY Department), 0)       AS dept_avg_salary,
    ROUND(AnnualSalary - AVG(AnnualSalary)
          OVER (PARTITION BY Department), 0)                          AS vs_dept_avg,
    Attrition
FROM hr_data
ORDER BY Department, salary_rank_in_dept
LIMIT 20;


-- ============================================================
-- Q6: HIGH FLIGHT RISK EMPLOYEES
-- CTE to identify employees most likely to leave
-- ============================================================
WITH risk_scores AS (
    SELECT
        EmployeeID,
        Department,
        JobRole,
        Age,
        AnnualSalary,
        JobSatisfaction,
        WorkLifeBalance,
        YearsAtCompany,
        OverTime,
        Attrition,
        -- Build a flight risk score
        (CASE WHEN Age < 30 THEN 2 ELSE 0 END
         + CASE WHEN AnnualSalary < 50000 THEN 3 ELSE 0 END
         + CASE WHEN JobSatisfaction <= 2 THEN 3 ELSE 0 END
         + CASE WHEN WorkLifeBalance = 1 THEN 2 ELSE 0 END
         + CASE WHEN YearsAtCompany < 2 THEN 2 ELSE 0 END
         + CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END
        ) AS flight_risk_score
    FROM hr_data
),
ranked AS (
    SELECT *,
        RANK() OVER (ORDER BY flight_risk_score DESC) AS risk_rank,
        CASE
            WHEN flight_risk_score >= 8 THEN 'CRITICAL'
            WHEN flight_risk_score >= 5 THEN 'HIGH'
            WHEN flight_risk_score >= 3 THEN 'MEDIUM'
            ELSE 'LOW'
        END AS risk_level
    FROM risk_scores
)
SELECT
    EmployeeID, Department, JobRole, Age, AnnualSalary,
    JobSatisfaction, flight_risk_score, risk_level, Attrition
FROM ranked
WHERE risk_level IN ('CRITICAL', 'HIGH')
ORDER BY flight_risk_score DESC
LIMIT 15;


-- ============================================================
-- Q7: TRAINING IMPACT ON RETENTION
-- Does investing in training reduce attrition?
-- ============================================================
SELECT
    TrainingTimesLastYear,
    COUNT(*)                                                           AS employees,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / COUNT(*), 1)                                               AS attrition_pct,
    ROUND(AVG(PerformanceRating), 2)                                  AS avg_performance,
    ROUND(AVG(AnnualSalary), 0)                                       AS avg_salary
FROM hr_data
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear;


-- ============================================================
-- Q8: GENDER PAY & SATISFACTION ANALYSIS
-- ============================================================
SELECT
    Gender,
    Department,
    COUNT(*)                        AS headcount,
    ROUND(AVG(AnnualSalary), 0)    AS avg_salary,
    ROUND(AVG(JobSatisfaction), 2) AS avg_satisfaction,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / COUNT(*), 1)            AS attrition_pct
FROM hr_data
GROUP BY Gender, Department
ORDER BY Department, Gender;


-- ============================================================
-- Q9: TENURE BANDS — When do people leave?
-- ============================================================
SELECT
    CASE
        WHEN YearsAtCompany = 0 THEN '0 (New Hire)'
        WHEN YearsAtCompany BETWEEN 1 AND 2  THEN '1-2 years'
        WHEN YearsAtCompany BETWEEN 3 AND 5  THEN '3-5 years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
        ELSE '10+ years'
    END AS tenure_band,
    COUNT(*)                                                           AS headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / COUNT(*), 1)                                               AS attrition_pct,
    ROUND(AVG(AnnualSalary), 0)                                       AS avg_salary
FROM hr_data
GROUP BY tenure_band
ORDER BY MIN(YearsAtCompany);


-- ============================================================
-- Q10: EXECUTIVE RETENTION SUMMARY
-- The final view for the Power BI dashboard header
-- ============================================================
SELECT
    Department,
    JobRole,
    COUNT(*)                                                           AS headcount,
    ROUND(AVG(AnnualSalary), 0)                                       AS avg_salary,
    ROUND(AVG(JobSatisfaction), 1)                                    AS satisfaction,
    ROUND(AVG(WorkLifeBalance), 1)                                    AS work_life_balance,
    ROUND(AVG(YearsAtCompany), 1)                                     AS avg_tenure,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)               AS attrition_count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / COUNT(*), 1)                                               AS attrition_pct,
    CASE
        WHEN ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
             / COUNT(*), 1) >= 15 THEN 'Critical'
        WHEN ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
             / COUNT(*), 1) >= 10 THEN 'High Risk'
        WHEN ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
             / COUNT(*), 1) >= 5  THEN 'Moderate'
        ELSE 'Stable'
    END AS retention_status
FROM hr_data
GROUP BY Department, JobRole
ORDER BY attrition_pct DESC;