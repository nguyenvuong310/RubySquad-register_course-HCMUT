DELIMITER //

CREATE PROCEDURE createClass(
    IN p_semester_id INT,
    IN p_subject_code VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE whole_num INT;
    DECLARE num_classes INT;
    DECLARE i INT;
    -- Calculate Whole_num for the specified subject_code
    SELECT
        COALESCE(COUNT(DISTINCT rp.subject_code), 0)
    INTO whole_num
    FROM
        registerpharse1 rp
    WHERE
        rp.semester_id = p_semester_id
        AND rp.subject_code = p_subject_code
    GROUP BY
        rp.student_id
    HAVING
        SUM(CASE WHEN rp.action = 'INSERT' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END);
    -- Print Whole_num
    -- SELECT whole_num AS Whole_num;
    -- Calculate the number of classes to insert
    SET num_classes = whole_num / 40 + 1;
    -- Loop to insert records into Classes table
    SET i = 1;
    main_loop: LOOP
        -- Insert record into Classes table
        INSERT INTO Classes (class_name, semester_id, location, day, lesson_start, duration, timestart, subject_code, max_slot)
        VALUES (CONCAT('L0', i), p_semester_id, CONCAT('Location', i), 2, 2, 15, 35, p_subject_code, 40); 

        SET i = i + 1;

        IF i > num_classes THEN
            LEAVE main_loop;
        END IF;
    END LOOP;

    -- Commit the transaction
    COMMIT;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE InsertStudentData(
    IN p_MS INT,
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_birthday DATE,
    IN p_address VARCHAR(255),
    IN p_sex BOOLEAN,
    IN p_faculty_id VARCHAR(255),
    IN p_year_start_learn DATE
)
BEGIN
    DECLARE user_id INT;

    -- Check if the email or MS already exists
    IF EXISTS (SELECT 1 FROM Users WHERE email = p_email OR MS = p_MS) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email or MS already exists.';
    ELSE
        -- Check if the faculty_id exists in Facultys
        IF NOT EXISTS (SELECT 1 FROM Facultys WHERE faculty_id = p_faculty_id) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Faculty_id does not exist in Facultys.';
        ELSE
            -- Insert data into Users table
            INSERT INTO Users(MS, name, email, password, birthday, address, sex, faculty_id)
            VALUES (p_MS, p_name, p_email, p_password, p_birthday, p_address, p_sex, p_faculty_id);

            -- Insert data into Students table
            INSERT INTO Students(MS, yearStartLearn)
            VALUES (p_MS, p_year_start_learn);
        END IF;
    END IF;
END //

DELIMITER ;

DELIMITER //


CREATE PROCEDURE InsertLecturerData(
    IN p_MS INT,
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_birthday DATE,
    IN p_address VARCHAR(255),
    IN p_sex BOOLEAN,
    IN p_faculty_id VARCHAR(255),
    IN p_level VARCHAR(255),
    IN p_position VARCHAR(255),
    IN p_supervisor_id INTEGER
)
BEGIN
    DECLARE user_id INT;

    -- Check if the email or MS already exists
    IF EXISTS (SELECT 1 FROM Users WHERE email = p_email OR MS = p_MS) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email or MS already exists.';
    ELSE
        -- Check if the faculty_id exists in Facultys
        IF NOT EXISTS (SELECT 1 FROM Facultys WHERE faculty_id = p_faculty_id) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Faculty_id does not exist in Facultys.';
        ELSE
            -- Insert data into Users table
            INSERT INTO Users(MS, name, email, password, birthday, address, sex, faculty_id)
            VALUES (p_MS, p_name, p_email, p_password, p_birthday, p_address, p_sex, p_faculty_id);

            -- Insert data into Lecturers table
            INSERT INTO Lecturers(MS, position, level, supervisor_id)
            VALUES (p_MS, p_position,p_level, p_supervisor_id);
        END IF;
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE UpdateStudentData(
    IN p_MS INT,
    IN p_new_yearStartLearn DATE,
    IN p_new_name VARCHAR(255),
    IN p_new_email VARCHAR(255)
)
BEGIN
    DECLARE user_count INT;

    -- Check if the new MS or email already exists
    SELECT COUNT(*) INTO user_count FROM Users WHERE (email = p_new_email) ;

    IF user_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'email already exists.';
    ELSE
        -- Update data in Users table
        UPDATE Users
        SET
            name = p_new_name,
            email = p_new_email
        WHERE MS = p_MS;

        -- Update data in Students table
        UPDATE Students
        SET yearStartLearn = p_new_yearStartLearn
        WHERE MS = p_MS;
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE UpdateLecturerData(
    IN p_MS INT,
    IN p_new_level VARCHAR(255),
    IN p_new_name VARCHAR(255),
    IN p_new_email VARCHAR(255),
    IN p_position VARCHAR(255)
)
BEGIN
    DECLARE user_count INT;

    -- Check if the new MS or email already exists
    SELECT COUNT(*) INTO user_count FROM Users WHERE (email = p_new_email) ;

    IF user_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'email already exists.';
    ELSE
        -- Update data in Users table
        UPDATE Users
        SET
            name = p_new_name,
            email = p_new_email
        WHERE MS = p_MS;

        -- Update data in Students table
        UPDATE Students
        SET 
        	level = p_new_level,
        	position = p_position
        WHERE MS = p_MS;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteStudentIfNoDependencies(IN p_MS INT)
BEGIN
    DECLARE user_count INT;

    -- Check for dependencies in registerphase1, attend, and dependend tables
    SELECT COUNT(*) INTO user_count FROM registerphase1 WHERE student_id = p_MS;
    IF user_count = 0 THEN SELECT COUNT(*) INTO user_count FROM Attends WHERE student_id = p_MS; END IF;
    IF user_count = 0 THEN SELECT COUNT(*) INTO user_count FROM Dependents WHERE student_id = p_MS; END IF;

    -- If no dependencies, delete from Users and Students tables; otherwise, raise an exception
    IF user_count = 0 THEN 
        DELETE FROM Students WHERE MS = p_MS;
        DELETE FROM Users WHERE MS = p_MS;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete user with dependencies.';
    END IF;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE GetRegisteredSubjects(
    IN p_student_id INT,
    IN p_semester_id INT
)
BEGIN
    -- Select registered subjects based on student_id and semester_id
    SELECT
        rp.semester_id,
        rp.subject_code,
        s.subject_name,
        s.credits
    FROM
        registerphase1 rp
        JOIN subjects s ON rp.subject_code = s.subject_code
    WHERE
        rp.student_id = p_student_id
        AND rp.semester_id = p_semester_id
    GROUP BY
        rp.semester_id, rp.subject_code, s.subject_name, s.credits
    HAVING
        SUM(CASE WHEN rp.action = 'INSERT' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE SearchStudent(
    IN p_searchTerm VARCHAR(255),
    IN p_orderByField VARCHAR(255),
    IN p_sortOrder VARCHAR(10)
)
BEGIN
    SET @query = CONCAT('
        SELECT * 
        FROM users u 
        JOIN students s ON u.MS = s.MS
        JOIN facultys f ON f.faculty_id = u.faculty_id
        WHERE u.name LIKE ? OR u.email LIKE ? OR u.MS LIKE ? OR f.f_name LIKE ?
        ORDER BY ', p_orderByField, ' ', p_sortOrder
    );

    PREPARE stmt FROM @query;
    SET @searchTerm = CONCAT('%', p_searchTerm, '%');
    EXECUTE stmt USING @searchTerm, @searchTerm, @searchTerm, @searchTerm;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;
