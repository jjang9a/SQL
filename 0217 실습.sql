--�������� ����

CREATE SEQUENCE dept_deptid_seq
                            INCREMENT BY 10
                            START WITH 200
                            MAXVALUE 9999
                            NOCACHE
                            NOCYCLE;
                            
--���ʿ� �ѹ��϶� currval ��� �����Ͱ� ����, ������ �ѹ� nextval�� �ڿ� ���� �����Ѵ�.
--currvla �����Ͱ� ����� �ȴ�.
--������ 200
INSERT INTO departments(department_id, department_name, location_id)
VALUES(dept_deptid_seq.nextval, 'Support', 2500);
SELECT * FROM departments;

ROLLBACK;
--������ 210
INSERT INTO departments(department_id, department_name, location_id)
VALUES(dept_deptid_seq.nextval, 'Support', 2500);

SELECT * FROM departments;


--�Խ��� �� �ѹ� �Է�
--1) ������ Ȱ���ؼ� �Խ��� �� ��ȣ �Է�
-- ���������� �� ��ȣ �Է��� ������
-- ������ : ��� �Խñ��� �������ٸ� 123 67 9 10 -> 1234567 11
-- ����
--2) INSERT -> �׷� �Լ��� Ȱ���ؼ� �Է�
-- �׷��Լ��� ����ϰ� �Ǹ�, �˾Ƽ� ��ȣ�� ���� �Խ��� ��ȣ ����

--������ ����
ALTER SEQUENCE dept_deptid_seq
                        INCREMENT BY 20
                        MAXVALUE 999999
                        NOCACHE
                        NOCYCLE;
                        
INSERT INTO departments(department_id, department_name, location_id)
VALUES(dept_deptid_seq.nextval, 'Support', 2500);

 SELECT * FROM departments;                  
 
 SELECT dept_deptid_seq.nextval
 FROM dual;
 
 ROLLBACK;
 
 SELECT sequence_name, min_value, max_value, increment_by, last_number
 FROM user_sequences;
 
 
 --���Ǿ�
SELECT * FROM dept_sum_vu;

CREATE SYNONYM d_sum
FOR dept_sum_vu;

SELECT * FROM d_sum;

--���Ǿ� ���� ������ ��ųʸ� ����
SELECT synonym_name, table_owner, table_name
FROM user_synonyms;
--���Ǿ� ����
DROP SYNONYM d_sum;
--�ǽ� ����
DROP TABLE emp;
DROP TABLE basket;
DROP TABLE iusers;
DROP TABLE products;
DROP TABLE market;



--�߰� �Լ�

--ROWNUM
--COLUMN�� ���� �ű� �� ���
SELECT ROWNUM, employee_id, salary, hire_date, department_id
FROM employees;

--WITH�� : ������ SQL�� ������ ���� �ݺ������� ���� �� ���
WITH example AS
(
        SELECT 'example' FROM DUAL
        UNION ALL
        SELECT 'example3' FROM DUAL
),
example2 AS
(
        SELECT 'example2' FROM DUAL
        UNION ALL
        SELECT * FROM example
)
SELECT *
FROM example2;

--RANK OVER()
--�⺻��
SELECT RANK() OVER(ORDER BY salary) AS �޿���, last_name
FROM employees;

SELECT RANK() OVER(ORDER BY hire_date) AS �Ի��, last_name
FROM employees;


-- DENSE_RANK() OVER
SELECT DENSE_RANK() OVER(ORDER BY salary) AS �޿���, last_name, salary
FROM employees;

--ROW_NUMBER() OVER
SELECT ROW_NUMBER() OVER(ORDER BY salary) AS �޿���, last_name, salary
FROM employees;

--RANK OVER() -> �׷� �Լ� ������ RANK OVER
--PARTITION BY �ϸ� �μ����� �޿��� ��ŷ�� �Űܴ޶�� �ǹ�
SELECT RANK() OVER(PARTITION BY department_id ORDER BY salary) AS �޿���, last_name, salary, department_id
FROM employees;

--������ ���
--UNDOTBS -> ������ ����
--drop table employees -> �ڵ� Ŀ�� ����
-- ����� ������ �ƴ϶� ���������� �̵��� ��
CREATE TABLE temp(
id NUMBER(1));

DROP TABLE temp;

SELECT *
FROM user_recyclebin
WHERE original_name = 'TEMP';

PURGE recyclebin;

SELECT *
FROM user_recyclebin
WHERE original_name = 'TEMP';

FLASHBACK table "BIN$BVOxXnC8S5a+dcqR9xtVtw==$0" to before drop;

SELECT * FROM temp;

show recyclebin;

--TABLE ���� ����
DROP TABLE temp PURGE;

show recyclebin;

SELECT * FROM temp;