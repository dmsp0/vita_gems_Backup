
drop database if exists HRDB;
create database HRDB;
use HRDB;

-- 전사원 인적 정보 table 생성
CREATE TABLE HRInformation (
    employeeName VARCHAR(100) NOT NULL, -- 사원명
    birthday DATE NOT NULL, -- 생년월일
    phoneNum VARCHAR(20) NOT NULL, -- 전화번호
    department ENUM('MK', 'MN', 'DV') NOT NULL, -- 부서
    employeeRank ENUM('사원', '대리','과장','차장','부장') NOT NULL, -- 직급
    joinDate DATE NOT NULL, -- 입사일
    employeepassword VARCHAR(100) NOT NULL,
    gender ENUM('남', '여') NOT NULL,
    address VARCHAR(255),
    bankAccountNum VARCHAR(100),
    email VARCHAR(100),
    employeePhoto BLOB,
    employeeCode VARCHAR(20) NOT NULL,
    authority ENUM('user', 'admin') NOT NULL,
    PRIMARY KEY (employeeCode)
);

-- 비밀번호 자동 생성 트리거.
DELIMITER //
CREATE TRIGGER before_HRInformation_insert
BEFORE INSERT ON HRInformation
FOR EACH ROW
BEGIN
    SET NEW.employeepassword = CONCAT(SUBSTRING(NEW.department, 1, 2), SUBSTRING(NEW.phoneNum, -4));
END;
//
DELIMITER ;


-- 사원코드 자동 조합 + 증가 트리거 생성
DELIMITER //

CREATE TRIGGER generate_employee_code BEFORE INSERT ON HRInformation
FOR EACH ROW
BEGIN
    DECLARE department_code CHAR(2);

    IF NEW.department = 'MK' THEN
        SET department_code = 'MK';
    ELSEIF NEW.department = 'MN' THEN
        SET department_code = 'MN';
    ELSE
        SET department_code = 'DV';
    END IF;

    SET NEW.employeeCode = CONCAT(YEAR(NEW.joinDate), department_code, LPAD((SELECT COUNT(*) + 1 FROM HRInformation WHERE department = NEW.department AND YEAR(joinDate) = YEAR(NEW.joinDate)), 3, '0'));
END;
//

DELIMITER ;

-- (회의)
-- 전화번호 같은것은 저장못하는 제약조건
ALTER TABLE HRInformation ADD UNIQUE INDEX idx_unique_PhoneNum (PhoneNum);

-- 날짜별 근태 기록 table
CREATE TABLE attendance (
    employeeCode VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    startTimeForWork TIME, -- 출근시간
    endTimeForWork TIME, -- 퇴근시간
    status ENUM('출장', '출근', '외근', '월차', '반차','지각','조퇴','결근','NULL'),
    PRIMARY KEY (employeeCode, date), -- (회의)
    FOREIGN KEY (employeeCode) REFERENCES HRInformation (employeeCode)
);

-- 사원별 근태 기록 table
CREATE TABLE totalattendance (
    employeeCode VARCHAR(20) NOT NULL PRIMARY KEY,
    employeeName VARCHAR(100) NOT NULL,
    totalWorkCount INT(20) DEFAULT 0,
    attendanceCount INT(20) DEFAULT 0,
    businesstripCount INT(20) DEFAULT 0,
    outsideWorkCount INT(20) DEFAULT 0,
    vacation double(2,1) DEFAULT 0.0,
    monthlyLeave INT(20) DEFAULT 0,
    halfDayLeave INT(20) DEFAULT 0,
    lateness INT(20) DEFAULT 0,
    earlyLeave INT(20) DEFAULT 0,
    absence INT(20) DEFAULT 0
);

drop trigger if exists after_HRInformation_create;

-- 새로운 사원 등록시 사원별 근태기록 table에 해당 사원 튜플 생성시키는 트리거.
DELIMITER //
CREATE TRIGGER after_HRInformation_insert
AFTER INSERT ON HRInformation
FOR EACH ROW
BEGIN
	IF NOT EXISTS (SELECT * FROM totalattendance WHERE employeeCode = NEW.employeeCode)THEN
        INSERT INTO totalattendance (employeeCode, employeeName, totalWorkCount, attendanceCount, businesstripCount, outsideWorkCount, Vacation, monthlyLeave, halfDayLeave, lateness, earlyLeave, absence)
        SELECT NEW.employeeCode, employeeName, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM HRInformation WHERE employeeCode = NEW.employeeCode;
    END IF;
    END;
//
DELIMITER ;

-- 트리거 설명
-- attendance테이블에 새로운 출근 데이터가 추가될때 totalattendance테이블을 자동으로 업데이트 하는 트리거
-- 새로운 사원이 추가될때는 그 사원의 데이터를 totalattendance에 삽입하고,
-- 기존사원의 출근 데이터가 추가될때는 해당 사원의 근무 통계를 업데이트 함

drop trigger if exists after_attendance_insert;


-- 날짜별 근태 table에 insert 발생시 사원별 근태 table에서 기존 사원의 근무 통계를 업데이트하는 트리거.
DROP TRIGGER IF EXISTS after_attendance_insert;
DELIMITER //

CREATE TRIGGER after_attendance_insert
AFTER INSERT ON attendance
FOR EACH ROW
BEGIN
    DECLARE leaveAmount DECIMAL(5,1); -- 반차일 경우 휴가 사용량

    IF NEW.status = 'halfDayLeave' THEN
        SET leaveAmount = 0.5;
    ELSE
        SET leaveAmount = 1.0;
    END IF;

    UPDATE totalattendance
    SET totalWorkCount = totalWorkCount + IF(NEW.status IN ('출근', '출장', '외근', '지각', '조퇴'), 1, 0),
        attendanceCount = attendanceCount + IF(NEW.status = '출근', 1, 0),
        businesstripCount = businesstripCount + IF(NEW.status = '출장', 1, 0),
        outsideWorkCount = outsideWorkCount + IF(NEW.status = '외근', 1, 0),
        Vacation = Vacation + IF(NEW.status IN ('월차', '반차'), leaveAmount, 0),
        monthlyLeave = monthlyLeave + IF(NEW.status = '월차', 1, 0),
        halfDayLeave = halfDayLeave + IF(NEW.status = '반차', 1, 0),
        lateness = lateness + IF(NEW.status = '지각', 1, 0),
        earlyLeave = earlyLeave + IF(NEW.status = '조퇴', 1, 0),
        absence = absence + IF(NEW.status = '결근', 1, 0)
    WHERE employeeCode = NEW.employeeCode;
END;
//

DELIMITER ;

-- 공지사항(announcement) 테이블 작성
drop table if exists announcement;

CREATE TABLE announcement (
    noticeid INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    category ENUM('업무', '인사','이벤트'),
    authorid VARCHAR(20) NOT NULL,
    publishdate DATETIME NOT NULL,
    img LONGBLOB,
    PRIMARY KEY (noticeid),
    FOREIGN KEY (authorid) REFERENCES HRInformation (employeeCode)
);

-- admin만 작성,삭제,수정등의 권한 제약조건 (제약조건 생성할때 다른테이블을 참조할수없어서 트리거로 변경)
DELIMITER //
CREATE TRIGGER chk_author_id BEFORE INSERT ON announcement
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM HRInformation WHERE employeeCode = NEW.authorid AND authority = 'admin') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '관리자만 작성할 수 있습니다.';
    END IF;
END;
//
DELIMITER ;

drop trigger if exists after_attendance_insert;
drop trigger if exists after_attendance_update;

DELIMITER //

CREATE TRIGGER after_attendance_insert
AFTER INSERT ON attendance
FOR EACH ROW
BEGIN
    DECLARE total_work_count INT DEFAULT 0;
    DECLARE attendance_count INT DEFAULT 0;
    DECLARE businesstrip_count INT DEFAULT 0;
    DECLARE outsidework_count INT DEFAULT 0;
    DECLARE vacation_count DOUBLE DEFAULT 0.0;
    DECLARE monthly_leave_count INT DEFAULT 0;
    DECLARE half_day_leave_count INT DEFAULT 0;
    DECLARE lateness_count INT DEFAULT 0;
    DECLARE early_leave_count INT DEFAULT 0;
    DECLARE absence_count INT DEFAULT 0;

    -- attendance 테이블에서 각 상태의 개수를 계산
    SELECT 
        SUM(CASE WHEN status = '출근' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '출장' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '외근' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '월차' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '반차' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '지각' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '조퇴' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '결근' THEN 1 ELSE 0 END)
    INTO
        attendance_count,
        businesstrip_count,
        outsidework_count,
        monthly_leave_count,
        half_day_leave_count,
        lateness_count,
        early_leave_count,
        absence_count
    FROM attendance
    WHERE employeeCode = NEW.employeeCode;

    SET total_work_count =  attendance_count + businesstrip_count + outsidework_count +early_leave_count +lateness_count;
    SET vacation_count = monthly_leave_count + half_day_leave_count/2;

    -- totalattendance 테이블 업데이트
    UPDATE totalattendance
    SET
        totalWorkCount = total_work_count,
        attendanceCount = attendance_count,
        businesstripCount = businesstrip_count,
        outsideWorkCount = outsidework_count,
        vacation = vacation_count,
        monthlyLeave = monthly_leave_count,
        halfDayLeave = half_day_leave_count,
        lateness = lateness_count,
        earlyLeave = early_leave_count,
        absence = absence_count
    WHERE employeeCode = NEW.employeeCode;
END;
//


CREATE TRIGGER after_attendance_update
AFTER UPDATE ON attendance
FOR EACH ROW
BEGIN
    DECLARE total_work_count INT DEFAULT 0;
    DECLARE attendance_count INT DEFAULT 0;
    DECLARE businesstrip_count INT DEFAULT 0;
    DECLARE outsidework_count INT DEFAULT 0;
    DECLARE vacation_count DOUBLE DEFAULT 0.0;
    DECLARE monthly_leave_count INT DEFAULT 0;
    DECLARE half_day_leave_count INT DEFAULT 0;
    DECLARE lateness_count INT DEFAULT 0;
    DECLARE early_leave_count INT DEFAULT 0;
    DECLARE absence_count INT DEFAULT 0;

    -- attendance 테이블에서 각 상태의 개수를 계산
    SELECT 
        SUM(CASE WHEN status = '출근' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '출장' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '외근' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '월차' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '반차' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '지각' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '조퇴' THEN 1 ELSE 0 END),
        SUM(CASE WHEN status = '결근' THEN 1 ELSE 0 END)
    INTO
        attendance_count,
        businesstrip_count,
        outsidework_count,
        monthly_leave_count,
        half_day_leave_count,
        lateness_count,
        early_leave_count,
        absence_count
    FROM attendance
    WHERE employeeCode = NEW.employeeCode;

    SET total_work_count = attendance_count + businesstrip_count + outsidework_count +early_leave_count +lateness_count ;
    SET vacation_count = monthly_leave_count + half_day_leave_count/2;

    -- totalattendance 테이블 업데이트
    UPDATE totalattendance
    SET
        totalWorkCount = total_work_count,
        attendanceCount = attendance_count,
        businesstripCount = businesstrip_count,
        outsideWorkCount = outsidework_count,
        vacation = vacation_count,
        monthlyLeave = monthly_leave_count,
        halfDayLeave = half_day_leave_count,
        lateness = lateness_count,
        earlyLeave = early_leave_count,
        absence = absence_count
    WHERE employeeCode = NEW.employeeCode;
END;
//

DELIMITER ;


select * from attendance;
select * from hrinformation;
select * from totalattendance;
select * from announcement;