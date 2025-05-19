-- Task 3: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) 
-- Solution 

-- create CTE to select active account for savings and investment.
WITH active_accounts AS (
    -- Combine savings and investment plans
    SELECT 
        id AS account_id,
        owner_id,
        'savings' AS account_type,
        last_charge_date AS last_transaction_date,
        status_id
    FROM plans_plan
    WHERE is_regular_savings = 1 -- Savings plans
    
    UNION ALL
    
    SELECT 
        id AS account_id,
        owner_id,
        'investment' AS account_type,
        last_charge_date AS last_transaction_date,
        status_id
    FROM plans_plan
    WHERE is_a_fund = 1  -- Investment plans
),
-- create CTE for the last transactionn date of each account.
recent_transactions AS (
    -- Get last transaction date for each account
    SELECT
        a.account_id,
        MAX(t.transaction_date) AS last_transaction_date
    FROM active_accounts a
    LEFT JOIN savings_savingsaccount t
        ON a.account_id = t.id
        -- AND t.transaction_type = 'deposit'
    WHERE a.status_id = 1  -- Active accounts
    GROUP BY a.account_id
)
-- Final flagged accounts
SELECT 
    a.account_id,
    a.account_type,
    a.owner_id,
    COALESCE(r.last_inflow_date, a.last_transaction_date) AS last_activity_date
FROM active_accounts a
LEFT JOIN recent_transactions r 
ON a.account_id = r.account_id
WHERE 
COALESCE(r.last_inflow_date, a.last_transaction_date) < CURRENT_DATE - INTERVAL 365 DAY OR r.last_inflow_date IS NULL;