DELIMITER //
CREATE TRIGGER before_insert_check_duplicate
BEFORE INSERT ON registerpharse1
FOR EACH ROW
BEGIN
  DECLARE subject_count INT;

  SELECT COUNT(*)
  INTO subject_count
  FROM registerpharse1 -- Replace your_table with the actual name of your table
  WHERE subject_code = NEW.subject_code AND semester_id = NEW.semester_id;

  IF subject_count > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Duplicate entry for subject_code and semester_id combination';
  END IF;
END;
//
DELIMITER ;