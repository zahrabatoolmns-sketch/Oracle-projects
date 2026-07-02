CREATE TABLE hospital_inventory (
    medicine_id NUMBER PRIMARY KEY,
    medicine_name VARCHAR2(100),
    batch_no VARCHAR2(50),
    quantity NUMBER,
    original_price NUMBER(10,2),  
    price_per_unit NUMBER(10,2),   
    expiry_date DATE
);

CREATE TABLE hospital_alerts (
    alert_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    medicine_id NUMBER,
    medicine_name VARCHAR2(100),
    alert_type VARCHAR2(30),
    alert_level VARCHAR2(20),
    details VARCHAR2(255),
    alert_date DATE DEFAULT SYSDATE
);
-- 3. Monthly Financial Loss Log
CREATE TABLE financial_loss_log (
    log_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    log_month_year VARCHAR2(20),
    total_loss_amount NUMBER(12,2),
    calculated_on DATE DEFAULT SYSDATE
);
-- 30 Medicines Insertion
INSERT INTO hospital_inventory VALUES (1, 'Paracetamol 500mg', 'B-P101', 500, 2.50, 2.50, TO_DATE('2026-07-10', 'YYYY-MM-DD')); -- Expiry Warning
INSERT INTO hospital_inventory VALUES (2, 'Amoxicillin 250mg', 'B-A102', 20, 15.00, 15.00,  TO_DATE('2026-07-15', 'YYYY-MM-DD'));  -- Low Stock + Expiry Warning
INSERT INTO hospital_inventory VALUES (3, 'Ibuprofen 400mg', 'B-I103', 350, 5.00, 5.00, TO_DATE('2026-07-28', 'YYYY-MM-DD'));  -- Expiry Warning
INSERT INTO hospital_inventory VALUES (4, 'Lipitor 10mg', 'B-L104', 150, 45.00, 45.00, TO_DATE('2026-08-15', 'YYYY-MM-DD'));   -- Safe
INSERT INTO hospital_inventory VALUES (5, 'Metformin 850mg', 'B-M105', 600, 8.00, 8.00,  TO_DATE('2026-06-25', 'YYYY-MM-DD'));   -- Expired in June
INSERT INTO hospital_inventory VALUES (6, 'Omeprazole 20mg', 'B-O106', 400, 12.50, 12.50,  TO_DATE('2026-07-02', 'YYYY-MM-DD'));  -- Critical Expiry (2 days remaining)
INSERT INTO hospital_inventory VALUES (7, 'Augmentin 625mg', 'B-A107', 15, 35.00, 35.00,  TO_DATE('2026-09-01', 'YYYY-MM-DD'));   -- Low Stock Only
INSERT INTO hospital_inventory VALUES (8, 'Panadol Extra', 'B-P108', 800, 3.00, 3.00, TO_DATE('2026-07-12', 'YYYY-MM-DD'));    -- Expiry Warning
INSERT INTO hospital_inventory VALUES (9, 'Flagyl 400mg', 'B-F109', 450, 4.50, 4.50, TO_DATE('2026-07-20', 'YYYY-MM-DD'));    -- Expiry Warning
INSERT INTO hospital_inventory VALUES (10, 'Cravit 500mg', 'B-C110', 120, 65.00, 65.00, TO_DATE('2026-10-10', 'YYYY-MM-DD'));   -- Safe

INSERT INTO hospital_inventory VALUES (11, 'Arinac Forte', 'B-A111', 300, 6.00, 6.00, TO_DATE('2026-07-05', 'YYYY-MM-DD'));   -- Critical Expiry (5 days remaining)
INSERT INTO hospital_inventory VALUES (12, 'Brufen Syrup', 'B-B112', 150, 45.00, 45.00, TO_DATE('2026-07-24', 'YYYY-MM-DD'));   -- Expiry Warning
INSERT INTO hospital_inventory VALUES (13, 'Disprin 300mg', 'B-D113', 1000, 1.50, 1.50, TO_DATE('2026-06-18', 'YYYY-MM-DD'));  -- Expired in June
INSERT INTO hospital_inventory VALUES (14, 'Ascard 75mg', 'B-A114', 500, 2.00, 2.00,  TO_DATE('2026-12-25', 'YYYY-MM-DD'));    -- Safe
INSERT INTO hospital_inventory VALUES (15, 'Surbex-Z', 'B-S115', 250, 18.00, 18.00, TO_DATE('2026-07-18', 'YYYY-MM-DD'));    -- Expiry Warning
INSERT INTO hospital_inventory VALUES (16, 'Cac-1000 Plus', 'B-C116', 180, 30.00, 30.00, TO_DATE('2026-08-30', 'YYYY-MM-DD'));  -- Safe
INSERT INTO hospital_inventory VALUES (17, 'Softin 10mg', 'B-S117', 400, 11.00, 11.00, TO_DATE('2026-07-29', 'YYYY-MM-DD'));   -- Expiry Warning
INSERT INTO hospital_inventory VALUES (18, 'Entamizole DS', 'B-E118', 220, 9.50, 9.50, TO_DATE('2026-07-08', 'YYYY-MM-DD'));   -- Critical Expiry
INSERT INTO hospital_inventory VALUES (19, 'Ventolin Inhaler', 'B-V119', 8, 120.00, 120.00, TO_DATE('2026-09-15', 'YYYY-MM-DD'));  -- Critical Low Stock
INSERT INTO hospital_inventory VALUES (20, 'Risek 40mg', 'B-R120', 150, 28.00, 28.00, TO_DATE('2026-07-14', 'YYYY-MM-DD'));    -- Expiry Warning

INSERT INTO hospital_inventory VALUES (21, 'Polyfax Ointment', 'B-P121', 90, 40.00, 40.00, TO_DATE('2026-07-22', 'YYYY-MM-DD'));  -- Expiry Warning
INSERT INTO hospital_inventory VALUES (22, 'Gaviscon Liquid', 'B-G122', 70, 95.00, 95.00, TO_DATE('2026-06-05', 'YYYY-MM-DD'));  -- Expired in June
INSERT INTO hospital_inventory VALUES (23, 'Zyrtec 10mg', 'B-Z123', 350, 14.00, 14.00, TO_DATE('2026-07-17', 'YYYY-MM-DD'));   -- Expiry Warning
INSERT INTO hospital_inventory VALUES (24, 'Avil Injection', 'B-A124', 200, 15.00,15.00,  TO_DATE('2026-11-01', 'YYYY-MM-DD'));  -- Safe
INSERT INTO hospital_inventory VALUES (25, 'Xanax 0.5mg', 'B-X125', 100, 8.00, 8.00, TO_DATE('2026-07-26', 'YYYY-MM-DD'));    -- Expiry Warning
INSERT INTO hospital_inventory VALUES (26, 'Insulin Mixtard', 'B-I126', 40, 450.00, 450.00, TO_DATE('2026-07-03', 'YYYY-MM-DD')); -- Critical Expiry + Low Stock
INSERT INTO hospital_inventory VALUES (27, 'Epival 250mg', 'B-E127', 180, 22.00, 22.00, TO_DATE('2026-08-05', 'YYYY-MM-DD'));   -- Safe
INSERT INTO hospital_inventory VALUES (28, 'Klaracid 250mg', 'B-K128', 130, 55.00, 55.00, TO_DATE('2026-07-11', 'YYYY-MM-DD'));  -- Expiry Warning
INSERT INTO hospital_inventory VALUES (29, 'Rocephin 1g', 'B-R129', 60, 320.00, 320.00, TO_DATE('2026-07-31', 'YYYY-MM-DD'));    -- Expiry Warning
INSERT INTO hospital_inventory VALUES (30, 'Thyroxin 50mcg', 'B-T130', 500, 1.80, 1.80, TO_DATE('2027-01-10', 'YYYY-MM-DD'));  -- Safe (Next Year)

COMMIT;

CREATE OR REPLACE PROCEDURE monitor_hospital_inventory AS
    v_days NUMBER;
BEGIN
    -- 1.  (Cursor Implementation)
    FOR r IN (SELECT * FROM hospital_inventory) LOOP
        v_days := ROUND(r.expiry_date - SYSDATE);
        
        -- Critical Alert: Expiring within 7 days (Give 50% discount to sell fast)
        IF v_days > 0 AND v_days <= 7 THEN
            INSERT INTO hospital_alerts (medicine_id, medicine_name, alert_type, alert_level, details)
            VALUES (r.medicine_id, r.medicine_name, 'EXPIRY', 'CRITICAL', 'Expires in ' || v_days || ' days! 50% discount applied.');
            
            UPDATE hospital_inventory 
            SET price_per_unit = price_per_unit * 0.50
            WHERE medicine_id = r.medicine_id;
            
        -- Warning Alert: Expiring within 8-30 days (Give 20% discount)
        ELSIF v_days > 7 AND v_days <= 30 THEN
            INSERT INTO hospital_alerts (medicine_id, medicine_name, alert_type, alert_level, details)
            VALUES (r.medicine_id, r.medicine_name, 'EXPIRY', 'WARNING', 'Expires in ' || v_days || ' days. 20% discount applied.');
            
            UPDATE hospital_inventory 
            SET price_per_unit = price_per_unit * 0.80
            WHERE medicine_id = r.medicine_id;
            
        -- Already Expired
        ELSIF v_days <= 0 THEN
            INSERT INTO hospital_alerts (medicine_id, medicine_name, alert_type, alert_level, details)
            VALUES (r.medicine_id, r.medicine_name, 'EXPIRY', 'CRITICAL', 'MEDICINE EXPIRED! Remove from shelf immediately.');
        END IF;

        -- 2. Low Stock Monitor Feature
        IF r.quantity <= 20 THEN
            INSERT INTO hospital_alerts (medicine_id, medicine_name, alert_type, alert_level, details)
            VALUES (r.medicine_id, r.medicine_name, 'LOW STOCK', 'CRITICAL', 'Stock level low (' || r.quantity || ' units left). Reorder required.');
        ELSIF r.quantity > 20 AND r.quantity <= 50 THEN
            INSERT INTO hospital_alerts (medicine_id, medicine_name, alert_type, alert_level, details)
            VALUES (r.medicine_id, r.medicine_name, 'LOW STOCK', 'INFO', 'Stock level moderate (' || r.quantity || ' units left).');
        END IF;
        
    END LOOP;
    
    -- 3. Financial Loss Report Generator Feature
    INSERT INTO financial_loss_log (log_month_year, total_loss_amount)
    SELECT TO_CHAR(SYSDATE, 'MON-YYYY'), SUM(quantity * price_per_unit)
    FROM hospital_inventory
    WHERE expiry_date <= SYSDATE;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inventory Monitoring and Financial Loss Engine executed successfully.');
END;
/

EXEC monitor_hospital_inventory;

SELECT alert_level, medicine_name, details 
FROM hospital_alerts 
WHERE alert_type = 'EXPIRY'
ORDER BY DECODE(alert_level, 'CRITICAL', 1, 'WARNING', 2);

SELECT medicine_name, original_price, price_per_unit AS discounted_price, expiry_date 
FROM hospital_inventory 
WHERE price_per_unit < original_price;

SELECT medicine_name, original_price, price_per_unit AS discounted_price, expiry_date 
FROM hospital_inventory 
WHERE medicine_id IN (1, 6);

SELECT medicine_name, COUNT(*) as alert_count 
FROM hospital_alerts 
GROUP BY medicine_name 
HAVING COUNT(*) > 1;

SELECT * FROM financial_loss_log;