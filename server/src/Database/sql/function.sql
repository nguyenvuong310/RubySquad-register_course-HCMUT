DELIMITER //

CREATE FUNCTION CanScholarship(p_student_id INT, p_semester_id INT) RETURNS BOOLEAN
BEGIN
    DECLARE semesterTotalCredits INT;
    DECLARE semesterTotalGPA DOUBLE;
    DECLARE semesterGPA DOUBLE;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Students WHERE MS = p_student_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    -- Check if the semester exists
    IF NOT EXISTS (SELECT 1 FROM Semester WHERE semester_id = p_semester_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Semester does not exist';
    END IF;

    -- Calculate total credits and GPA for the specified semester
    SELECT SUM(score * s.credits), SUM(credits)
    INTO semesterTotalGPA, semesterTotalCredits
    FROM (
        SELECT a.student_id, c.subject_code as subject, a.score as score
        FROM Attends a
        JOIN Classes c ON a.class_id = c.class_id AND c.semester_id = p_semester_id
        WHERE a.student_id = p_student_id AND a.action = 'STUDIED'
        GROUP BY a.student_id, c.subject_code
    ) AS scores
    JOIN Subjects s ON scores.subject = s.subject_code;

    -- Calculate overall GPA for the semester
    SET semesterGPA = IF (semesterTotalCredits > 0, semesterTotalGPA / semesterTotalCredits, 0);

    -- Check if the student meets the scholarship criteria
    IF semesterGPA >= 7.0 AND semesterTotalCredits >= 14 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION CalcGPAInSemester(p_student_id INT, p_semester_id INT) RETURNS DOUBLE
BEGIN
    DECLARE totalScore DOUBLE;
    DECLARE totalCredits INT;
    DECLARE semesterGPA DOUBLE;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Students WHERE MS = p_student_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    -- Check if the semester exists
    IF NOT EXISTS (SELECT 1 FROM Semester WHERE semester_id = p_semester_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Semester does not exist';
    END IF;

    -- Calculate total score and credits for the specified semester
    SELECT SUM(score * s.credits), SUM(credits)
    INTO totalScore, totalCredits
    FROM (
        SELECT a.student_id, c.subject_code as subject, a.score as score
        FROM Attends a
        JOIN Classes c ON a.class_id = c.class_id AND c.semester_id = p_semester_id
        WHERE a.student_id = p_student_id AND a.action = 'STUDIED'
        GROUP BY a.student_id, c.subject_code
    ) AS scores
    JOIN Subjects s ON scores.subject = s.subject_code;

    -- Calculate GPA for the semester
    SET semesterGPA = IF (totalCredits > 0, totalScore / totalCredits, 0);

    RETURN semesterGPA;
END //

DELIMITER ;
DELIMITER //

CREATE FUNCTION CalcTotalCreditSemester(p_student_id INT, p_semester_id INT) RETURNS DOUBLE
BEGIN
    DECLARE totalCredits INT;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Students WHERE MS = p_student_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    -- Check if the semester exists
    IF NOT EXISTS (SELECT 1 FROM Semester WHERE semester_id = p_semester_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Semester does not exist';
    END IF;

    -- Calculate total credits for the specified semester
    SELECT SUM(s.credits)
    INTO totalCredits
    FROM (
        SELECT rp.student_id, rp.subject_code
        FROM registerphase1 rp
        WHERE rp.student_id = p_student_id AND rp.semester_id = p_semester_id
        GROUP BY rp.student_id, rp.subject_code
        HAVING SUM(CASE WHEN rp.action = 'REGISTER' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END)
    ) AS credits
    JOIN Subjects s ON credits.subject_code = s.subject_code;

    RETURN totalCredits;
END //

DELIMITER ;