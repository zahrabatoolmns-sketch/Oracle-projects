
DROP TABLE Appointments;
DROP TABLE Patients;
DROP TABLE Doctors;

-- 1. Patients Table
CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR2(100),
    Age INT,
    Gender VARCHAR2(10)
);

-- 2. Doctors Table
CREATE TABLE Doctors (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR2(100),
    Specialty VARCHAR2(50)
);

-- 3. Appointments Table
CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT REFERENCES Patients(Patient_ID),
    Doctor_ID INT REFERENCES Doctors(Doctor_ID),
    Appointment_Date DATE,
    Check_In_Time TIMESTAMP,   
    See_Doctor_Time TIMESTAMP, 
    Status VARCHAR2(20)        
);

-- Step 1: Patients Data
INSERT INTO Patients VALUES (1, 'Ali Khan', 28, 'Male');
INSERT INTO Patients VALUES (2, 'Ayesha Ahmed', 34, 'Female');
INSERT INTO Patients VALUES (3, 'Zainab Bibi', 60, 'Female');
INSERT INTO Patients VALUES (4, 'Usman Bilal', 45, 'Male');
INSERT INTO Patients VALUES (5, 'Haroon', 35, 'Male');
INSERT INTO Patients VALUES (6, 'Aleena', 46, 'Female');
INSERT INTO Patients VALUES (7, 'Rashda', 53, 'Female');
INSERT INTO Patients VALUES (8, 'Zain', 15, 'Male');
INSERT INTO Patients VALUES (9, 'Muhammad Ubaid', 39, 'Male');
INSERT INTO Patients VALUES (10, 'Abid Ali', 35, 'Male');

-- Step 2: Doctors Data
INSERT INTO Doctors VALUES (101, 'Dr. Asif', 'Cardiology');
INSERT INTO Doctors VALUES (102, 'Dr. Amna', 'Pediatrics');
INSERT INTO Doctors VALUES (103, 'Dr. Rizwan', 'General Medicine');

-- Step 3: Appointments Data
INSERT INTO Appointments VALUES (501, 1, 101, TO_DATE('2026-06-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-25 09:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (502, 2, 102, TO_DATE('2026-06-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-25 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-25 09:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (503, 3, 101, TO_DATE('2026-06-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-25 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (504, 4, 103, TO_DATE('2026-06-26', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-26 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-26 14:42:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (505, 5, 101, TO_DATE('2026-06-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-28 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-28 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (506, 6, 102, TO_DATE('2026-06-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-28 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-28 11:55:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (507, 7, 103, TO_DATE('2026-06-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-28 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-28 15:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (508, 8, 101, TO_DATE('2026-06-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-29 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-29 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (509, 9, 102, TO_DATE('2026-06-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-29 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-29 14:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
INSERT INTO Appointments VALUES (510, 10, 103, TO_DATE('2026-06-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2026-06-29 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-06-29 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed');
COMMIT;
SELECT 
    a.Appointment_ID,
    p.Patient_Name,
    d.Doctor_Name,
    ROUND((CAST(a.See_Doctor_Time AS DATE) - CAST(a.Check_In_Time AS DATE)) * 1440, 1) AS Wait_Time_Minutes,
    CASE 
        WHEN (CAST(a.See_Doctor_Time AS DATE) - CAST(a.Check_In_Time AS DATE)) * 1440 <= 15 THEN 'Excellent (<15m)'
        WHEN (CAST(a.See_Doctor_Time AS DATE) - CAST(a.Check_In_Time AS DATE)) * 1440 <= 30 THEN 'Acceptable (15-30m)'
        ELSE 'SLA Violated (>30m)'
    END AS SLA_Status
FROM Appointments a
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
WHERE a.Status = 'Completed';

SELECT 
    EXTRACT(HOUR FROM TO_TIMESTAMP(TO_CHAR(Check_In_Time, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS')) AS Arrival_Hour,
    COUNT(Appointment_ID) AS Total_Patients,
    ROUND(AVG(
        EXTRACT(DAY FROM (See_Doctor_Time - Check_In_Time)) * 1440 +
        EXTRACT(HOUR FROM (See_Doctor_Time - Check_In_Time)) * 60 +
        EXTRACT(MINUTE FROM (See_Doctor_Time - Check_In_Time))
    ), 1) AS Avg_Wait_Time_Minutes
FROM Appointments
WHERE Status = 'Completed'
GROUP BY EXTRACT(HOUR FROM TO_TIMESTAMP(TO_CHAR(Check_In_Time, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS'))
ORDER BY Total_Patients DESC; 

WITH Patient_Wait_Times AS (
    -- Step 1: We have to calculate wait time of every patient
    SELECT 
        a.Appointment_ID,
        d.Doctor_ID,
        d.Doctor_Name,
        d.Specialty,
        ROUND(
            EXTRACT(DAY FROM (a.See_Doctor_Time - a.Check_In_Time)) * 1440 +
            EXTRACT(HOUR FROM (a.See_Doctor_Time - a.Check_In_Time)) * 60 +
            EXTRACT(MINUTE FROM (a.See_Doctor_Time - a.Check_In_Time)), 1
        ) AS Patient_Wait_Time
    FROM Appointments a
    JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
    WHERE a.Status = 'Completed'
)
-- Step 2:
SELECT 
    Appointment_ID,
    Doctor_Name,
    Specialty,
    Patient_Wait_Time,
    -- Overall avg wait time of doctors
    ROUND(AVG(Patient_Wait_Time) OVER(PARTITION BY Doctor_ID), 1) AS Doctor_Avg_Wait_Time,
    DENSE_RANK() OVER(
        PARTITION BY Specialty 
        ORDER BY Patient_Wait_Time ASC
    ) AS Efficiency_Rank_In_Specialty
FROM Patient_Wait_Times;


WITH Monthly_Analytics AS (
    SELECT 
        TO_CHAR(Appointment_Date, 'YYYY-MM') AS Month,
        ROUND(AVG(EXTRACT(MINUTE FROM (See_Doctor_Time - Check_In_Time))), 1) AS Avg_Wait
    FROM Appointments
    WHERE Status = 'Completed'
    GROUP BY TO_CHAR(Appointment_Date, 'YYYY-MM')
)
SELECT 
    Month,
    Avg_Wait AS Current_Month_Avg_Wait,
    LAG(Avg_Wait, 1) OVER (ORDER BY Month) AS Previous_Month_Avg_Wait,
    (Avg_Wait - LAG(Avg_Wait, 1) OVER (ORDER BY Month)) AS Net_Change
FROM Monthly_Analytics;

SELECT * FROM Appointments;
SELECT * FROM Patients;
SELECT * FROM Doctors;

SELECT * FROM (
    SELECT p.Patient_Name, d.Doctor_Name, 
           ROUND((CAST(a.See_Doctor_Time AS DATE) - CAST(a.Check_In_Time AS DATE)) * 1440, 1) AS Wait_Time_Min,
           CASE 
               WHEN (CAST(a.See_Doctor_Time AS DATE) - CAST(a.Check_In_Time AS DATE)) * 1440 <= 15 THEN 'Excellent (<15m)'
               WHEN (CAST(a.See_Doctor_Time AS DATE) - CAST(a.Check_In_Time AS DATE)) * 1440 <= 30 THEN 'Acceptable (15-30m)'
               ELSE 'SLA Violated (>30m)'
           END AS SLA_Status
    FROM Appointments a
    JOIN Patients p ON a.Patient_ID = p.Patient_ID
    JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
) WHERE SLA_Status = 'SLA Violated (>30m)';

SELECT Doctor_Name, Specialty, Patient_Wait_Time, Efficiency_Rank_In_Specialty
FROM (
    SELECT d.Doctor_Name, d.Specialty, 
           ROUND(EXTRACT(MINUTE FROM (a.See_Doctor_Time - a.Check_In_Time)), 1) AS Patient_Wait_Time,
           DENSE_RANK() OVER(PARTITION BY d.Specialty ORDER BY (a.See_Doctor_Time - a.Check_In_Time) ASC) AS Efficiency_Rank_In_Specialty
    FROM Appointments a
    JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
) 
WHERE Efficiency_Rank_In_Specialty = 1;

WITH Monthly_Analytics AS (
    SELECT TO_CHAR(Appointment_Date, 'YYYY-MM') AS Month_Year,
           AVG(EXTRACT(MINUTE FROM (See_Doctor_Time - Check_In_Time)) + 
               EXTRACT(HOUR FROM (See_Doctor_Time - Check_In_Time)) * 60) AS Avg_Wait
    FROM Appointments
    WHERE Status = 'Completed'
    GROUP BY TO_CHAR(Appointment_Date, 'YYYY-MM')
)
SELECT Month_Year, 
       ROUND(Avg_Wait, 1) AS Current_Month_Avg,
       ROUND(LAG(Avg_Wait) OVER (ORDER BY Month_Year), 1) AS Prev_Month_Avg,
       ROUND(Avg_Wait - LAG(Avg_Wait) OVER (ORDER BY Month_Year), 1) AS Net_Change
FROM Monthly_Analytics;