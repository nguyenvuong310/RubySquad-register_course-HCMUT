CREATE TABLE IF NOT EXISTS Semester (
  semester_id INTEGER not null PRIMARY KEY,
  timestart TIMESTAMP NOT NULL,
  semester_name VARCHAR(255),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS register_course (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  register_title VARCHAR(255),
  semester_id INTEGER,
  FOREIGN KEY (semester_id) REFERENCES Semester(semester_id),
  timestart DATE,
  timeend DATE,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);  
CREATE TABLE IF NOT EXISTS Facultys (
  faculty_id VARCHAR(255) ,
  f_name VARCHAR(255),
  f_address VARCHAR(255),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY(faculty_id)
);
CREATE TABLE IF NOT EXISTS Subjects (
  subject_name VARCHAR(255) ,
  subject_code VARCHAR(255),
  study_period INTEGER,
  credits INTEGER,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (subject_code)
);
CREATE TABLE IF NOT EXISTS Prerequisite_Subejct (
  id INTEGER not null PRIMARY KEY AUTO_INCREMENT,
  subject_code VARCHAR(255) not null,
  prerequisite_subject_code VARCHAR(255),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  FOREIGN KEY (prerequisite_subject_code) REFERENCES Subjects(subject_code),
  FOREIGN KEY (subject_code) REFERENCES Subjects(subject_code)
);
CREATE TABLE IF NOT EXISTS Open_at (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  subject_code VARCHAR(255),
  semester_id INTEGER,
  FOREIGN KEY (semester_id) REFERENCES Semester(semester_id),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);  
CREATE TABLE IF NOT EXISTS Users (
  MS INT NOT NULL,
  name VARCHAR(255),
  email VARCHAR(255),
  password VARCHAR(255),
  birthday DATE,
  address VARCHAR(255),
  sex BOOLEAN,
  faculty_id VARCHAR(255),
  FOREIGN KEY (faculty_id) REFERENCES Facultys(faculty_id),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY(MS)
);
CREATE TABLE IF NOT EXISTS Lecturers (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  MS INT,
  level VARCHAR(255),
  position VARCHAR(255),
  supervisor_id INTEGER,
  FOREIGN KEY (supervisor_id) REFERENCES Lecturers(MS),
  FOREIGN KEY (MS) REFERENCES Users(MS),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS Teach(
  id int not null AUTO_INCREMENT PRIMARY KEY,
  subject_code VARCHAR(255),
  FOREIGN KEY (subject_code) REFERENCES Subjects(subject_code),
  lecturer_id INTEGER,
  FOREIGN KEY (lecturer_id) REFERENCES Lecturers(MS),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS Students (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  MS INT,
  FOREIGN KEY (MS) REFERENCES Users(MS),
  GPA DOUBLE,
  TotalCredits INT,
  yearStartLearn DATE,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS Dependents (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  d_name VARCHAR(255),
  relationship VARCHAR(255),
  sex BOOLEAN,
  student_id INTEGER,
  FOREIGN KEY (student_id) REFERENCES Students(MS),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS RegisterPhase1 (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  student_id INTEGER,
  FOREIGN KEY (student_id) REFERENCES Students(MS),
  subject_code VARCHAR(255),
  FOREIGN KEY (subject_code) REFERENCES Subjects(subject_code),
  semester_id INTEGER,
  FOREIGN KEY (semester_id) REFERENCES Semester(semester_id),
  action VARCHAR(255),
  time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS Classes (
  class_id  int not null AUTO_INCREMENT PRIMARY KEY ,
  class_name VARCHAR(255),
  is_lab BOOLEAN,
  max_slot INTEGER,
  whole_num INTEGER DEFAULT 0,
  subject_code VARCHAR(255),
  FOREIGN KEY (subject_code) REFERENCES Subjects(subject_code),
  semester_id INTEGER,
  FOREIGN KEY (semester_id) REFERENCES Semester(semester_id),
  location VARCHAR(255),
  day INTEGER,
  lesson_start INTEGER,
  duration INTEGER,
  timestart INTEGER,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS InChargeOfs (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  class_id INTEGER,
  lecturer_id INTEGER,
  FOREIGN KEY (class_id) REFERENCES Classes(class_id),
  FOREIGN KEY (lecturer_id) REFERENCES Lecturers(id),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS Attends (
  id int not null AUTO_INCREMENT,
  student_id INTEGER NOT NULL,
  class_id INTEGER NOT NULL,
  score DOUBLE,
  action VARCHAR(255),
  PRIMARY KEY (id),
  FOREIGN KEY (class_id) REFERENCES Classes(class_id),
  FOREIGN KEY (student_id) REFERENCES Students(MS),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);
INSERT IGNORE  INTO Semester(semester_id, timestart, semester_name)
VALUES 
  (211, '2021-01-01', 'Hoc ki 1 nam 2021'),
  (212, '2021-05-01', 'Hoc ki 2 nam 2021'),
  (213, '2021-09-01', 'Hoc ki 3 nam 2021'),
  (221, '2022-01-01', 'Hoc ki 1 nam 2022'),
  (222, '2022-05-01', 'Hoc ki 2 nam 2022'),
  (223, '2022-09-01', 'Hoc ki 3 nam 2022'),
  (231, '2023-01-01', 'Hoc ki 1 nam 2023'),
  (232, '2023-05-01', 'Hoc ki 2 nam 2023');
INSERT IGNORE INTO Facultys (faculty_id, f_name, f_address)
VALUES
  ('BD', 'TT Đào tạo Bảo dưỡng Công nghiệp', 'A1'),
  ('CK', 'Khoa Cơ khí', 'A2'),
  ('DC', 'Khoa Kỹ thuật Địa chất và Dầu khí', 'B8'),
  ('DD', 'Khoa Điện - Điện tử', 'A3'),
  ('MT', 'Khoa Khoa học và Kỹ thuật máy tính', 'A4'),
  ('HC', 'Khoa Kỹ thuật Hóa học', 'B2'),
  ('QL', 'Khoa Quản lý Công nghiệp', 'B10'),
  ('XD', 'Khoa Kỹ thuật Xây dưng', 'B6'),
  ('MO', 'Khoa Môi trường và Tài nguyên', 'B9'),
  ('GT', 'Khoa Kỹ thuật Giao thông', 'C5'),
  ('KU', 'Khoa Khoa học Ứng dụng', 'B4'),
  ('VL', 'Khoa Công nghệ Vật liệu', 'C4'),
  ('KT', 'ngành Kiến trúc', 'A5'),
  ('VP', 'Chương trình ĐTKS CLC - Việt Pháp', null),
  ('CC', 'Chương trình chất lượng cao tiếng Anh', null),
  ('CN', 'Chương trình chất lượng cao tiếng Nhật', null),
  ('QT', 'Chương trình chuyển tiếp quốc tế', null),
  ('TT', 'Chương trình tiên tiến', null);

INSERT IGNORE INTO Subjects (subject_code, subject_name, credits, study_period)
VALUES
('CH1003', 'Hóa đại cương', 3, 2),
('CH1004', 'Hóa đại cương', 0, 5),
('CO1005', 'Nhập môn điện toán', 3, 2),
('CO1006', 'Nhập môn điện toán', 0, 5),
('CO1007', 'Cấu trúc rời rạc cho khoa học máy tính', 4, 2),
('CO1023', 'Hệ thống số', 3, 2),
('CO1024', 'Hệ thống số', 0, 5),
('CO1027', 'Kĩ thuật lập trình', 3, 2),
('CO1028', 'Kĩ thuật lập trình', 0, 5),
('CO2001', 'Kỹ năng chuyên nghiệp cho kỹ sư', 3, 2),
('CO2003', 'Cấu trúc dữ liệu và giải thuật', 4, 2),
('CO2004', 'Cấu trúc dữ liệu và giải thuật', 0, 5),
('CO2007', 'Kiến trúc máy tính', 4, 2),
('CO2008', 'Kiến trúc máy tính', 0, 5),
('CO2011', 'Mô hình hóa toán học', 3, 2),
('CO2013', 'Hệ cơ sở dữ liệu', 4, 3),
('CO2014', 'Hệ cơ sở dữ liệu', 0, 5),
('CO2017', 'Hệ điều hành', 3, 2),
('CO2018', 'Hệ điều hành', 0, 5),
('CO2039', 'Lập trình nâng cao', 3, 2),
('CO3001', 'Công nghệ phần mềm', 3, 2),
('CO3005', 'Nguyên lý ngôn ngữ lập trình', 4, 2),
('CO3006', 'Nguyên lý ngôn ngữ lập trình', 0, 5),
('CO3011', 'Quản lý dự án phần mềm', 3, 2),
('CO3012', 'Quản lý dự án phần mềm', 0, 5),
('CO3013', 'Xây dựng chương trình dịch', 3, 2),
('CO3015', 'Kiểm tra phần mềm', 3, 2),
('CO3017', 'Kiến trúc phần mềm', 3, 2),
('CO3021', 'Hệ quản trị cơ sở dữ liệu', 3, 2),
('CO3022', 'Hệ quản trị cơ sở dữ liệu', 0, 5),
('CO3023', 'Cơ sở dữ liệu phân tán và hướng đối tượng', 3, 2),
('CO3027', 'Thương mại điện tử', 3, 2),
('CO3029', 'Khai phá dữ liệu', 3, 2),
('CO3031', 'Phân tích và thiết kế giải thuật', 3, 2),
('CO3033', 'Bảo mật hệ thống thông tin', 3, 2),
('CO3035', 'Hệ thời gian thực', 3, 2),
('CO3037', 'Phát triển ứng dụng internet of things', 3, 2),
('CO3041', 'Hệ thống thông minh', 3, 2),
('CO3043', 'Phát triển ứng dụng trên thiết bị di động', 3, 2),
('CO3045', 'Lập trình game', 3, 2),
('CO3047', 'Mạng máy tính nâng cao', 3, 2),
('CO3049', 'Lập trình web', 3, 2),
('CO3051', 'Hệ thống thiết bị di động', 3, 2),
('CO3057', 'Xử lý ảnh số và thị giác máy tính', 3, 2),
('CO3059', 'Đồ họa máy tính', 3, 2),
('CO3061', 'Nhập môn trí tuệ nhân tạo', 3, 2),
('CO3065', 'Công nghệ phần mềm nâng cao', 3, 2),
('CO3067', 'Tính toán song song', 3, 2),
('CO3069', 'Mật mã và an ninh mạng', 3, 2),
('CO3071', 'Hệ phân bố', 3, 2),
('CO3083', 'Mật mã học và mã hóa thông tin', 3, 2),
('CO3085', 'Xử lý ngôn ngữ tự nhiên', 3, 2),
('CO3089', 'Những chủ đề nâng cao trong khoa học máy tính', 3, 2),
('CO3093', 'Mạng máy tính', 3, 2),
('CO3094', 'Mạng máy tính', 0, 5),
('CO3115', 'Phân tích và thiết kế hệ thống', 3, 2),
('CO3117', 'Học máy', 3, 2),
('CO3335', 'Thực tập ngoài trường', 2, NULL),
('CO4025', 'Mạng xã hội và thông tin', 3, 2),
('CO4029', 'Đồ án chuyên ngành', 2, NULL),
('CO4031', 'Kho dữ liệu và hệ hỗ trợ quyết định', 3, 2),
('CO4033', 'Phân tích dữ liệu lớn và trí tuệ kinh doanh', 3, 2),
('CO4035', 'Hệ hoạch định tài nguyên tổ chức', 3, 2),
('CO4037', 'Hệ thống thông tin quản lý', 3, 2),
('CO4039', 'Bảo mật sinh trắc', 3, 2),
('CO4337', 'Đồ án tốt nghiệp (Khoa học Máy tính)', 4, NULL),
('IM1025', 'Quản lý dự án cho kỹ sư', 3, 2),
('IM1027', 'Kinh tế kỹ thuật', 3, 2),
('IM3001', 'Quản trị kinh doanh cho kỹ sư', 3, 2),
('MT1003', 'Giải tích 1', 4, 3),
('MT1004', 'Giải tích 1', 0, 3),
('MT1005', 'Giải tích 2', 4, 3),
('MT1006', 'Giải tích 2', 0, 3),
('MT1007', 'Đại số tuyến tính', 3, 2),
('MT1008', 'Đại số tuyến tính', 0, 5),
('MT2013', 'Xác suất và thống kê', 4, 3),
('PH1003', 'Vật lý 1', 4, 2),
('PH1004', 'Vật lý 1', 0, 5),
('PH1007', 'Thí nghiệm vật lý', 1, 2),
('SP1007', 'Pháp luật Việt Nam đại cương', 2, 2),
('SP1031', 'Triết học Mác - Lênin', 3, 2),
('SP1033', 'Kinh tế chính trị Mác - Lênin', 2, 2),
('SP1035', 'Chủ nghĩa xã hội khoa học', 2, 2),
('SP1037', 'Tư tưởng Hồ Chí Minh', 2, 2),
('SP1039', 'Lịch sử Đảng Cộng sản Việt Nam', 2, 2);

INSERT IGNORE INTO register_course (register_title, semester_id, timestart, timeend)
VALUES
    ('Đăng ký các học phần có nhu cầu học HK2/2023-2024 tất cả các diện sinh viên đợt 1', 232, '2024-01-01', '2024-02-01'),
    ('Đăng ký các học phần có nhu cầu học HK1/2023-2024 tất cả các diện sinh viên đợt 1', 231, '2023-07-15', '2023-07-30'),
    ('Đăng ký các học phần có nhu cầu học HK2/2022-2023 tất cả các diện sinh viên đợt 1', 222, '2023-04-01', '2023-05-01'),
    ('Đăng ký các học phần có nhu cầu học HK1/2022-2023 tất cả các diện sinh viên đợt 1', 221, '2023-06-01', '2023-07-01'),
    ('Đăng ký các học phần có nhu cầu học HK2/2022-2023 tất cả các diện sinh viên đợt 2', 221, '2023-08-01', '2023-09-01'),
    ('Đăng ký các học phần có nhu cầu học HK2/2021-2024 tất cả các diện sinh viên đợt 1', 212, '2023-10-01', '2023-11-01'),
    ('Đăng ký các học phần có nhu cầu học HK2/2022-2023 tất cả các diện sinh viên đợt 3', 221, '2023-12-01', '2024-01-01'),
    ('Đăng ký các học phần có nhu cầu học HK2/2023-2024 tất cả các diện sinh viên đợt 3', 232, '2024-02-01', '2024-03-01'),
    ('Đăng ký các học phần có nhu cầu học HK1/2021-2022 tất cả các diện sinh viên đợt 2', 212, '2024-04-01', '2024-05-01'),
    ('Đăng ký các học phần có nhu cầu học HK1/2021-2022 tất cả các diện sinh viên đợt 1', 211, '2021-06-01', '2021-07-01');

INSERT IGNORE INTO `inchargeofs` (`id`, `class_id`, `lecturer_id`, `createdAt`, `updatedAt`) VALUES
(1, 54, 3, '2023-11-30 12:43:18', '2023-11-30 12:43:18'),
(2, 54, 19, '2023-11-30 12:43:32', '2023-11-30 12:43:32'),
(3, 56, 15, '2023-11-30 12:43:42', '2023-11-30 12:43:42'),
(4, 63, 18, '2023-11-30 12:43:50', '2023-11-30 12:43:50'),
(5, 55, 1, '2023-11-30 12:43:57', '2023-11-30 12:43:57'),
(6, 55, 9, '2023-11-30 12:44:03', '2023-11-30 12:44:03'),
(7, 56, 8, '2023-11-30 12:44:10', '2023-11-30 12:44:10'),
(8, 63, 24, '2023-11-30 12:44:17', '2023-11-30 12:44:17'),
(9, 70, 4, '2023-11-30 12:44:25', '2023-11-30 12:44:25'),
(10, 60, 18, '2023-11-30 12:44:49', '2023-11-30 12:44:49'),
(11, 56, 22, '2023-11-30 12:44:57', '2023-11-30 12:44:57');

DELIMITER //

CREATE TRIGGER IF NOT EXISTS check_insert_registerphase1
BEFORE INSERT ON registerphase1
FOR EACH ROW
BEGIN
  DECLARE register_count INT;
  DECLARE delete_count INT;
  DECLARE semester_exist INT;
  DECLARE new_credit INT;
  DECLARE total_credits INT;

  -- Check if semester_id exists
  SELECT COUNT(*)
  INTO semester_exist
  FROM semester
  WHERE semester_id = NEW.semester_id;

  -- Check if it's a valid semester_id
  IF semester_exist = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid semester_id. Semester does not exist.';
  ELSE
    -- Count "REGISTER" actions
    SELECT COUNT(*)
    INTO register_count
    FROM registerphase1
    WHERE subject_code = NEW.subject_code
      AND semester_id = NEW.semester_id
      AND action = 'REGISTER'
      AND student_id = NEW.student_id;

    -- Count "DELETE" actions
    SELECT COUNT(*)
    INTO delete_count
    FROM registerphase1
    WHERE subject_code = NEW.subject_code
      AND semester_id = NEW.semester_id
      AND action = 'DELETE'
      AND student_id = NEW.student_id;

    -- Calculate total credits for the semester
    SELECT SUM(s.credits)
    INTO total_credits
    FROM Subjects s
    WHERE s.subject_code IN (
      SELECT rp.subject_code
      FROM registerphase1 rp
      WHERE rp.student_id = NEW.student_id AND rp.semester_id = NEW.semester_id
      GROUP BY rp.subject_code
      HAVING SUM(CASE WHEN rp.action = 'REGISTER' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END)
    );

    -- Get the new credit for the subject
    SELECT s.credits INTO new_credit
    FROM Subjects s
    WHERE s.subject_code = NEW.subject_code AND s.credits > 0
    LIMIT 1;

    -- Check if it's a valid operation
    IF NEW.action = 'DELETE' AND register_count - delete_count = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete. The subject has not been deleted.';
    ELSEIF NEW.action = 'REGISTER' AND register_count - delete_count = 1 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert. The subject has already been registered.';
    ELSE
      -- Check if the total credits exceed 25
      IF NEW.action = 'REGISTER' AND (total_credits + new_credit > 25) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert. Total credits exceed 25 for the semester.';
      END IF;
    END IF;
  END IF;
END;

//
DELIMITER ;

DELIMITER //

CREATE TRIGGER IF NOT EXISTS check_register_phase2_3
BEFORE INSERT ON Attends
FOR EACH ROW
BEGIN
  DECLARE conflict_count INT;
	SELECT COUNT(*) INTO conflict_count
	FROM Attends a
	JOIN Classes c ON a.class_id = c.class_id
	WHERE a.student_id = NEW.student_id
  		AND (NEW.action = 'REGISTER' AND (SELECT COUNT(*) FROM Attends 
        WHERE student_id = NEW.student_id AND class_id = NEW.class_id AND action = 'REGISTER') 
            - (SELECT COUNT(*) FROM Attends WHERE student_id = NEW.student_id AND class_id = NEW.class_id 
            AND action = 'DELETE') = 1);
  IF conflict_count > 0 AND NEW.action = 'REGISTER' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'class registed';
  END IF;
END //

DELIMITER ;
DELIMITER //
CREATE TRIGGER IF NOT EXISTS check_register_phase2_3_time
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

CREATE PROCEDURE IF NOT EXISTS createClass(
    IN p_semester_id INT,
    IN p_subject_code VARCHAR(255),
    IN p_lesson_start INT,
    IN p_day INT
)
BEGIN
    -- Declare variables
    DECLARE whole_num INT;
    DECLARE num_classes INT;
    DECLARE i INT;

    -- Check if the provided semester_id exists
    IF NOT EXISTS (SELECT 1 FROM semester WHERE semester_id = p_semester_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid semester_id. Semester does not exist.';
    END IF;

    -- Check if the provided subject_code exists
    IF NOT EXISTS (SELECT 1 FROM subjects WHERE subject_code = p_subject_code) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid subject_code. Subject does not exist.';
    END IF;

    -- Calculate Whole_num for the specified subject_code
    

    SELECT
        COUNT(DISTINCT rp.subject_code)
    INTO whole_num
    FROM
        registerphase1 rp
    WHERE
        rp.semester_id = p_semester_id
        AND rp.subject_code = p_subject_code
    GROUP BY
        rp.student_id
    HAVING
        SUM(CASE WHEN rp.action = 'REGISTER' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END);

    -- Calculate the number of classes to insert
    SET whole_num = COALESCE(whole_num, 0);
    SET num_classes = whole_num / 40 + 1;

    -- Loop to insert records into Classes table
    SET i = 1;
    main_loop: LOOP
        -- Insert record into Classes table

        INSERT INTO Classes (class_name, semester_id, location, day, lesson_start, duration, timestart, subject_code, max_slot)
        VALUES (CONCAT('L', i), p_semester_id, CONCAT('Location', i), p_day, p_lesson_start, 15, 35, p_subject_code, 40);

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

CREATE TRIGGER IF NOT EXISTS updateGPAandCredits
AFTER INSERT ON Attends
FOR EACH ROW
BEGIN
    DECLARE studentGPA DOUBLE;
    DECLARE studentTotalCredits INT;

    -- Check if the action is 'STUDIED'
    IF NEW.action = 'STUDIED' THEN
        -- Calculate the new GPA and totalCredits for the student
        SELECT SUM(max_score * s.credits), SUM(s.credits)
        INTO studentGPA, studentTotalCredits
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
DELIMITER //

CREATE TRIGGER  IF NOT EXISTS  updateGPAandCredits_afterUpdate
AFTER UPDATE ON Attends
FOR EACH ROW
BEGIN
    DECLARE studentGPA DOUBLE;
    DECLARE studentTotalCredits INT;

    -- Check if the action is 'STUDIED' in the updated record
    IF NEW.action = 'STUDIED' THEN
        -- Calculate the new GPA and totalCredits for the student
        SELECT SUM(max_score * s.credits), SUM(s.credits)
        INTO studentGPA, studentTotalCredits
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

DELIMITER //

CREATE TRIGGER register_class
BEFORE INSERT ON Attends
FOR EACH ROW
BEGIN
    DECLARE wholenum INT;
    DECLARE maxslot INT;

    -- Get wholenum and max_slot for the specified class_id
    SELECT whole_num, max_slot INTO wholenum, maxslot
    FROM Classes
    WHERE class_id = NEW.class_id;

    -- Check if whole_num is less than max_slot
    IF wholenum < maxslot AND NEW.action = 'REGISTER' THEN
        -- Update wholenum in the Classes table
        UPDATE Classes
        SET whole_num = wholenum + 1
        WHERE class_id = NEW.class_id;

    ELSEIF wholenum < maxslot AND NEW.action = 'DELETE' THEN
        -- Update wholenum in the Classes table for DELETE action
        UPDATE Classes
        SET whole_num = wholenum - 1
        WHERE class_id = NEW.class_id;
    END IF;
END //

DELIMITER ;




DELIMITER //

CREATE PROCEDURE IF NOT EXISTS InsertStudentData(
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


CREATE PROCEDURE IF NOT EXISTS InsertLecturerData(
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

CREATE PROCEDURE IF NOT EXISTS UpdateData(
    IN p_MS INT,
    IN p_address VARCHAR(255),
    IN p_new_name VARCHAR(255)
)
BEGIN
    -- Update data in Users table
    UPDATE Users
    SET
        name = p_new_name,
        address = p_address
    WHERE MS = p_MS;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS UpdateLecturerData(
    IN p_MS INT,
    IN p_new_level VARCHAR(255),
    IN p_new_name VARCHAR(255),
    IN p_position VARCHAR(255)
)
BEGIN
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

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS DeleteStudentIfNoDependencies(IN p_MS INT)
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

CREATE PROCEDURE IF NOT EXISTS GetRegisteredSubjects(
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
        SUM(CASE WHEN rp.action = 'REGISTER' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE IF NOT EXISTS SearchStudent(
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

CREATE FUNCTION CalcTotalCreditSemesterRP1(p_student_id INT, p_semester_id INT) RETURNS INT
BEGIN
    DECLARE totalCredits INT;

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Students WHERE MS = p_student_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    -- Check if the semester exists
    IF NOT EXISTS (SELECT 1 FROM Semester WHERE semester_id = p_semester_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Semester does not exist';
    END IF;

    -- Calculate total credits for the semester
    SELECT SUM(s.credits)
    INTO totalCredits
    FROM Subjects s
    WHERE s.subject_code IN (
        SELECT rp.subject_code
        FROM registerphase1 rp
        WHERE rp.student_id = p_student_id AND rp.semester_id = p_semester_id
        GROUP BY rp.subject_code
        HAVING SUM(CASE WHEN rp.action = 'REGISTER' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END)
    );

    RETURN totalCredits;
END //

DELIMITER ;

CALL InsertStudentData(
    2115339,
    'Lê Văn Hòa',
    'hoa.levan@hcmut.edu.vn',
    'password789',
    '2001-02-15',
    '789 Pine St',
    1,
    'DC',
    '2022-01-01'
);

CALL InsertStudentData(
    2115340,
    'Nguyễn Thị Mai',
    'mai.nguyenthithi@hcmut.edu.vn',
    'passwordabc',
    '2000-03-22',
    '321 Cedar St',
    0,
    'DD',
    '2022-01-01'
);

CALL InsertStudentData(
    2115341,
    'Võ Văn Tâm',
    'tam.vovantam@hcmut.edu.vn',
    'passwordxyz',
    '2000-06-10',
    '654 Elm St',
    1,
    'MT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115342,
    'Phan Thị Bình',
    'binh.phanthi@hcmut.edu.vn',
    'password123',
    '1999-11-18',
    '987 Birch St',
    0,
    'HC',
    '2022-01-01'
);

CALL InsertStudentData(
    2115343,
    'Lê Văn Đức',
    'duc.levan@hcmut.edu.vn',
    'password456',
    '2001-04-05',
    '741 Walnut St',
    1,
    'QL',
    '2022-01-01'
);

CALL InsertStudentData(
    2115344,
    'Trần Thị Hoàng',
    'hoang.tranthi@hcmut.edu.vn',
    'password789',
    '2000-02-28',
    '852 Pineapple St',
    0,
    'XD',
    '2022-01-01'
);

CALL InsertStudentData(
    2115345,
    'Nguyễn Văn Phú',
    'phu.nguyenvan@hcmut.edu.vn',
    'password987',
    '2000-07-15',
    '963 Orange St',
    1,
    'MO',
    '2022-01-01'
);

CALL InsertStudentData(
    2115346,
    'Trần Thị Hà',
    'ha.tranthi@hcmut.edu.vn',
    'passwordabc',
    '1999-09-30',
    '159 Grape St',
    0,
    'GT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115347,
    'Lê Văn Quân',
    'quan.levan@hcmut.edu.vn',
    'passwordxyz',
    '2001-01-17',
    '369 Mango St',
    1,
    'KU',
    '2022-01-01'
);

CALL InsertStudentData(
    2115338,
    'Trần Thị Anh',
    'anh.tranthi@hcmut.edu.vn',
    'password456',
    '1999-12-31',
    '456 Oak St',
    0,
    'CK',
    '2022-01-01'
);


CALL InsertStudentData(
    2115387,
    'Phạm Thị Hương',
    'huong.phamthi@hcmut.edu.vn',
    'password987',
    '2000-05-20',
    '567 Maple St',
    0,
    'MT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115348,
    'Nguyễn Thị Huệ',
    'hue.nguyenthi@hcmut.edu.vn',
    'password123',
    '2000-08-25',
    '753 Lemon St',
    0,
    'VL',
    '2022-01-01'
);

CALL InsertStudentData(
    2115349,
    'Trần Văn Nam',
    'nam.tranvan@hcmut.edu.vn',
    'password456',
    '1999-10-12',
    '246 Banana St',
    1,
    'KT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115350,
    'Lê Thị Thanh',
    'thanh.lethi@hcmut.edu.vn',
    'password789',
    '2000-05-03',
    '579 Strawberry St',
    0,
    'VP',
    '2022-01-01'
);

CALL InsertStudentData(
    2115351,
    'Phạm Văn Lực',
    'luc.phamvan@hcmut.edu.vn',
    'passwordabc',
    '2001-03-08',
    '864 Raspberry St',
    1,
    'CC',
    '2022-01-01'
);

CALL InsertStudentData(
    2115352,
    'Nguyễn Thị Lan',
    'lan.nguyenthi@hcmut.edu.vn',
    'passwordxyz',
    '2000-12-01',
    '135 Blueberry St',
    0,
    'CN',
    '2022-01-01'
);

CALL InsertStudentData(
    2115353,
    'Võ Văn Khánh',
    'khanh.vovankhanh@hcmut.edu.vn',
    'password123',
    '1999-07-20',
    '246 Blackberry St',
    1,
    'QT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115354,
    'Trương Thị Thúy',
    'thuy.truongthi@hcmut.edu.vn',
    'password456',
    '2000-04-15',
    '579 Kiwi St',
    0,
    'TT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115355,
    'Đặng Văn Khai',
    'khai.dangvan@hcmut.edu.vn',
    'password789',
    '1999-06-28',
    '753 Pineapple St',
    1,
    'BD',
    '2022-01-01'
);

CALL InsertStudentData(
    2115356,
    'Lê Thị Hằng',
    'hang.lethi@hcmut.edu.vn',
    'password987',
    '2001-05-10',
    '864 Mango St',
    0,
    'CK',
    '2022-01-01'
);

CALL InsertStudentData(
    2115357,
    'Nguyễn Văn Khôi',
    'khoi.nguyenvan@hcmut.edu.vn',
    'passwordabc',
    '2000-02-03',
    '135 Coconut St',
    1,
    'DC',
    '2022-01-01'
);

CALL InsertStudentData(
    2115358,
    'Trần Thị Thảo',
    'thao.tranthi@hcmut.edu.vn',
    'passwordxyz',
    '2000-11-18',
    '246 Avocado St',
    0,
    'DD',
    '2022-01-01'
);

CALL InsertStudentData(
    2115359,
    'Phan Văn Hải',
    'hai.phanvan@hcmut.edu.vn',
    'password123',
    '1999-09-22',
    '579 Grape St',
    1,
    'MT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115360,
    'Lê Thị Ngọc',
    'ngoc.lethi@hcmut.edu.vn',
    'password456',
    '2000-07-07',
    '753 Orange St',
    0,
    'HC',
    '2022-01-01'
);

CALL InsertStudentData(
    2115361,
    'Đỗ Văn Hiệu',
    'hieu.dovan@hcmut.edu.vn',
    'password789',
    '2001-01-25',
    '864 Peach St',
    1,
    'QL',
    '2022-01-01'
);

CALL InsertStudentData(
    2115362,
    'Trương Thị Loan',
    'loan.truongthi@hcmut.edu.vn',
    'passwordabc',
    '2000-04-30',
    '135 Plum St',
    0,
    'XD',
    '2022-01-01'
);

CALL InsertStudentData(
    2115363,
    'Vũ Văn Hòa',
    'hoa.vuvan@hcmut.edu.vn',
    'passwordxyz',
    '1999-12-15',
    '246 Pomegranate St',
    1,
    'MO',
    '2022-01-01'
);

CALL InsertStudentData(
    2115364,
    'Nguyễn Thị Phương',
    'phuong.nguyenthi@hcmut.edu.vn',
    'password123',
    '2001-10-20',
    '579 Passion Fruit St',
    0,
    'GT',
    '2022-01-01'
);

CALL InsertStudentData(
    2115365,
    'Lê Văn Tiến',
    'tien.levan@hcmut.edu.vn',
    'password456',
    '2000-08-05',
    '753 Raspberry St',
    1,
    'KU',
    '2022-01-01'
);

CALL InsertStudentData(
    2115366,
    'Phạm Thị Lý',
    'ly.phamthi@hcmut.edu.vn',
    'password789',
    '1999-06-10',
    '864 Blackcurrant St',
    0,
    'VL',
    '2022-01-01'
);

CALL InsertStudentData(
    2115367,
    'Hoàng Văn Linh',
    'linh.hoangvan@hcmut.edu.vn',
    'password987',
    '2001-05-28',
    '135 Watermelon St',
    1,
    'KT',
    '2022-01-01'
);

CALL InsertLecturerData(121, 'Trần Thanh A', 'tran.thanh.a@hcmut.edu.vn', 'password123', '1985-05-20', '123 Main St', TRUE, 'BD', 'Professor', 'Head of Department', NULL);
CALL InsertLecturerData(122, 'Nguyễn Thị B', 'nguyen.thi.b@hcmut.edu.vn', 'securepass789', '1980-09-10', '456 Oak St', FALSE, 'CK', 'Associate Professor', 'Lecturer', NULL);
CALL InsertLecturerData(123, 'Lê Văn C', 'le.van.c@hcmut.edu.vn', 'passsecure123', '1987-12-01', '789 Elm St', TRUE, 'DC', 'Assistant Professor', 'Researcher', NULL);
CALL InsertLecturerData(124, 'Phạm Thị D', 'pham.thi.d@hcmut.edu.vn', 'mypassword456', '1982-03-25', '567 Pine St', FALSE, 'DD', 'Professor', 'Dean', NULL);
CALL InsertLecturerData(125, 'Hoàng Anh E', 'hoang.anh.e@hcmut.edu.vn', 'securepass321', '1989-07-15', '890 Cedar St', TRUE, 'MT', 'Associate Professor', 'Coordinator', NULL);
CALL InsertLecturerData(126, 'Đặng Văn F', 'dang.van.f@hcmut.edu.vn', 'mypassword789', '1994-01-05', '234 Birch St', FALSE, 'HC', 'Assistant Professor', 'Advisor', NULL);
CALL InsertLecturerData(127, 'Vũ Thị G', 'vu.thi.g@hcmut.edu.vn', 'password456', '1975-08-20', '678 Maple St', TRUE, 'QL', 'Professor', 'Head of Research', NULL);
CALL InsertLecturerData(128, 'Ngô Thị H', 'ngo.thi.h@hcmut.edu.vn', 'securepass456', '1981-12-10', '345 Walnut St', FALSE, 'XD', 'Associate Professor', 'Coordinator', NULL);
CALL InsertLecturerData(129, 'Mai Minh I', 'mai.minh.i@hcmut.edu.vn', 'passsecure', '1989-04-24', '456 Oak St', TRUE, 'MO', 'Assistant Professor', 'Researcher', NULL);
CALL InsertLecturerData(130, 'Lý Văn K', 'ly.van.k@hcmut.edu.vn', 'mypassword123', '1996-06-12', '789 Elm St', FALSE, 'GT', 'Professor', 'Dean', NULL);
CALL InsertLecturerData(131, 'Trần Thị L', 'tran.thi.l@hcmut.edu.vn', 'password123', '1985-05-20', '123 Main St', TRUE, 'KU', 'Professor', 'Head of Department', NULL);
CALL InsertLecturerData(132, 'Nguyễn Văn M', 'nguyen.van.m@hcmut.edu.vn', 'securepass789', '1980-09-10', '456 Oak St', FALSE, 'VL', 'Associate Professor', 'Lecturer', NULL);
CALL InsertLecturerData(133, 'Lê Thị N', 'le.thi.n@hcmut.edu.vn', 'passsecure123', '1987-12-01', '789 Elm St', TRUE, 'KT', 'Assistant Professor', 'Researcher', NULL);
CALL InsertLecturerData(134, 'Phạm Văn O', 'pham.van.o@hcmut.edu.vn', 'mypassword456', '1982-03-25', '567 Pine St', FALSE, 'VP', 'Professor', 'Dean', NULL);
CALL InsertLecturerData(135, 'Hoàng Thị P', 'hoang.thi.p@hcmut.edu.vn', 'securepass321', '1989-07-15', '890 Cedar St', TRUE, 'CC', 'Associate Professor', 'Coordinator', NULL);
CALL InsertLecturerData(136, 'Đặng Văn Q', 'dang.van.q@hcmut.edu.vn', 'mypassword789', '1994-01-05', '234 Birch St', FALSE, 'CN', 'Assistant Professor', 'Advisor', NULL);
CALL InsertLecturerData(137, 'Vũ Thị R', 'vu.thi.r@hcmut.edu.vn', 'password456', '1975-08-20', '678 Maple St', TRUE, 'QT', 'Professor', 'Head of Research', NULL);
CALL InsertLecturerData(138, 'Ngô Văn S', 'ngo.van.s@hcmut.edu.vn', 'securepass456', '1981-12-10', '345 Walnut St', FALSE, 'TT', 'Associate Professor', 'Coordinator', NULL);
CALL InsertLecturerData(139, 'Mai Minh T', 'mai.minh.t@hcmut.edu.vn', 'passsecure', '1989-04-24', '456 Oak St', TRUE, 'HC', 'Assistant Professor', 'Researcher', NULL);
CALL InsertLecturerData(140, 'Lý Thị U', 'ly.thi.u@hcmut.edu.vn', 'mypassword123', '1996-06-12', '789 Elm St', FALSE, 'MT', 'Professor', 'Dean', NULL);
CALL InsertLecturerData(141, 'Trần Văn X', 'tran.van.x@hcmut.edu.vn', 'securepass789', '1983-05-18', '123 Pine St', TRUE, 'MO', 'Associate Professor', 'Lecturer', NULL);
CALL InsertLecturerData(142, 'Nguyễn Thị Y', 'nguyen.thi.y@hcmut.edu.vn', 'mypassword321', '1988-09-08', '456 Cedar St', FALSE, 'CK', 'Assistant Professor', 'Researcher', NULL);
CALL InsertLecturerData(143, 'Lê Văn Z', 'le.van.z@hcmut.edu.vn', 'password123', '1977-12-21', '789 Birch St', TRUE, 'DC', 'Professor', 'Head of Department', NULL);
CALL InsertLecturerData(144, 'Phạm Thị A', 'pham.thi.a@hcmut.edu.vn', 'securepass', '1980-02-14', '567 Oak St', FALSE, 'GT', 'Associate Professor', 'Coordinator', NULL);
CALL InsertLecturerData(146, 'Đặng Thị C', 'dang.thi.c@hcmut.edu.vn', 'securepass', '1991-01-01', '234 Pine St', FALSE, 'KT', 'Professor', 'Dean', NULL);
CALL InsertLecturerData(150, 'Lý Thị G', 'ly.thi.g@hcmut.edu.vn', 'mypassword', '1995-06-11', '789 Maple St', FALSE, 'HC', 'Associate Professor', 'Coordinator', NULL);


INSERT IGNORE INTO `classes` (`class_id`, `class_name`, `is_lab`, `max_slot`, `subject_code`, `semester_id`, `location`, `day`, `lesson_start`, `duration`, `timestart`, `createdAt`, `updatedAt`) VALUES
(53, 'L1', NULL, 40, 'MT2013', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:17', '2023-11-29 14:12:17'),
(54, 'L1', NULL, 40, 'CO2013', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:31', '2023-11-29 14:12:31'),
(55, 'L1', NULL, 40, 'CO3021', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(56, 'L1', NULL, 40, 'PH1003', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(57, 'L1', NULL, 40, 'CO3011', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(58, 'L1', NULL, 40, 'MT1003', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(59, 'L1', NULL, 40, 'CO3041', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(60, 'L1', NULL, 40, 'CO4031', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(61, 'L1', NULL, 40, 'CO3061', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(62, 'L1', NULL, 40, 'CO3083', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(63, 'L1', NULL, 40, 'MT2013', 231, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(64, 'L1', NULL, 40, 'CO2013', 231, 'Location1', 2, 8, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(65, 'L1', NULL, 40, 'CO3021', 231, 'Location1', 4, 9, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(66, 'L1', NULL, 40, 'PH1003', 231, 'Location1', 1, 10, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(67, 'L1', NULL, 40, 'CO3011', 231, 'Location1', 5, 11, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(68, 'L3', NULL, 40, 'MT2013', 221, 'Location1', 3, 7, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(69, 'L1', NULL, 40, 'CO2013', 231, 'Location1', 2, 8, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(70, 'L1', NULL, 40, 'CO3021', 231, 'Location1', 4, 9, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(71, 'L1', NULL, 40, 'PH1003', 231, 'Location1', 1, 10, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(72, 'L1', NULL, 40, 'CO3011', 231, 'Location1', 5, 11, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(73, 'L1', NULL, 40, 'MT1003', 231, 'Location1', 3, 12, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(74, 'L1', NULL, 40, 'CO3041', 231, 'Location1', 2, 13, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(75, 'L1', NULL, 40, 'CO4031', 231, 'Location1', 4, 14, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(76, 'L1', NULL, 40, 'CO3061', 231, 'Location1', 1, 15, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(77, 'L1', NULL, 40, 'CO3083', 231, 'Location1', 5, 16, 15, 35, '2023-11-29 14:12:44', '2023-11-29 14:12:44'),
(78, 'L2', NULL, 40, 'MT2013', 212, 'Location2', 2, 8, 15, 35, '2023-11-29 14:14:17', '2023-11-29 14:14:17'),
(79, 'L2', NULL, 40, 'CO2013', 222, 'Location2', 4, 9, 15, 35, '2023-11-29 14:14:31', '2023-11-29 14:14:31'),
(80, 'L2', NULL, 40, 'CO3021', 213, 'Location2', 1, 10, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(81, 'L2', NULL, 40, 'PH1003', 211, 'Location2', 5, 11, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(82, 'L2', NULL, 40, 'CO3011', 212, 'Location2', 3, 12, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(83, 'L2', NULL, 40, 'MT1003', 222, 'Location2', 2, 13, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(84, 'L2', NULL, 40, 'CO3041', 213, 'Location2', 4, 14, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(85, 'L2', NULL, 40, 'CO4031', 211, 'Location2', 1, 15, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(86, 'L2', NULL, 40, 'CO3061', 212, 'Location2', 5, 16, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(87, 'L2', NULL, 40, 'CO3083', 213, 'Location2', 3, 7, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(88, 'L2', NULL, 40, 'MT2013', 211, 'Location2', 4, 8, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(89, 'L2', NULL, 40, 'CO2013', 212, 'Location2', 1, 9, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(90, 'L2', NULL, 40, 'CO3021', 222, 'Location2', 5, 10, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(91, 'L2', NULL, 40, 'PH1003', 213, 'Location2', 3, 11, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(92, 'L2', NULL, 40, 'CO3011', 211, 'Location2', 2, 12, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(93, 'L2', NULL, 40, 'MT2013', 212, 'Location2', 4, 13, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44'),
(94, 'L2', NULL, 40, 'CO2013', 222, 'Location2', 1, 14, 15, 35, '2023-11-29 14:14:44', '2023-11-29 14:14:44');

INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CH1003', 211);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO2011', 212);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3021', 213);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO2039', 221);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3041', 222);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4029', 223);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('MT2013', 231);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('PH1003', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('SP1035', 231);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3013', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3022', 221);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4035', 222);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3031', 223);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4037', 211);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4039', 212);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3045', 213);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4337', 221);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3089', 222);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3093', 223);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('MT1007', 231);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3022', 221);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4035', 222);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3031', 223);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4037', 211);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4039', 212);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3045', 213);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO4337', 221);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3089', 222);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3093', 223);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('MT1007', 231);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('MT2013', 231);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('MT1008', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('PH1003', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('SP1033', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3051', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3057', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3061', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3065', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3069', 232);
INSERT IGNORE INTO Open_at (subject_code, semester_id) VALUES ('CO3071', 232);

INSERT INTO Teach (subject_code, lecturer_id) VALUES
  ('CH1003', 121),
  ('CO1005', 121),
  ('CO1027', 121),
  ('CO2001', 121),
  ('CO2013', 121),
  ('CO2017', 122),
  ('CO2003', 122),
  ('CO2011', 122),
  ('CO2013', 122),
  ('CO3021', 122),
  ('CO3023', 123),
  ('CO3027', 123),
  ('CO3031', 123),
  ('CO3033', 123),
  ('CO3045', 124),
  ('CO3047', 124),
  ('CO3049', 124),
  ('CO3051', 124),
  ('CO3061', 125),
  ('CO3065', 125),
  ('CO3067', 125),
  ('CO3069', 125),
  ('CO3071', 126),
  ('CO3083', 126),
  ('CO3085', 126),
  ('CO3089', 126),
  ('CO3093', 127),
  ('CO3094', 127),
  ('CO3115', 127),
  ('CO3117', 127),
  ('CO3335', 128),
  ('CO4025', 128),
  ('CO4029', 128),
  ('CO4031', 129),
  ('CO4033', 129),
  ('CO4035', 129),
  ('CO4037', 129),
  ('CO4039', 130),
  ('CO4337', 130),
  ('IM1025', 131),
  ('IM1027', 131),
  ('IM3001', 132),
  ('MT1003', 133),
  ('MT1005', 133),
  ('MT1007', 133),
  ('MT2013', 134),
  ('PH1003', 135),
  ('PH1007', 135),
  ('SP1007', 136),
  ('SP1031', 136),
  ('SP1033', 136),
  ('SP1035', 137),
  ('SP1037', 137),
  ('SP1039', 137),
    ('CO3035', 138),
  ('CO3037', 138),
  ('CO3041', 138),
  ('CO3043', 138),
  ('CO3045', 139),
  ('CO3047', 139),
  ('CO3049', 139),
  ('CO3051', 140),
  ('CO3057', 140),
  ('CO3059', 140),
  ('CO3061', 141),
  ('CO3065', 141),
  ('CO3067', 141),
  ('CO3069', 142),
  ('CO3071', 142),
  ('CO3083', 142),
  ('CO3085', 143),
  ('CO3089', 143),
  ('CO3093', 143),
  ('CO3094', 144),
  ('CO3115', 144),
  ('CO3117', 144),
  ('CO4039', 146),
  ('CO4337', 146),
  ('MT1003', 150),
  ('MT1005', 150),
  ('MT1007', 150);

INSERT IGNORE INTO Dependents (d_name, relationship, sex, student_id)
VALUES
('Lê Thị Mai', 'Sister', 0, 2115339),
('Lê Văn Chí', 'Brother', 1, 2115339),
('Nguyễn Văn Nam', 'Father', 1, 2115340),
('Nguyễn Thị Hoa', 'Mother', 0, 2115340),
('Võ Thị Thu', 'Mother', 0, 2115341),
('Võ Văn Hải', 'Brother', 1, 2115341),
('Phạm Văn Lực', 'Father', 1, 2115387),
('Phạm Thị Lan', 'Sister', 0, 2115387),
('Nguyễn Văn Hải', 'Father', 1, 2115348),
('Nguyễn Thị Lan', 'Sister', 0, 2115348),
('Trần Thị Loan', 'Mother', 0, 2115349),
('Trần Văn Quân', 'Brother', 1, 2115349),
('Lê Văn Tiến', 'Father', 1, 2115350),
('Lê Thị Ngọc', 'Sister', 0, 2115350),
('Hoàng Thị Hằng', 'Mother', 0, 2115367),
('Hoàng Văn Khai', 'Brother', 1, 2115367);

INSERT IGNORE INTO Prerequisite_Subejct (subject_code, prerequisite_subject_code) VALUES
('CH1003', 'MT1004'),
('CO1005', 'MT1003'),
('CO1027', 'CO1005'),
('CO2001', 'SP1007'),
('CO2013', 'CO2003'),
('CO2039', 'CO1027'),
('CO3011', 'CO2001'),
('CO3021', 'CO2013'),
('CO3033', 'CO3021'),
('CO3051', 'CO3049'),
('CO3067', 'CO3031'),
('CO3085', 'CO3013'),
('CO3115', 'CO3011'),
('CO3117', 'MT2013'),
('CO4337', 'CO4029'),
('IM1025', 'CO3011'),
('IM1027', 'SP1031'),
('IM3001', 'CO3011'),
('MT1005', 'MT1004'),
('MT2013', 'MT1005'),
('PH1003', 'MT1004'),
('SP1033', 'SP1031'),
('SP1035', 'SP1033'),
('SP1037', 'SP1035'),
('SP1039', 'SP1037'),
('CO4031', 'CO3021'),
('CO4033', 'CO2013'),
('CO4035', 'CO3011'),
('CO4037', 'CO3021'),
('CO4039', 'CO3033'),
('CO4337', 'CO4029'),
('CO4025', 'CO3031'),
('CO3061', 'CO3013'),
('CO3065', 'CO3001'),
('CO3069', 'CO3033'),
('CO3071', 'CO3027'),
('CO3083', 'CO3069'),
('CO3089', 'CO3023'),
('CO3093', 'CO3027'),
('CO3115', 'CO3011'),
('CO3117', 'MT2013'),
('CO3335', 'CO3001');


INSERT INTO `attends` (`student_id`, `class_id`, `score`, `action`, `createdAt`, `updatedAt`)
VALUES
(2115339, 53, NULL, 'REGISTER', '2023-11-29 13:30:00', '2023-11-29 13:30:00'),
(2115340, 54, NULL, 'REGISTER', '2023-11-29 13:31:00', '2023-11-29 13:31:00'),
(2115341, 55, NULL, 'REGISTER', '2023-11-29 13:32:00', '2023-11-29 13:32:00'),
(2115342, 56, NULL, 'REGISTER', '2023-11-29 13:33:00', '2023-11-29 13:33:00'),
(2115343, 57, NULL, 'REGISTER', '2023-11-29 13:34:00', '2023-11-29 13:34:00'),
(2115344, 58, NULL, 'REGISTER', '2023-11-29 13:35:00', '2023-11-29 13:35:00'),
(2115345, 59, NULL, 'REGISTER', '2023-11-29 13:36:00', '2023-11-29 13:36:00'),
(2115346, 60, NULL, 'REGISTER', '2023-11-29 13:37:00', '2023-11-29 13:37:00'),
(2115347, 61, NULL, 'REGISTER', '2023-11-29 13:38:00', '2023-11-29 13:38:00'),
(2115338, 62, NULL, 'REGISTER', '2023-11-29 13:39:00', '2023-11-29 13:39:00'),
(2115387, 63, NULL, 'REGISTER', '2023-11-29 13:40:00', '2023-11-29 13:40:00'),
(2115348, 64, NULL, 'REGISTER', '2023-11-29 13:41:00', '2023-11-29 13:41:00'),
(2115349, 65, NULL, 'REGISTER', '2023-11-29 13:42:00', '2023-11-29 13:42:00'),
(2115350, 66, NULL, 'REGISTER', '2023-11-29 13:43:00', '2023-11-29 13:43:00'),
(2115353, 67, NULL, 'REGISTER', '2023-11-29 13:44:00', '2023-11-29 13:44:00'),
(2115354, 68, NULL, 'REGISTER', '2023-11-29 13:45:00', '2023-11-29 13:45:00'),
(2115355, 69, NULL, 'REGISTER', '2023-11-29 13:46:00', '2023-11-29 13:46:00'),
(2115356, 70, NULL, 'REGISTER', '2023-11-29 13:47:00', '2023-11-29 13:47:00'),
(2115357, 71, NULL, 'REGISTER', '2023-11-29 13:48:00', '2023-11-29 13:48:00'),
(2115358, 72, NULL, 'REGISTER', '2023-11-29 13:49:00', '2023-11-29 13:49:00'),
(2115359, 73, NULL, 'REGISTER', '2023-11-29 13:50:00', '2023-11-29 13:50:00'),
(2115360, 74, NULL, 'REGISTER', '2023-11-29 13:51:00', '2023-11-29 13:51:00'),
(2115361, 75, NULL, 'REGISTER', '2023-11-29 13:52:00', '2023-11-29 13:52:00'),
(2115362, 76, NULL, 'REGISTER', '2023-11-29 13:53:00', '2023-11-29 13:53:00'),
(2115363, 77, NULL, 'REGISTER', '2023-11-29 13:54:00', '2023-11-29 13:54:00'),
(2115364, 53, NULL, 'REGISTER', '2023-11-29 13:55:00', '2023-11-29 13:55:00'),
(2115365, 54, NULL, 'REGISTER', '2023-11-29 13:56:00', '2023-11-29 13:56:00'),
(2115366, 55, NULL, 'REGISTER', '2023-11-29 13:57:00', '2023-11-29 13:57:00'),
(2115367, 56, NULL, 'REGISTER', '2023-11-29 13:58:00', '2023-11-29 13:58:00'),
(2115338, 62, NULL, 'DELETE', '2023-11-29 13:39:00', '2023-11-29 13:39:00'),
(2115349, 65, NULL, 'DELETE', '2023-11-29 13:42:00', '2023-11-29 13:42:00'),
(2115356, 70, NULL, 'DELETE', '2023-11-29 13:47:00', '2023-11-29 13:47:00'),
(2115358, 72, NULL, 'DELETE', '2023-11-29 13:49:00', '2023-11-29 13:49:00'),
(2115361, 75, NULL, 'DELETE', '2023-11-29 13:52:00', '2023-11-29 13:52:00'),
(2115364, 53, NULL, 'DELETE', '2023-11-29 13:55:00', '2023-11-29 13:55:00'),
(2115366, 55, NULL, 'DELETE', '2023-11-29 13:57:00', '2023-11-29 13:57:00'),
(2115357, 84, 7.2, 'STUDIED', '2023-11-29 14:06:00', '2023-11-29 14:06:00'),
(2115358, 85, 6.7, 'STUDIED', '2023-11-29 14:07:00', '2023-11-29 14:07:00'),
(2115359, 86, 9.5, 'STUDIED', '2023-11-29 14:08:00', '2023-11-29 14:08:00'),
(2115362, 70, 8.1, 'STUDIED', '2023-11-29 14:09:00', '2023-11-29 14:09:00'),
(2115362, 71, 7.4, 'STUDIED', '2023-11-29 14:10:00', '2023-11-29 14:10:00'),
(2115362, 72, 8.9, 'STUDIED', '2023-11-29 14:11:00', '2023-11-29 14:11:00'),
(2115362, 73, 6.5, 'STUDIED', '2023-11-29 14:12:00', '2023-11-29 14:12:00'),
(2115362, 74, 9.0, 'STUDIED', '2023-11-29 14:13:00', '2023-11-29 14:13:00'),
(2115367, 92, 7.7, 'STUDIED', '2023-11-29 14:14:00', '2023-11-29 14:14:00'),
(2115367, 93, 8.3, 'STUDIED', '2023-11-29 14:15:00', '2023-11-29 14:15:00'),
(2115367, 68, 8.3, 'STUDIED', '2023-11-29 14:15:00', '2023-11-29 14:15:00'),
(2115367, 53, 4.0, 'STUDIED', '2023-11-29 14:15:00', '2023-11-29 14:15:00'),
(2115367, 94, 6.9, 'STUDIED', '2023-11-29 14:16:00', '2023-11-29 14:16:00');