/* Creates and Uses Database */
CREATE DATABASE IF NOT EXISTS expense_tracker;
USE expense_tracker;

/* Set up login into database */
CREATE USER IF NOT EXISTS dev@localhost IDENTIFIED BY 'expense';
GRANT ALL PRIVILEGES ON expense_tracker.* TO dev@localhost;
GRANT EXECUTE ON expense_tracker.* TO dev@localhost;
SET DEFAULT ROLE ALL TO dev@localhost;

SHOW GRANTS FOR dev@localhost;

/* Create tables */
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Groups (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS User_Groups (
    user_group_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (group_id) REFERENCES Groups(group_id),
    UNIQUE(user_id, group_id)
);

CREATE TABLE IF NOT EXISTS Expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    descrip TEXT,
    dte DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (group_id) REFERENCES Groups(group_id)
);

CREATE TABLE IF NOT EXISTS ExpensesSplits (
    expense_split_id INT AUTO_INCREMENT PRIMARY KEY,
    expense_id INT NOT NULL,
    burdened_user_id INT NOT NULL,
    debtor_user_id INT NOT NULL,
    FOREIGN KEY (expense_id) REFERENCES Expenses(expense_id),
    FOREIGN KEY (burdended_user_id) REFERENCES Users(user_id),
    FOREIGN KEY (debtor_user_id) REFERENCES Users(user_id)
);