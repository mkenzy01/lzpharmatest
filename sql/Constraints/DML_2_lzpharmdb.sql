-- To stop orders data from being deleted when a customer data is deleted

ALTER TABLE operations.orders
ADD CONSTRAINT order_customer_deletion
FOREIGN KEY (customer_id) REFERENCES operations.customers(customer_id) ON DELETE SET NULL;

-- SET THE CUSTOMER ID IN ORDERS TABLE TO NULL WHEN A CUSTOMER IS DELETED FROM THE CUSTOMERS TABLE.

ALTER TABLE inventory.stock
ADD CONSTRAINT stock_drug_deletion
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id) ON DELETE CASCADE;
-- This set the customer_id in orders table to NULL when a customer is deleted from the customers table.

ALTER TABLE operations.orders
ADD CONSTRAINT order_employee_deletion
FOREIGN KEY (attendant_id) 
REFERENCES operations.employees(employee_id) ON DELETE SET NULL;


-- ASSIGNMENT 2: Create a constraint to delete the supplier information when a drug is deleted.
ALTER TABLE inventory.suppliers
ADD CONSTRAINT suppliers_drug_deletion
FOREIGN KEY (drug_id) REFERENCES inventory.drugs (drug_id) ON DELETE CASCADE;