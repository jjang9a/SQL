--View
--(���� �ְ� ���� ������)
--���� : �����ϴ� ����� ���� ������ ������ ���̸� �� �� �ִ�.
--          ������ ������ ���� ����.

--������ ������ ���� ������ ���� ���� �� �Ʒ� �� ����
--hr ������ view ���� ���� �ο�
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


--��� ����� ���̺� ��

SELECT * FROM employees;

UPDATE employees
SET salary = salary * 1.1;

SELECT *
FROM empvu80;

SELECT *
FROM salvu80;

ROLLBACK;

--�� ���� ������ ��ųʸ� ���� Ȯ��
SELECT view_name, text
FROM user_views;

--�� �����ϱ�
CREATE OR REPLACE VIEW salvu50
AS
    SELECT employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY, hire_date
    FROM employees
    WHERE department_id = 80;

SELECT *
FROM salvu50;

--SIMPLE VIEW,, COMPLEX VIEW
-- SIMPLE VIEW - �ϳ��� ���̺�� ����� VIEW
-- COMPLEX VIEW - �ϳ� �̻��� ���̺�� ����� VIEW(JOIN)

CREATE OR REPLACE VIEW dept_sum_vu (name, minsal, maxsal, avgsal)
AS
    SELECT d.department_name, MIN(e.salary), MAX(e.salary), TRUNC(AVG(e.salary))
    FROM employees e JOIN departments d
    ON (e.department_id = d.department_id)
    GROUP BY d.department_name;

SELECT * FROM dept_sum_vu;

--WITH CHECK OPTION ���
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
    
--���� ���� �����͸� ���� ������ ������ ������ -> �ȵ�
SELECT * FROM empvu80;
UPDATE empvu80
SET department_id = 60
WHERE employee_id = 176;
--���� ���� �����͸� ���� ������ ������ ������ -> ��
UPDATE empvu80
SET salary =9800
WHERE employee_id=176;

CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80;
    WITH READ ONLY;
    
--�� ����

SELECT view_name, text
FROM user_views;

DROP VIEW empvu80;

SELECT *
FROM empvu80;


--�ڵ� INDEX
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

--���� INDEX ����
CREATE INDEX emp_ename_idx ON emp(ename);

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

--�ε��� ����
--�ڵ� �ε��� ���� : �ȵ�
DROP INDEX SYS_C007146;
--���� �ε��� ���� : ��
DROP INDEX emp_ename_idx;