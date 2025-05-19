# DataAnalytics-Assessment

_Data Analysis on SQL Proficiency Assessment_

**Task 1**

in solving this task, I applied the following steps:
- Identify customers who have at least one funded savings plan
- Identify customers who have at least one funded investment plan
- Find customers who meet both criteria
- Sort the by total deposits

**Task 2**

Steps involve in solvinng the task:
- Count transactions per customer per month
- Calculate the average transactions per month for each customer
- Categorize customers based on their average transaction frequency

**Task 3**

The following steps are applied to solve the task;
- Identify Active Accounts
- Find Last Transaction Date
- Apply 1-Year Inactivity Rule
- Fallback Logic: If no transactions exist, use last_charge_date from plans_plan as a proxy

**Task 4**

The following steps and logic is applied in solving the task
- Calculate Account Tenure for Months between account creation (created_on) and current date
- Sum Transaction Values  by aggregate all transaction amounts per customer  uising COALESCE to handle customers with no transactions
- apply the CLV Formula ((total_transactions / tenure_months) * 12 * 0.1%)
- use Case Handling to select GREATEST(tenure_months, 1) prevents division by zero
- LEFT JOINs ensure all customers are included



