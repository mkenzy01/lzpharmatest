-- Inventry CONSTRAINTS
-- Using DML
ALTER TABLE inventory.drugs
ADD CONSTRAINT check_positive_price CHECK (pric > 0);

--
ALTER TABLE inventory.stocks
ADD CONSTRAINT check_nonnegative_quantity CHECK (quantity >= 0)

--
ALTER TABLE operations.orders
ADD CONSTRAINT check_total_amount CHECK (total_amount >= 0)

-- Assignment 1: Set a constraint on the trial_participant table where the age must be between 8 to 85
ALTER TABLE research.trial_participants
ADD CONSTRAINT check_trial_participants_age CHECK (age BETWEEN 8 and 85)