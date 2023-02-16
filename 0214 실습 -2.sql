CREATE TABLE emp(
emp_id number,
emp_name varchar2(10),
mgr number,
sal number,
dept_id number,
hire_date date);

DROP TABLE emp;

--1) Insert���� 2���� ����
-- Insert column ���� ���� ��� : ���̺��� ��� column�� ������ ����
INSERT INTO emp VALUES (1, '���ġ', 100, 24000, 10);

--Insert column �� ��� : ���� �Է��� column�� ���ؼ��� ������ ����
INSERT INTO emp (emp_id, emp_name, sal)
VALUES(2, '����', 3000);

select *
from emp;

--Insert �� �� Null�� �Է��ϴ� ���
DESC emp;
INSERT INTO emp VALUES (1, '���ġ', 100, 24000, 10, null);

INSERT INTO emp VALUES (2, '����', 100, 24000, 10, sysdate);

--PL/SQL

--DELETE
--WHERE���� Ȱ���Ͽ� ���õ� ������(ROW)�� ����
DELETE FROM emp
WHERE emp_id = 2;

--WHERE�� ���� �ʰ� ���̺� �ִ� ������ ���� ����
DELETE FROM emp;
--WHERE���� ���������� Ȱ���ؼ� �����͸� �����ϴ� ���
DELETE FROM emp
WHERE emp_id = (
                            --������ �� �������� ���� -> SELECT�� Ȱ��
                            );

--UPDATE��
--UPDATE������ WHERE�� Ȱ�� �Ͽ��� ��
UPDATE emp
SET emp_name = '�����'
WHERE emp_id = 1;

--UPDATE������ WHERE�� Ȱ�� �� ���� ��
UPDATE emp
SET emp_id = 1000;

--UPDATE�� ��¦ ����
--emp���̺��� dept_id�� ��� 11�� �ٲٴµ�, dept = 11 ���� �ٸ� ������� update�غ���
UPDATE emp
SET dept_id = dept_id + 1;


--�Խ��� ��ȣ ����
--�Խ��� ������ ������ �������� ��ȣ �� ����
--�Խ��� ������ �Է��� �� ���� �ο��ϴ°��� �ƴ϶� �տ��� ��� ������ ���� �Խ��� ��ȣ�� "����"�ؼ� ������ �Է� �� ��
CREATE TABLE board (
board_no number,
board_content varchar2(200)
);

INSERT INTO board VALUES (1, '1�� �Խ���');
INSERT INTO board VALUES (2, '2�� �Խ���');
INSERT INTO board VALUES (3, '3�� �Խ���');
INSERT INTO board VALUES (4, '4�� �Խ���');
INSERT INTO board VALUES (5, '5�� �Խ���');
INSERT INTO board VALUES (6, '6�� �Խ���');
INSERT INTO board VALUES (7, '7�� �Խ���');

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
                                            || '�� �Խ���' );
                                            
SELECT *
FROM board
ORDER BY 1;

COMMIT;

--INTSERT ������ ���� Transaction

INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);

SELECT *
FROM departments;

ROLLBACK;

SELECT *
FROM departments;

COMMIT;

--�ٸ� ���̺�� ROW ����
CREATE TABLE sales_reps
AS
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees;

SELECT *
FROM sales_reps;

--INSERT�� => ġȯ���� ���
INSERT INTO departments (department_id, department_name, location_id)
VALUES (&department_id, '&department_name', &location);

SELECT *
FROM departments;

--UPDATE���� Ȱ���� Transaction
UPDATE employees
SET salary = 7000;

SELECT *
FROM employees;

ROLLBACK;

UPDATE employees
SET salary = 7000
WHERE employee_id = 104;

--Transaction ����
ROLLBACK;

UPDATE employees
SET salary = salary*1.1
WHERE employee_id = 104;

ROLLBACK;

SELECT *
FROM employees;

--���������� �̿��� UPDATE
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

--TABLE DELETE & TRUNCATE - ���̺� ������ ����

--TABLE���� DELETE => �����͸� ����
DELETE FROM sales_reps;
ROLLBACK;

--TABLE���� TRUNCATE => �����Ϳ� �����͸� �����ϴ� �������� ����
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

--table ����
CREATE TABLE dept (
dept_no number(2),
dname varchar2(14),
loc varchar2(13),
create_date DATE DEFAULT sysdate);

DESC dept;

INSERT INTO dept(dept_no, dname, loc)
VALUES (1,'��ġ', '����');

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


--Column �߰�
ALTER TABLE dept30
ADD             (job VARCHAR2(20));

DESC dept30;

ALTER TABLE dept30
MODIFY          (job NUMBER);

INSERT INTO dept30
VALUES (1, '��ġ', 2000, SYSDATE, 123);

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


--�⺻Ű(PK) �⺻�� ���� �����ϴ� ���̺� ����
DROP TABLE board;

CREATE TABLE dept(
                            deptno NUMBER(2) PRIMARY KEY,
                            dname VARCHAR(14),
                            loc VARCHAR(13),
                            create_date DATE DEFAULT sysdate --�⺻���� ������ ��(Column)
                            );

INSERT INTO dept(deptno, dname)
VALUES (10,'��ȹ��'); --�⺻���� ������ ��(Column)�� �����Ͱ� �ڵ� �Է�

INSERT INTO dept
VALUES (20, '������', '����', '23/02/15');

COMMIT;

SELECT *
FROM dept;

--�������� ���������� �����ϴ� ���̺� ����
DROP TABLE emp;

CREATE TABLE emp(
empno NUMBER(6) PRIMARY KEY, --�⺻Ű ��������
ename VARCHAR2(25) NOT NULL, --NOT NULL ��������
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL --NOT NULL �������� + �������� �̸� �ο�
                            CONSTRAINT emp_mail_uk UNIQUE, --UNIQUE �������� + �������� �̸� �ο�
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(SALARY>2000), --CHECK ��������, 2000���� ū �����Ͱ� ���;� �Է� ����
deptno NUMBER(4) REFERENCES dept(deptno)); --FOREIGN KEY ���� ����, dept table���� deptno��� Column�� �����ؼ� ������ �Է�.


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

--�������� ���� ��ųʸ� ���� ����
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


--DML�� �����ϸ� �������� �׽�Ʈ �ϱ�
INSERT INTO emp
VALUES(null, '��ġ', 'ddoChiKim@naver.com', '01023456789', 'ȸ���', 3500, null);

INSERT INTO emp
VALUES(1234, '��ġ', 'ddoChiKim@naver.com', '01023456789', 'ȸ���', 3500, null);

INSERT INTO emp
VALUES(1233, '��', 'heeedong@naver.com', '01054359876', null, 7800, 20);

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
VALUES(1200, '�浿', 'gildong@naver.com', '01054359876', 'ȸ���', 5000, 20);

ALTER TABLE emp
MODIFY (salary number NOT NULL);

INSERT INTO emp
VALUES(1200, '�浿', 'gildong@naver.com', '01054359876', 'ȸ���', null, 20);

ALTER TABLE emp
DROP CONSTRAINT emp_job_uk;

INSERT INTO emp
VALUES(1200, '�浿', 'gildong@naver.com', '01054359876', 'ȸ���', 5400, 20);