-- =========================================================================
-- Phase 1: Automated Data Validation & Error-Checking Layer
-- Joins daily POS transactions with store metadata and flags anomalies
-- =========================================================================
CREATE VIEW vw_rossmann_error_checking AS
SELECT 
    t.Store,
    s.StoreType,
    s.Assortment,
    t.Date,
    t.Sales,
    t.Customers,
    t.Open,
    t.Promo,
    -- Automated Validation Logic to secure data integrity
    CASE 
        WHEN t.Store IS NULL THEN 'ERROR: Missing Store ID'
        WHEN t.Open = 1 AND t.Sales = 0 THEN 'ERROR: Open Store with Zero Sales'
        WHEN t.Sales < 0 THEN 'ERROR: Negative Sales'
        WHEN t.Customers < 0 THEN 'ERROR: Negative Customer Count'
        ELSE 'VALID'
    END AS integrity_flag
FROM train t
LEFT JOIN store s ON t.Store = s.Store;

-- =========================================================================
-- Phase 2: Multi-Store Statistical Reporting & Scorecard Layer
-- Quarantines invalid records and aggregates clean data by Store Type
-- =========================================================================
CREATE VIEW vw_rossmann_validated_mis AS
SELECT 
    StoreType,
    Store,
    COUNT(Date) as operating_days,
    SUM(Sales) AS total_revenue,
    SUM(Customers) AS total_customer_footfalls,
    ROUND(CAST(SUM(Sales) AS FLOAT) / NULLIF(SUM(Customers), 0), 2) AS average_basket_value,
    -- Tracks the exact number of operational/data anomalies caught by the system
    SUM(CASE WHEN integrity_flag != 'VALID' THEN 1 ELSE 0 END) AS data_errors_quarantined
FROM vw_rossmann_error_checking
WHERE integrity_flag = 'VALID' AND Open = 1
GROUP BY StoreType, Store;
