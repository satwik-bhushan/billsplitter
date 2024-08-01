DELIMITER $$

CREATE PROCEDURE Create_User(IN username VARCHAR(255), IN email VARCHAR(255), IN pass VARCHAR(255))
BEGIN
    IF (username NOT IN (SELECT username FROM Users) AND email NOT IN (SELECT email FROM Users)) THEN
        INSERT INTO Users (username, email, password_hash) VALUES (username, email, pass);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User already exists' MYSQL_ERRNO = 1001;
    END IF;
END $$

CREATE PROCEDURE Create_Group(IN groupname VARCHAR(255))
BEGIN
    INSERT INTO Groups (group_name) VALUES (groupname);

END $$

CREATE PROCEDURE AddUserToGroup(IN p_user_id INT, IN p_group_id INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM User_Groups WHERE user_id = p_user_id AND group_id = p_group_id) THEN
        INSERT INTO User_Groups (user_id, group_id) VALUES (p_user_id, p_group_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User already in group' MYSQL_ERRNO = 1001;
    END IF;
END $$

CREATE PROCEDURE Create_Expense(IN p_user_id INT, IN p_group_id INT, IN p_amount DECIMAL(10, 2), IN p_description TEXT, IN p_date DATE)
BEGIN
    INSERT INTO Expenses (user_id, group_id, amount, descrip, dte) VALUES (p_user_id, p_group_id, p_amount, p_description, p_date);
END $$

CREATE PROCEDURE Split_Expense(IN p_expense_id INT, IN p_burdened_user_id INT, IN p_debtor_user_id INT)
BEGIN
    INSERT INTO ExpensesSplits (expense_id, burdened_user_id, debtor_user_id) VALUES (p_expense_id, p_burdened_user_id, p_debtor_user_id);
END $$