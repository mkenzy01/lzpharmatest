-- Partioning
-- This code  below is to create an exact copy of the orders table and to partition it by order_datetime
CREATE TABLE operations.order_partitioned (
	LIKE operations.orders INCLUDING DEFAULTS
) PARTITION BY RANGE (order_datetime);

SELECT * FROM operations.order_partitioned

-- ADD CONSTRAINT JUST LIKE IT WAS IN THE TABLE WE COPIED FROM
ALTER TABLE operations.order_partitioned
ADD CONSTRAINT check_total_amount CHECK (total_amount >= 0)


/* ALTER THE PARTITIONED TABLE TO ACCEPT BOTH order_id and order_date as the Primary keys; making this a COMPOSITE
Primary Key, see glossary (coming soon) for more information */

ALTER TABLE operations.order_partitioned
ADD PRIMARY KEY (order_id, order_datetime);

-- Recreate the foreign KEYS
ALTER TABLE operations.order_partitioned
ADD CONSTRAINT fk_orders_customer
  FOREIGN KEY (customer_id)
  REFERENCES operations.customers(customer_id);


--linking prescribed by
ALTER TABLE operations.order_partitioned
ADD CONSTRAINT fk_prescribed_by_fkey
  FOREIGN KEY (prescribed_by)
  REFERENCES operations.employees(employee_id);

-- ASSIGNMENT1 - TO ADD CONSTRAINT FOR paid_to and dispatched_by Just like the above.

--assignment_1a
--linking paid_to
ALTER TABLE operations.order_partitioned
ADD CONSTRAINT orders_paid_to_fkey
  FOREIGN KEY (paid_to)
  REFERENCES operations.employees(employee_id);

--assignment_1b
--linking dispatched_by
ALTER TABLE operations.order_partitioned
ADD CONSTRAINT orders_dispatched_by_fkey
  FOREIGN KEY (dispatched_by)
  REFERENCES operations.employees(employee_id);




-- Create partitions per year
CREATE TABLE operations.orders_2020 PARTITION OF 
operations.order_partitioned
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE operations.orders_2021 PARTITION OF 
operations.order_partitioned
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE operations.orders_2022 PARTITION OF 
operations.order_partitioned
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

-- ASSIGNMENT2 - TO CREATE partitions per year from 2023 to 2026 just like the above.

-- Create partitions by year 2023
CREATE TABLE operations.orders_2023 PARTITION OF 
operations.order_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Create partitions by year 2024
CREATE TABLE operations.orders_2024 PARTITION OF 
operations.order_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Create partitions by year 2025
CREATE TABLE operations.orders_2025 PARTITION OF 
operations.order_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Create partitions by year 2026
CREATE TABLE operations.orders_2026 PARTITION OF 
operations.order_partitioned
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

--

-- Insert Into the order_partitioned after partitioning from the orders table
INSERT INTO operations.order_partitioned
SELECT * FROM operations.orders;

-- Rename tables orders_partioned table to orders and vice versa
ALTER TABLE operations.orders RENAME TO orders_old;
ALTER TABLE operations.order_partitioned RENAME TO orders;

