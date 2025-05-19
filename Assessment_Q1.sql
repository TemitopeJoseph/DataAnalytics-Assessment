
-- Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

SELECT 
    p.owner_id,
    u.name,
	COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 AND p.amount > 0 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 AND p.amount > 0 THEN p.id END) AS investment_count,
    COALESCE(SUM(CASE WHEN p.is_a_fund = 1 THEN p.amount END), 0) +
    COALESCE(SUM(CASE WHEN s.amount > 0 THEN s.amount END), 0) AS total_deposits
FROM 
    users_customuser u
left JOIN 
    plans_plan p ON u.id = p.owner_id
left JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
GROUP BY 
     p.owner_id, u.name
HAVING 
   savings_count > 0 AND investment_count > 0
ORDER BY 
    total_deposits DESC;
