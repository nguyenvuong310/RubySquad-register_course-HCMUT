CREATE TABLE IF NOT EXISTS Semester (
  semester_id INTEGER not null PRIMARY KEY,
  timestart TIMESTAMP NOT NULL,
  semester_name VARCHAR(255),
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
  id INTEGER not null PRIMARY KEY,
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
  FOREIGN KEY (lecturer_id) REFERENCES Lecturers(id),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS Students (
  id int not null AUTO_INCREMENT PRIMARY KEY,
  MS INT,
  FOREIGN KEY (MS) REFERENCES Users(MS),
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
  score INTEGER,
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


DELIMITER //

CREATE PROCEDURE IF NOT EXISTS createClass(
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

CREATE PROCEDURE IF NOT EXISTS UpdateStudentData(
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

CREATE PROCEDURE IF NOT EXISTS UpdateLecturerData(
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
        SUM(CASE WHEN rp.action = 'INSERT' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END);
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

-- Continue adding more CALL statements with unique data
-- ...

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
-- Clone the next 10 records
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
-- Continue cloning the next 10 records
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






