# Oracle Database Management Projects

This repository contains three comprehensive Oracle-based database projects designed for hospital management, focusing on financial reporting, clinical analytics, and inventory loss prevention.

## Projects Overview

### 1. Hospital Revenue & Reporting System
An automated financial reporting system that aggregates daily hospital transactions across departments.
- **Key Feature:** Uses `MERGE` statements to efficiently archive monthly revenue, handling both new data insertion and existing record updates.
- **Goal:** To automate manual financial reporting and ensure data consistency.

### 2. Clinical Appointment & SLA Efficiency Analytics
A clinical management system designed to track appointment performance and wait-time trends.
- **Key Feature:** Implements Advanced SQL Window Functions (`DENSE_RANK`, `LAG`) to rank doctor efficiency and monitor Service Level Agreement (SLA) violations.
- **Goal:** To provide actionable insights for improving patient wait times and clinic congestion.

### 3. Smart Inventory Management & Loss Prevention
An automated inventory engine that manages medical stock and identifies financial risks.
- **Key Feature:** Uses PL/SQL Cursors to perform real-time stock analysis, triggering automated expiry alerts and dynamic price discounts.
- **Goal:** To minimize financial losses due to expired medicine and optimize supply chain operations.

## Tech Stack
* **Database:** Oracle 21c
* **Languages:** SQL, PL/SQL
* **Methodologies:** 3NF Database Normalization, Procedural Automation, Analytical Querying

## Repository Structure
- `/Hospital-Revenue-System` - DDL scripts, Transaction data, and Revenue Procedures.
- `/Clinical-Appointment-System` - Schema definitions and SLA Analytics queries.
- `/Smart-Inventory-System` - Inventory tables, Alerts logic, and Loss Prevention Procedures.

## How to use
1. Connect to your Oracle SQL Developer/SQL Plus instance.
2. Navigate to the specific project folder.
3. Run the provided `.sql` scripts in the order: Schema Setup -> Data Insertion -> Procedure/Analytics Deployment.
4. Execute the provided demo queries to analyze the results.

---
*Developed for advanced database management, performance optimization, and business logic automation.*
