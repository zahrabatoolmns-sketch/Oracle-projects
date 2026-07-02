-- 1. Departments Table
CREATE TABLE hospital_departments (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL
);

-- 2. Daily Transactions Table 
CREATE TABLE daily_transactions (
    transaction_id NUMBER PRIMARY KEY,
    dept_id NUMBER REFERENCES hospital_departments(dept_id),
    amount NUMBER(10,2),
    transaction_date DATE DEFAULT SYSDATE
);

-- 3. Archive Table 
CREATE TABLE monthly_revenue_archive (
    archive_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    report_month VARCHAR2(7), -- Format: YYYY-MM
    dept_name VARCHAR2(50),
    total_revenue NUMBER(12,2),
    generated_at DATE DEFAULT SYSDATE
);

-- Departments insert karein
INSERT INTO hospital_departments VALUES (101, 'Pharmacy');
INSERT INTO hospital_departments VALUES (102, 'Radiology');
INSERT INTO hospital_departments VALUES (103, 'Laboratory');
-- Clinical / Main Treatment Departments
INSERT INTO hospital_departments VALUES (104, 'Cardiology');          
INSERT INTO hospital_departments VALUES (105, 'Pediatrics');          
INSERT INTO hospital_departments VALUES (106, 'Gynecology');          
INSERT INTO hospital_departments VALUES (107, 'Orthopedics');         
INSERT INTO hospital_departments VALUES (108, 'Neurology');           
INSERT INTO hospital_departments VALUES (109, 'General Surgery');    

-- Emergency & Critical Care
INSERT INTO hospital_departments VALUES (110, 'Emergency');           
INSERT INTO hospital_departments VALUES (111, 'ICU');                 
--june 2026 departments
INSERT INTO daily_transactions VALUES (1, 101, 15000.00, TO_DATE('2026-06-10', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (2, 102, 45000.00, TO_DATE('2026-06-15', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (3, 103, 20000.00, TO_DATE('2026-06-20', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (4, 104, 35000.00, TO_DATE('2026-06-25', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (5, 105, 12000.00, TO_DATE('2026-06-27', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (6, 106, 65000.00, TO_DATE('2026-06-28', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (7, 107, 8500.00,  TO_DATE('2026-06-28', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (8, 108, 17500.00, TO_DATE('2026-06-29', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (9, 109, 55000.00, TO_DATE('2026-06-29', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (10, 110, 22000.00, TO_DATE('2026-06-30', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (11, 111, 14000.00, TO_DATE('2026-06-30', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (12, 105, 18500.00, TO_DATE('2026-06-25', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (13, 106, 42000.00, TO_DATE('2026-06-26', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (14, 107, 29000.00, TO_DATE('2026-06-27', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (15, 108, 61000.00, TO_DATE('2026-06-28', 'YYYY-MM-DD'));

-- July 2026 Departments
INSERT INTO daily_transactions VALUES (16, 109, 88000.00, TO_DATE('2026-07-01', 'YYYY-MM-DD')); 
INSERT INTO daily_transactions VALUES (17, 101, 41000.00, TO_DATE('2026-07-01', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (18, 102, 30000.00, TO_DATE('2026-07-01', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (19, 103, 9500.00,  TO_DATE('2026-07-02', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (20, 104, 72000.00, TO_DATE('2026-07-02', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (21, 106, 33000.00, TO_DATE('2026-07-03', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (22, 107, 24000.00, TO_DATE('2026-07-04', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (23, 108, 50000.00, TO_DATE('2026-07-04', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (24, 109, 120000.00,TO_DATE('2026-07-05', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (25, 110, 35000.00, TO_DATE('2026-07-05', 'YYYY-MM-DD'));
INSERT INTO daily_transactions VALUES (26, 111, 78000.00, TO_DATE('2026-07-06', 'YYYY-MM-DD'));

COMMIT;

CREATE OR REPLACE PROCEDURE sp_archive_monthly_revenue AS
    v_current_month VARCHAR2(7);
BEGIN
    v_current_month := TO_CHAR(SYSDATE, 'YYYY-MM');
    
    MERGE INTO monthly_revenue_archive a
    USING (
        SELECT 
            v_current_month AS report_month,
            d.dept_name,
            NVL(src_tx.sub_total, 0) AS total_revenue
        FROM 
            hospital_departments d
        LEFT JOIN (
            SELECT dept_id, SUM(amount) AS sub_total
            FROM daily_transactions
            WHERE TO_CHAR(transaction_date, 'YYYY-MM') = v_current_month
            GROUP BY dept_id
        ) src_tx ON d.dept_id = src_tx.dept_id
    ) src
    ON (a.report_month = src.report_month AND a.dept_name = src.dept_name)
    WHEN MATCHED THEN
        UPDATE SET a.total_revenue = src.total_revenue, a.generated_at = SYSDATE
    WHEN NOT MATCHED THEN
        INSERT (report_month, dept_name, total_revenue)
        VALUES (src.report_month, src.dept_name, src.total_revenue);
        
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Success: All monthly department revenues updated/archived.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
SET SERVEROUTPUT ON;

EXEC sp_archive_monthly_revenue;

SELECT d.dept_name, SUM(t.amount) as total_revenue
FROM hospital_departments d
JOIN daily_transactions t ON d.dept_id = t.dept_id
GROUP BY d.dept_name
ORDER BY total_revenue DESC;

SELECT d.dept_name, a.total_revenue
FROM hospital_departments d
LEFT JOIN monthly_revenue_archive a ON d.dept_name = a.dept_name
WHERE a.report_month = '2026-07';

SELECT * FROM  hospital_departments ;
SELECT * FROM daily_transactions;
SELECT * FROM monthly_revenue_archive;