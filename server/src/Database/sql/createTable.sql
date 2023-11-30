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
-- CALL createClass("231", "MT2013", "7", "3");
-- CALL createClass("231", "CO2013", "7", "3");
-- CALL createClass("231", "CO3021", "7", "3");
-- CALL createClass("231", "PH1003", "7", "3");
-- CALL createClass("231", "CO3011", "7", "3");
-- CALL createClass("231", "MT1003", "7", "3");
-- CALL createClass("231", "CO3041", "7", "3");
-- CALL createClass("231", "CO4031", "7", "3");
-- CALL createClass("231", "CO3061", "7", "3");
-- CALL createClass("231", "CO3083", "7", "3");
-- CALL createClass("231", "MT2013", "7", "3");
-- CALL createClass("231", "CO2013", "8", "2");
-- CALL createClass("231", "CO3021", "9", "4");
-- CALL createClass("231", "PH1003", "10", "1");
-- CALL createClass("231", "CO3011", "11", "5");
-- CALL createClass("231", "MT2013", "7", "3");
-- CALL createClass("231", "CO2013", "8", "2");
-- CALL createClass("231", "CO3021", "9", "4");
-- CALL createClass("231", "PH1003", "10", "1");
-- CALL createClass("231", "CO3011", "11", "5");
-- CALL createClass("231", "MT1003", "12", "3");
-- CALL createClass("231", "CO3041", "13", "2");
-- CALL createClass("231", "CO4031", "14", "4");
-- CALL createClass("231", "CO3061", "15", "1");
-- CALL createClass("231", "CO3083", "16", "5");
---insert data opent_at






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
(2115367, 56, NULL, 'REGISTER', '2023-11-29 13:58:00', '2023-11-29 13:58:00');
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
(2115360, 87, 8.1, 'STUDIED', '2023-11-29 14:09:00', '2023-11-29 14:09:00'),
(2115361, 88, 7.4, 'STUDIED', '2023-11-29 14:10:00', '2023-11-29 14:10:00'),
(2115362, 89, 8.9, 'STUDIED', '2023-11-29 14:11:00', '2023-11-29 14:11:00'),
(2115363, 90, 6.5, 'STUDIED', '2023-11-29 14:12:00', '2023-11-29 14:12:00'),
(2115364, 91, 9.0, 'STUDIED', '2023-11-29 14:13:00', '2023-11-29 14:13:00'),
(2115365, 92, 7.7, 'STUDIED', '2023-11-29 14:14:00', '2023-11-29 14:14:00'),
(2115366, 93, 8.3, 'STUDIED', '2023-11-29 14:15:00', '2023-11-29 14:15:00'),
(2115367, 94, 6.9, 'STUDIED', '2023-11-29 14:16:00', '2023-11-29 14:16:00');
-- class register 
INSERT INTO `attends` (`student_id`, `class_id`, `score`, `action`, `createdAt`, `updatedAt`)
VALUES
(2115339, 53, NULL, 'register', '2023-11-29 13:30:00', '2023-11-29 13:30:00'),
(2115340, 54, NULL, 'register', '2023-11-29 13:31:00', '2023-11-29 13:31:00'),
(2115341, 55, NULL, 'register', '2023-11-29 13:32:00', '2023-11-29 13:32:00'),