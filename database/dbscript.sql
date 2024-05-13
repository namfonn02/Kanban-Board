-- create databease
CREATE DATABASE IF NOT EXISTS `itb-kk`;

USE `itb-kk`;

-- drop table
DROP TABLE statuses;
DROP TABLE tasks;

-- create tasks table
CREATE TABLE IF NOT EXISTS tasks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  description VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  assignees VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  status ENUM('NO_STATUS', 'TO_DO', 'DOING', 'DONE') NOT NULL DEFAULT 'NO_STATUS',
  createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- insert data io tasks table 
INSERT INTO tasks (title, description, assignees, status, createdOn, updatedOn)
VALUES (TRIM('TaskTitle1TaskTitle2TaskTitle3TaskTitle4TaskTitle5TaskTitle6TaskTitle7TaskTitle8TaskTitle9TaskTitle0'), TRIM('Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti1Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti2Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti3Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti4Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti5'), 'Assignees1Assignees2Assignees3', 'NO_STATUS', STR_TO_DATE('22-4-2024 09:00:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('22-4-2024 09:00:00', '%d-%m-%Y %H:%i:%s')),
(TRIM('Repository'), TRIM(''), '', 'TO_DO', STR_TO_DATE('22-4-2024 09:05:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('22-4-2024 14:00:00', '%d-%m-%Y %H:%i:%s')),
(TRIM('ดาต้าเบส'), TRIM('ສ້າງຖານຂໍ້ມູນ'), 'あなた、彼、彼女 (私ではありません)', 'DOING', STR_TO_DATE('22-4-2024 09:10:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('25-4-2024 00:00:00', '%d-%m-%Y %H:%i:%s')),
(TRIM(' _Infrastructure_ '), TRIM(' _Setup containers_ '), 'ไก่งวง กับ เพนกวิน', 'DONE', STR_TO_DATE('22-4-2024 09:15:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('22-4-2024 10:00:00', '%d-%m-%Y %H:%i:%s'));

-- select tasks
SELECT * FROM tasks order by createdOn;

-- create statuses table 
CREATE TABLE IF NOT EXISTS statuses (
  statusId INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE DEFAULT 'NO_STATUS', 
  description VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE = InnoDB;

-- insert data to status table
INSERT INTO statuses (name,description) 
VALUES (TRIM('No Status'), TRIM('No status assigned yet')),
(TRIM('To Do'), TRIM('Task is to be done')),
(TRIM('Doing'), TRIM('Task is currently in progress')),
(TRIM('Done'), TRIM('Task has been completed'));

-- create tasksV2 table 
CREATE TABLE IF NOT EXISTS tasksV2 (
  taskId INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  description VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  assignees VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  statusId INT,
  createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (statusId) REFERENCES statuses(statusId)
) ENGINE = InnoDB;

-- insert data to tasksV2 table

INSERT INTO tasksV2 (title, description, assignees, statusId, createdOn, updatedOn)
VALUES (TRIM('TaskTitle1TaskTitle2TaskTitle3TaskTitle4TaskTitle5TaskTitle6TaskTitle7TaskTitle8TaskTitle9TaskTitle0'), TRIM('Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti1Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti2Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti3Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti4Descripti1Descripti2Descripti3Descripti4Descripti5Descripti6Descripti7Descripti8Descripti9Descripti5'), 'Assignees1Assignees2Assignees3', 1,STR_TO_DATE('22-4-2024 09:00:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('22-4-2024 09:00:00', '%d-%m-%Y %H:%i:%s')),
(TRIM('Repository'), TRIM(''), '', 2, STR_TO_DATE('22-4-2024 09:05:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('22-4-2024 14:00:00', '%d-%m-%Y %H:%i:%s')),
(TRIM('ดาต้าเบส'), TRIM('ສ້າງຖານຂໍ້ມູນ'), 'あなた、彼、彼女 (私ではありません)', 3, STR_TO_DATE('22-4-2024 09:10:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('25-4-2024 00:00:00', '%d-%m-%Y %H:%i:%s')),
(TRIM(' _Infrastructure_ '), TRIM(' _Setup containers_ '), 'ไก่งวง กับ เพนกวิน', 4, STR_TO_DATE('22-4-2024 09:15:00', '%d-%m-%Y %H:%i:%s'), STR_TO_DATE('22-4-2024 10:00:00', '%d-%m-%Y %H:%i:%s'));

SELECT * FROM tasksV2 order by createdOn;
SELECT * FROM statuses;

SELECT t.taskId, t.title, t.description, t.assignees, s.statusName, t.createdOn, t.updatedOn
FROM tasksV2 t join statuses s on t.statusId = s.statusId;