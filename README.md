
PlanetKart Analytics Mini-Universe
Data Engineering Assignment — dbt + Snowflake + Airbyte
1. Project Overview
This project implements a data pipeline and warehouse for PlanetKart, a fictional interplanetary e-commerce company. Using Airbyte for ingestion, Snowflake as the data warehouse, and dbt for transformation and modeling, the pipeline supports analytics needs with a star schema design, data quality tests, and SCD snapshots.

2. Steps Followed
Step 1: Data Ingestion with Airbyte
Configured Airbyte Google Sheets connector to ingest raw CSV data into Snowflake under the schema PLANETKART_RAW.

Ingested five datasets: customers, orders, order_items, products, and regions.


<img width="288" height="212" alt="Screenshot 2025-07-21 at 11 29 17 PM" src="https://github.com/user-attachments/assets/e5f0d18f-ae1d-431d-bd83-a18725557ee3" />

<img width="775" height="342" alt="Screenshot 2025-07-21 at 11 30 59 PM" src="https://github.com/user-attachments/assets/caef1689-60b8-4418-a89e-926d4721acf2" />
<img width="799" height="307" alt="Screenshot 2025-07-21 at 11 31 19 PM" src="https://github.com/user-attachments/assets/906d5fc1-83fb-46e0-8755-1d136ea3621f" />
<img width="814" height="374" alt="Screenshot 2025-07-21 at 11 31 40 PM" src="https://github.com/user-attachments/assets/d20c952e-4eaa-4dde-b3a2-4c4aeeb36180" />
<img width="764" height="305" alt="Screenshot 2025-07-21 at 11 33 28 PM" src="https://github.com/user-attachments/assets/5332395d-eab3-4725-a0f2-9572257f6815" />
<img width="885" height="323" alt="Screenshot 2025-07-21 at 11 33 51 PM" src="https://github.com/user-attachments/assets/b8897f2f-fbf8-4c4c-ba47-5f7244777997" />


#airbyte setup#


<img width="617" height="491" alt="Screenshot 2025-07-21 at 11 34 50 PM" src="https://github.com/user-attachments/assets/0f4a054a-6eb6-47a2-9469-3bf60baf1624" />

<img width="1232" height="779" alt="Screenshot 2025-07-21 at 11 36 35 PM" src="https://github.com/user-attachments/assets/4d710200-4e00-46d1-ad09-17b47102db22" />

<img width="606" height="360" alt="Screenshot 2025-07-21 at 11 35 41 PM" src="https://github.com/user-attachments/assets/54820307-f53d-41ee-bb6d-7a8df6728033" />
<img width="1234" height="535" alt="Screenshot 2025-07-21 at 11 36 11 PM" src="https://github.com/user-attachments/assets/8b415d9a-d026-4747-860f-2ce8011f07af" />

Step 2: Initialize dbt Project & Configure Snowflake Connection

Created a dbt project with dbt init planetkart_dbt.

Set up profiles.yml with Snowflake credentials (user, role, warehouse, database, schema).

Verified connection using dbt debug.

Step 3: Create Staging Models
Built staging models (stg_customers.sql, stg_orders.sql, etc.) in models/staging/.

Staging models transform raw data into cleaned, consistent views.

Materialized as views for performance and modularity.

Example command:

dbt run --select stg_customers

<img width="590" height="231" alt="Screenshot 2025-07-22 at 12 00 36 AM" src="https://github.com/user-attachments/assets/1c00beaa-b29b-4dc9-95ef-16269f840e81" />




Step 4: Create Analytics Models (Dimensions and Fact)
Created dimensional models (dim_customers.sql, dim_products.sql, dim_regions.sql) in models/analytics/.

Created fact table fact_orders.sql aggregating order line data.

Used surrogate keys generated via dbt_utils.generate_surrogate_key() for joins and SCD management.

Materialized as tables.<img width="595" height="222" alt="Screenshot 2025-07-22 at 12 00 57 AM" src="https://github.com/user-attachments/assets/81ae6bf3-3a77-4415-a4c2-427da5eb2bb7" />

Example command:


dbt run --select dim_customers
Step 5: Add Tests and Snapshots
Added dbt tests in schema.yml for not_null, unique keys, and accepted_values (e.g., order status).




Created snapshot model customers_snapshot.sql to track changes (SCD Type 2) in customer data.

Example commands:

dbt test
dbt snapshot --select customers_snapshot


![Uploading Screenshot 2025-07-22 at 6.59.22 AM.png…]()

3. Design Decisions & Reasoning

Star Schema: To simplify querying and analytics, fact table linked to dimensions for customers, products, and regions.

Surrogate Keys: Used generated keys for efficient joins and to support Slowly Changing Dimensions.

Materializations: Views used for staging to keep transformations modular and maintainable. Tables used for analytics models for query performance.

dbt Tests: Ensure data quality and integrity during transformations.

Snapshots: Implemented for tracking historical changes to customer data (e.g., email changes, region).

4. How to Run & Test the Project
Clone repo:


git clone https://github.com/sidcrz/planetkart_dbt.git
cd planetkart_dbt
Configure Snowflake credentials in ~/.dbt/profiles.yml.

Install dependencies:

dbt deps
Run all models:

dbt run
Run tests:

dbt test
Run snapshots:

dbt snapshot



