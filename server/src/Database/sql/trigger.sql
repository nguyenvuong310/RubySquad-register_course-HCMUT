DELIMITER //

CREATE TRIGGER check_insert_registerpharse1
BEFORE INSERT ON registerpharse1
FOR EACH ROW
BEGIN
  DECLARE insert_count INT;
  DECLARE delete_count INT;

  -- Count the number of existing "INSERT" actions
  SELECT COUNT(*)
  INTO insert_count
  FROM registerpharse1
  WHERE subject_code = NEW.subject_code
    AND semester_id = NEW.semester_id
    AND action = 'INSERT'
    AND student_id = NEW.student_id;

  -- Count the number of existing "DELETE" actions
  SELECT COUNT(*)
  INTO delete_count
  FROM registerpharse1
  WHERE subject_code = NEW.subject_code
    AND semester_id = NEW.semester_id
    AND action = 'DELETE'
    AND student_id = NEW.student_id;

  -- Check if it's a valid operation
  IF NEW.action = 'DELETE' AND insert_count - delete_count = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot delete. The subject has not been delete.';
  ELSEIF NEW.action = 'INSERT' AND insert_count - delete_count = 1 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot insert. The subject has already been inserted.';
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