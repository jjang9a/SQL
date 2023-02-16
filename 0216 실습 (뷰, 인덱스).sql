--View
--(보여 주고 싶은 데이터)
--장점 : 접속하는 사람에 따라 데이터 접근의 차이를 둘 수 있다.
--          복잡한 쿼리를 쉽게 쓴다.

--관리자 계정에 가서 다음과 같은 진행 후 아래 뷰 생성
--hr 계정에 view 생성 권한 부여
--GRANT create view to hr;

CREATE VIEW empvu80
AS
    SELECT employee_id, last_name, salary
    FROM employees
    WHERE department_id = 80;

SELECT * FROM empvu80;

CREATE VIEW salvu80
AS
    SELECT employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY
    FROM employees
    WHERE department_id = 50;
    
SELECT * FROM salvu80;

DESC empvu80;
DESC salvu80;


--뷰와 복사된 테이블 비교

SELECT * FROM employees;

UPDATE employees
SET salary = salary * 1.1;

SELECT *
FROM empvu80;

SELECT *
FROM salvu80;

ROLLBACK;

--뷰 관련 데이터 딕셔너리 정보 확인
SELECT view_name, text
FROM user_views;

--뷰 수정하기
CREATE OR REPLACE VIEW salvu50
AS
    SELECT employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY, hire_date
    FROM employees
    WHERE department_id = 80;

SELECT *
FROM salvu50;

--SIMPLE VIEW,, COMPLEX VIEW
-- SIMPLE VIEW - 하나의 테이블로 만드는 VIEW
-- COMPLEX VIEW - 하나 이상의 테이블로 만드는 VIEW(JOIN)

CREATE OR REPLACE VIEW dept_sum_vu (name, minsal, maxsal, avgsal)
AS
    SELECT d.department_name, MIN(e.salary), MAX(e.salary), TRUNC(AVG(e.salary))
    FROM employees e JOIN departments d
    ON (e.department_id = d.department_id)
    GROUP BY d.department_name;

SELECT * FROM dept_sum_vu;

--WITH CHECK OPTION 사용
CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80;
    
SELECT * FROM empvu80;

UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;

SELECT * FROM empvu80;
SELECT employee_id, salary
FROM employees
WHERE employee_id = 176;
ROLLBACK;

CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80;
    WITH CHECK OPTION;
    
--범위 안의 데이터를 범위 밖으로 보내는 쿼리문 -> 안됨
SELECT * FROM empvu80;
UPDATE empvu80
SET department_id = 60
WHERE employee_id = 176;
--범위 안의 데이터를 범위 안으로 보내는 쿼리문 -> 됨
UPDATE empvu80
SET salary =9800
WHERE employee_id=176;

CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80;
    WITH READ ONLY;
    
--뷰 삭제

SELECT view_name, text
FROM user_views;

DROP VIEW empvu80;

SELECT *
FROM empvu80;


--자동 INDEX
DROP TABLE emp;

CREATE TABLE emp(
empno NUMBER(6) PRIMARY KEY,
ename VARCHAR(25) NOT NULL,
email VARCHAR2(50) NOT NULL UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8),
deptno NUMBER(4) );

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc
ON (c.constraint_name = cc.constraint_name)
WHERE c.table_name = 'EMP';

--수동 INDEX 생성
CREATE INDEX emp_ename_idx ON emp(ename);

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

--인덱스 삭제
--자동 인덱스 삭제 : 안됨
DROP INDEX SYS_C007146;
--수동 인덱스 삭제 : 됨
DROP INDEX emp_ename_idx;