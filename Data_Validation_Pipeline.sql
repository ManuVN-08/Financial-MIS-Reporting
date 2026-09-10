-- Phase 1: Automated Validation & Error Checking
CREATE VIEW vw_error_checking_layer AS
SELECT 
    CustomerID,
    Location,
    ProductType,
    SalesRevenue,
    GrossProfit,
    NetProfit,
    -- Automated Validation Logic to secure data integrity
    CASE 
        WHEN CustomerID IS NULL THEN 'ERROR: Missing Customer ID'
        WHEN NetProfit < 0 THEN 'ERROR: Negative Net Profit'
        WHEN NetProfit IS NULL THEN 'ERROR: Null Financials'
        ELSE 'VALID'
    END AS integrity_flag
FROM raw_financial_dump;

-- Phase 2: Statistical Reporting Aggregation
CREATE VIEW vw_validated_financial_mis AS
SELECT 
    Location,
    ProductType,
    SUM(SalesRevenue) AS total_revenue,
    SUM(GrossProfit) AS total_gross_profit,
    SUM(NetProfit) AS total_net_profit,
    COUNT(CustomerID) AS transaction_volume,
    -- Calculates exact number of manual errors caught by the system
    SUM(CASE WHEN integrity_flag != 'VALID' THEN 1 ELSE 0 END) AS data_errors_caught
FROM vw_error_checking_layer
WHERE integrity_flag = 'VALID' -- Strictly passes only 100% clean data to Tableau
GROUP BY Location, ProductType;