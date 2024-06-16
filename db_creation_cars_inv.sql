-- Drop the database if it exists to start fresh
DROP DATABASE IF EXISTS car_inv;

-- Create the database
CREATE DATABASE car_inv;
USE car_inv;

-- Create the cars table
CREATE TABLE cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    brand ENUM('Ford', 'Honda', 'BMW', 'Audi') NOT NULL,
    color ENUM('Red', 'Blue', 'Black', 'White') NOT NULL,
    model ENUM('SUV', 'Sedan', 'Hatchback', 'Minivan', 'Sportscar') NOT NULL,
    price DECIMAL(10, 2) CHECK (price BETWEEN 10000.00 AND 100000.00),
    stock_quantity INT NOT NULL,
    UNIQUE KEY brand_color_model (brand, color, model)
);

-- Create the discounts table
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    pct_discount DECIMAL(5,2) CHECK (pct_discount BETWEEN 0 AND 100),
    FOREIGN KEY (car_id) REFERENCES cars(car_id)
);

-- Create a stored procedure to populate the cars table
DELIMITER $$
CREATE PROCEDURE PopulateCars()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE max_records INT DEFAULT 150; -- Change max_records to 150
    DECLARE brand ENUM('Ford', 'Honda', 'BMW', 'Audi');
    DECLARE color ENUM('Red', 'Blue', 'Black', 'White');
    DECLARE model ENUM('SUV', 'Sedan', 'Hatchback', 'Minivan', 'Sportscar');
    DECLARE price DECIMAL(10, 2);
    DECLARE stock INT;

    -- Seed the random number generator
    SET SESSION rand_seed1 = UNIX_TIMESTAMP();

    WHILE counter < max_records DO
        -- Generate random values
        SET brand = ELT(FLOOR(1 + RAND() * 4), 'Ford', 'Honda', 'BMW', 'Audi');
        SET color = ELT(FLOOR(1 + RAND() * 4), 'Red', 'Blue', 'Black', 'White');
        SET model = ELT(FLOOR(1 + RAND() * 5), 'SUV', 'Sedan', 'Hatchback', 'Minivan', 'Sportscar');
        SET price = ROUND(10000.00 + RAND() * 90000.00, 2); -- Random price between 10,000 and 100,000
        SET stock = FLOOR(10 + RAND() * 91);

        -- Attempt to insert a new record
        -- Duplicate brand, color, model combinations will be ignored due to the unique constraint
        BEGIN
            DECLARE CONTINUE HANDLER FOR 1062 BEGIN END;  -- Handle duplicate key error
            INSERT INTO cars (brand, color, model, price, stock_quantity)
            VALUES (brand, color, model, price, stock);
            SET counter = counter + 1;
        END;
    END WHILE;
END$$
DELIMITER ;

-- Call the stored procedure to populate the cars table
CALL PopulateCars();

-- Insert records into the discounts table
-- Ensure that the car_id values exist in the cars table
INSERT INTO discounts (car_id, pct_discount)
SELECT car_id, ROUND(RAND() * 100, 2) -- Assigning random discounts between 0 and 100
FROM cars
LIMIT 15; -- Limit the insert to 15 records

-- Display the data in the discounts table
SELECT * FROM discounts;
