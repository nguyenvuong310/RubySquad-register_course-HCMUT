DELIMITER //

CREATE TRIGGER check_insert_registerphase1
BEFORE INSERT ON registerphase1
FOR EACH ROW
BEGIN
  DECLARE register_count INT;
  DECLARE delete_count INT;
  DECLARE semester_exist INT;
  DECLARE total_credits INT;

  -- Check if semester_id exists
  SELECT COUNT(*)
  INTO semester_exist
  FROM semester
  WHERE semester_id = NEW.semester_id;

  -- Check if it's a valid semester_id
  IF semester_exist = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid semester_id. Semester does not exist.';
  ELSE
    -- Count the number of existing "INSERT" actions
    SELECT COUNT(*)
    INTO register_count
    FROM registerphase1
    WHERE subject_code = NEW.subject_code
      AND semester_id = NEW.semester_id
      AND action = 'REGISTER'
      AND student_id = NEW.student_id;

    -- Count the number of existing "DELETE" actions
    SELECT COUNT(*)
    INTO delete_count
    FROM registerphase1
    WHERE subject_code = NEW.subject_code
      AND semester_id = NEW.semester_id
      AND action = 'DELETE'
      AND student_id = NEW.student_id;

    -- Check if it's a valid operation
    IF NEW.action = 'DELETE' AND register_count - delete_count = 0 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Cannot delete. The subject has not been deleted.';
    ELSEIF NEW.action = 'REGISTER' AND register_count - delete_count = 1 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Cannot insert. The subject has already been registed.';
    END IF;
    -- calc sum credit in hk
    SELECT SUM(credits) INTO total_credits
    FROM registerphase1 rp
    JOIN Subjects s ON rp.subject_code  = s.subject_code;
    WHERE rp.student_id = 2115367 ON c.semester_id = 231
    GROUP BY rp.student_id, s.subject_code
    HAVING SUM(CASE WHEN a.action = 'REGISTER' THEN 1 ELSE 0 END) > SUM(CASE WHEN a.action = 'DELETE' THEN 1 ELSE 0 END);
     
       
    IF total_credits > 25 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Cannot insert. Total credits exceed 25.';
    END IF;
  END IF;
END;

//
DELIMITER ;


DELIMITER //
CREATE TRIGGER check_insert_class
BEFORE INSERT ON Classes
FOR EACH ROW
BEGIN
  DECLARE class_count INT;

  SELECT COUNT(*)
  INTO class_count
  FROM Classes -- Replace your_table with the actual name of your table
  WHERE subject_code = NEW.subject_code AND semester_id = NEW.semester_id AND class_name = NEW.class_name;

  IF class_count > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Duplicate entry for class';
  END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER check_insert_user
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
  DECLARE user_count INT;

  SELECT COUNT(*)
  INTO user_count
  FROM Users -- Replace your_table with the actual name of your table
  WHERE email = NEW.email OR MSSV = NEW.MSSV;

  IF user_count > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Duplicate entry for user';
  END IF;
END;
//
DELIMITER ;

DELIMITER //

CREATE TRIGGER check_register_phase2_3
BEFORE INSERT ON Attends
FOR EACH ROW
BEGIN
  DECLARE conflict_count INT;
	SELECT COUNT(*) INTO conflict_count
	FROM Attends a
	JOIN Classes c ON a.class_id = c.class_id
	WHERE a.student_id = NEW.student_id
  		AND (NEW.action = 'REGISTER' AND (SELECT COUNT(*) FROM Attends WHERE student_id = NEW.student_id AND class_id = NEW.class_id AND action = 'REGISTER') - (SELECT COUNT(*) FROM Attends WHERE student_id = NEW.student_id AND class_id = NEW.class_id AND action = 'DELETE') = 1);
  IF conflict_count > 0 AND NEW.action = 'REGISTER' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'class registed';
  END IF;
END //

DELIMITER ;
DELIMITER //
CREATE TRIGGER check_register_phase2_3_time
BEFORE INSERT ON Attends
FOR EACH ROW
BEGIN
  DECLARE conflict_count INT;
  
  -- Check if the student already has a class with the same lesson_start and day
  SELECT COUNT(*) INTO conflict_count
  FROM Attends a
  JOIN Classes c ON a.class_id = c.class_id
  WHERE a.student_id = NEW.student_id
    AND c.lesson_start = (SELECT lesson_start FROM Classes WHERE class_id = NEW.class_id)
    AND c.day = (SELECT day FROM Classes WHERE class_id = NEW.class_id)
    AND NEW.action = "REGISTER";
  
  IF conflict_count > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Duplicate time';
  END IF;
END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER updateGPAandCredits_AfterInsert
AFTER INSERT ON Attends
FOR EACH ROW
BEGIN
    DECLARE studentGPA DOUBLE;
    DECLARE studentTotalCredits INT;

    -- Check if the action is 'STUDIED'
    IF NEW.action = 'STUDIED' THEN
        -- Calculate the new GPA and totalCredits for the student
        SELECT SUM(max_score * s.credits) AS totalScore, SUM(credits) AS studentTotalCredits
        FROM (
            SELECT a.student_id, c.subject_code as subject, MAX(a.score) as max_score
            FROM Attends a
            JOIN Classes c ON a.class_id = c.class_id
            WHERE a.student_id = NEW.student_id AND a.action = 'STUDIED'
            GROUP BY a.student_id, c.subject_code
        ) AS max_scores
        JOIN Subjects s ON max_scores.subject = s.subject_code;

        -- Update GPA and totalCredits in the Students table
        UPDATE Students
        SET GPA = IF(studentTotalCredits > 0, studentGPA / studentTotalCredits, 0),
            TotalCredits = studentTotalCredits
        WHERE MS = NEW.student_id;
    END IF;
END //

DELIMITER ;

CREATE TRIGGER updateGPAandCredits_afterUpdate
AFTER UPDATE ON Attends
FOR EACH ROW
BEGIN
    DECLARE studentGPA DOUBLE;
    DECLARE studentTotalCredits INT;

    -- Check if the action is 'STUDIED'
    IF NEW.action = 'STUDIED' THEN
        -- Calculate the new GPA and totalCredits for the student
        SELECT SUM(max_score * s.credits) AS totalScore, SUM(credits) AS studentTotalCredits
        FROM (
            SELECT a.student_id, c.subject_code as subject, MAX(a.score) as max_score
            FROM Attends a
            JOIN Classes c ON a.class_id = c.class_id
            WHERE a.student_id = NEW.student_id AND a.action = 'STUDIED'
            GROUP BY a.student_id, c.subject_code
        ) AS max_scores
        JOIN Subjects s ON max_scores.subject = s.subject_code;

        -- Update GPA and totalCredits in the Students table
        UPDATE Students
        SET GPA = IF(studentTotalCredits > 0, studentGPA / studentTotalCredits, 0),
            TotalCredits = studentTotalCredits
        WHERE MS = NEW.student_id;
    END IF;
END //

DELIMITER ;