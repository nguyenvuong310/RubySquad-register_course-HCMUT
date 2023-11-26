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
