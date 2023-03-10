CREATE TABLE emp(
emp_id number,
emp_name varchar2(10),
mgr number,
sal number,
dept_id number,
hire_date date);

DROP TABLE emp;

--1) Insert문의 2가지 형태
-- Insert column 쓰지 않을 경우 : 테이블의 모든 column에 데이터 기입
INSERT INTO emp VALUES (1, '김또치', 100, 24000, 10);

--Insert column 쓴 경우 : 내가 입력한 column에 대해서만 데이터 기입
INSERT INTO emp (emp_id, emp_name, sal)
VALUES(2, '고희동', 3000);

select *
from emp;

--Insert 할 때 Null값 입력하는 방법
DESC emp;
INSERT INTO emp VALUES (1, '김또치', 100, 24000, 10, null);

INSERT INTO emp VALUES (2, '고희동', 100, 24000, 10, sysdate);

--PL/SQL

--DELETE
--WHERE절을 활용하여 선택된 데이터(ROW)만 삭제
DELETE FROM emp
WHERE emp_id = 2;

--WHERE절 쓰지 않고 테이블에 있는 데이터 전부 삭제
DELETE FROM emp;
--WHERE절의 서브쿼리르 활용해서 데이터를 삭제하는 방법
DELETE FROM emp
WHERE emp_id = (
                            --지워야 할 데이터의 내용 -> SELECT문 활용
                            );

--UPDATE문
--UPDATE문에서 WHERE절 활용 하였을 때
UPDATE emp
SET emp_name = '도우너'
WHERE emp_id = 1;

--UPDATE문에서 WHERE절 활용 안 했을 때
UPDATE emp
SET emp_id = 1000;

--UPDATE문 깜짝 퀴즈
--emp테이블에서 dept_id를 모두 11로 바꾸는데, dept = 11 말고 다른 방법으로 update해보기
UPDATE emp
SET dept_id = dept_id + 1;


--게시판 번호 설정
--게시판 삭제한 내용을 기준으로 번호 재 정렬
--게시판 데이터 입력할 때 값을 부여하는것이 아니라 앞에서 배운 내용을 토대로 게시판 번호를 "생성"해서 데이터 입력 할 것
CREATE TABLE board (
board_no number,
board_content varchar2(200)
);

INSERT INTO board VALUES (1, '1번 게시판');
INSERT INTO board VALUES (2, '2번 게시판');
INSERT INTO board VALUES (3, '3번 게시판');
INSERT INTO board VALUES (4, '4번 게시판');
INSERT INTO board VALUES (5, '5번 게시판');
INSERT INTO board VALUES (6, '6번 게시판');
INSERT INTO board VALUES (7, '7번 게시판');

SELECT *
FROM board;

DELETE FROM board
WHERE board_no = 4;

UPDATE board
SET board_no = board_no -1
WHERE board_no > 4;

INSERT INTO board (board_no)
VALUES (
                (SELECT MAX(board_no)
                FROM board)+1);
             
INSERT INTO board VALUES (
                                          (SELECT COUNT(*) +1
                                            FROM board ),
                                            (SELECT COUNT(*) +1
                                            FROM board )
                                            || '번 게시판' );
                                            
SELECT *
FROM board
ORDER BY 1;

COMMIT;

--INTSERT 문장을 통한 Transaction

INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);

SELECT *
FROM departments;

ROLLBACK;

SELECT *
FROM departments;

COMMIT;

--다른 테이블로 ROW 복사
CREATE TABLE sales_reps
AS
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees;

SELECT *
FROM sales_reps;

--INSERT문 => 치환변수 사용
INSERT INTO departments (department_id, department_name, location_id)
VALUES (&department_id, '&department_name', &location);

SELECT *
FROM departments;

--UPDATE문을 활용한 Transaction
UPDATE employees
SET salary = 7000;

SELECT *
FROM employees;

ROLLBACK;

UPDATE employees
SET salary = 7000
WHERE employee_id = 104;

--Transaction 종료
ROLLBACK;

UPDATE employees
SET salary = salary*1.1
WHERE employee_id = 104;

ROLLBACK;

SELECT *
FROM employees;

--서브쿼리를 이용한 UPDATE
UPDATE employees
SET job_id = (
                    SELECT job_id
                    FROM employees
                    WHERE employee_id = 205),
    salary = (
                SELECT salary
                FROM employees
                WHERE employee_id = 205)
WHERE employee_id = 124;

UPDATE employees
SET department_id = (
                                SELECT department_id
                                FROM departments
                                WHERE department_name LIKE '%Public%')
WHERE employee_id = 206;

SELECT * FROM employees;
SELECT * FROM departments;

ROLLBACK;

DELETE FROM employees
WHERE department_id = (
                                    SELECT department_id
                                    FROM departments
                                    WHERE department_name LIKE '%Public%');
                                    
ROLLBACK;

--TABLE DELETE & TRUNCATE - 테이블 데이터 삭제

--TABLE에서 DELETE => 데이터만 삭제
DELETE FROM sales_reps;
ROLLBACK;

--TABLE에서 TRUNCATE => 데이터와 데이터를 보관하는 공간까지 삭제
TRUNCATE TABLE sales_reps;
ROLLBACK;

INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROm employees
WHERE job_id LIKE '%RE%';

SELECT * FROM sales_reps;
COMMIT;

DELETE FROM sales_reps
WHERE id = 174;

SAVEPOINT spl;

DELETE FROM sales_reps
WHERE id = 202;

ROLLBACK to spl;

ROLLBACK;

SELECT table_name
FROM user_tables;

SELECT DISTINCT *
FROM user_objects;

SELECT *
FROM user_catalog;

--table 생성
CREATE TABLE dept (
dept_no number(2),
dname varchar2(14),
loc varchar2(13),
create_date DATE DEFAULT sysdate);

DESC dept;

INSERT INTO dept(dept_no, dname, loc)
VALUES (1,'또치', '예담');

SELECT *
FROM dept;

CREATE TABLE dept30
AS
    SELECT employee_id, last_name, salary*12 AS "salary", hire_date
    FROM employees
    WHERE department_id = 50;
    
SELECT * FROM dept30;

DESC employees;

DROP TABLE dept30;
DROP TABLE dept;


--Column 추가
ALTER TABLE dept30
ADD             (job VARCHAR2(20));

DESC dept30;

ALTER TABLE dept30
MODIFY          (job NUMBER);

INSERT INTO dept30
VALUES (1, '또치', 2000, SYSDATE, 123);

ALTER TABLE dept30
MODIFY          (job VARCHAR2(40));

DELETE FROM dept30
WHERE employee_id = 1;

ALTER TABLE dept30
DROP COLUMN job;

DESC dept30;

ALTER TABLE dept30
SET UNUSED (hire_date);

SELECT *
FROM dept30;

ALTER TABLE dept30
DROP UNUSED COLUMNS;

--RENAME
RENAME dept30 to dept100;

SELECT *
FROM dept30;

SELECT *
FROM dept100;

COMMENT ON TABLE dept100
IS 'THIS IS DEPT100';

SELECT *
FROM user_col_comments
WHERE table_name = 'DEPT100';

COMMENT ON COLUMN dept100.employee_id
IS  'THIS IS EMPLOYEE_ID';

SELECT * FROM dept100;

TRUNCATE TABLE dept100;

SELECT * FROM dept100;
ROLLBACK;

SELECT * FROM dept100;

DROP  TABLE dept100;


--기본키(PK) 기본값 열을 포함하는 테이블 생성
DROP TABLE board;

CREATE TABLE dept(
                            deptno NUMBER(2) PRIMARY KEY,
                            dname VARCHAR(14),
                            loc VARCHAR(13),
                            create_date DATE DEFAULT sysdate --기본값을 가지는 열(Column)
                            );

INSERT INTO dept(deptno, dname)
VALUES (10,'기획부'); --기본값을 가지는 열(Column)에 데이터가 자동 입력

INSERT INTO dept
VALUES (20, '영업부', '서울', '23/02/15');

COMMIT;

SELECT *
FROM dept;

--여러가지 제약조건을 포함하는 테이블 생성
DROP TABLE emp;

CREATE TABLE emp(
empno NUMBER(6) PRIMARY KEY, --기본키 제약조건
ename VARCHAR2(25) NOT NULL, --NOT NULL 제약조건
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL --NOT NULL 제약조건 + 제약조건 이름 부여
                            CONSTRAINT emp_mail_uk UNIQUE, --UNIQUE 제약조건 + 제약조건 이름 부여
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(SALARY>2000), --CHECK 제약조건, 2000보다 큰 데이터가 들어와야 입력 가능
deptno NUMBER(4) REFERENCES dept(deptno)); --FOREIGN KEY 제약 조건, dept table에서 deptno라는 Column을 참조해서 데이터 입력.


CREATE TABLE emp(
--COLUMN LEVEL CONSTRAINT
empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) CONSTRAINT emp_ename_nn NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_email_nn NOT NULL,
phone_no CHAR(11),
job VARCHAR2(20),
salary NUMBER(8),
deptno NUMBER(4),
--TABLE LEVEL CONSTRAINT
CONSTRAINT emp_empno_pk PRIMARY KEY(empno),
CONSTRAINT emp_email_uk UNIQUE(email),
CONSTRAINT emp_salary_ck CHECK(salary>2000),
CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno)
REFERENCES dept(deptno)
);

--제야조건 관련 딕셔너리 정보 보기
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';

SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc
ON (c.constraint_name = cc.constraint_name)
WHERE c.table_name = 'EMP';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN('DEPT', 'EMP');


--DML을 수행하며 제약조건 테스트 하기
INSERT INTO emp
VALUES(null, '또치', 'ddoChiKim@naver.com', '01023456789', '회사원', 3500, null);

INSERT INTO emp
VALUES(1234, '또치', 'ddoChiKim@naver.com', '01023456789', '회사원', 3500, null);

INSERT INTO emp
VALUES(1233, '희동', 'heeedong@naver.com', '01054359876', null, 7800, 20);

COMMIT;

SELECT *
FROM emp;

--UPDATE
UPDATE emp
SET deptno = 10
WHERE empno = 1234;

COMMIT;

SELECT *
FROM emp;

ALTER TABLE emp
ADD CONSTRAINT emp_job_uk UNIQUE(job);

INSERT INTO emp
VALUES(1200, '길동', 'gildong@naver.com', '01054359876', '회사원', 5000, 20);

ALTER TABLE emp
MODIFY (salary number NOT NULL);

INSERT INTO emp
VALUES(1200, '길동', 'gildong@naver.com', '01054359876', '회사원', null, 20);

ALTER TABLE emp
DROP CONSTRAINT emp_job_uk;

INSERT INTO emp
VALUES(1200, '길동', 'gildong@naver.com', '01054359876', '회사원', 5400, 20);