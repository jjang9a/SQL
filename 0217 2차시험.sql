--1) �����ȣ, �̸�, �μ���ȣ, �μ��̸��� ǥ���Ͻÿ� (�μ��� �������� ���� ����� �Բ�)
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

--2) �μ���ȣ, �μ��̸�, ���ø��� ����Ͻÿ�
SELECT d.department_id, d.department_name, l.city
FROM departments d NATURAL JOIN locations l;

--3) �������� �̿�. IT�μ����� �ٹ��ϴ� ������� �����ȣ, �̸�, ����
SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id = (
                                    SELECT department_id
                                    FROM departments
                                    WHERE department_name = 'IT'
                                    );

--4) PROP���̺� ����
CREATE TABLE PROF(
profno NUMBER(4) PRIMARY KEY,
name VARCHAR2(15) CONSTRAINT prof_name_nn NOT NULL
                               CONSTRAINT prof_name_uk UNIQUE,
id VARCHAR(15) NOT NULL,
hiredate DATE,
pay NUMBER(4),
deptno NUMBER(4)
--deptno NUMBER(4) CONSTRAINT prof_deptno_fk FOREIGN KEY (deptno) REFERENCES departments(department_id)
);
DROP TABLE
--5) PROF ���̺��� deptno���� department_id���� �����ϴ� �ܷ�Ű�� �����Ͻÿ� / prof_deptno_fk
ALTER TABLE PROF
MODIFY (deptno NUMBER(4)
CONSTRAINT prof_deptno_fk FOREIGN KEY (null) REFERENCES departments(department_id));

--6) �̸�, ����, ���� �� �������ǿ� ���� ������ ��� ������ ��ųʸ����� ��ȸ�Ͻÿ�
SELECT *
FROM user_constraints
WHERE table_name = 'PROF';

--7) ������ �Է�
--(1)
INSERT INTO prof
VALUES (1001,'������','c1001','17/03/01',800,10);
INSERT INTO prof
VALUES (1002,'������','k1002','20/11/28',750,20);
INSERT INTO prof
VALUES (1003,'�մ��','s1003','21/03/02', null, null);
COMMIT;

--(2)
UPDATE prof
SET pay = 1100
WHERE profno = 1001;

--(3)
COMMIT;

--8) �ε��� ����
--(1)
CREATE INDEX PROF_ID_IX ON PROF(id);

--(2) ������ ��ųʸ����� �ε��� ��ȸ
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'PROF';

--(3) PROF ���� �ε����� �� ��?
3��

--9)
--(1) �� �߰�
ALTER TABLE PROF
ADD (gender CHAR(3));

--(2) �� ����
ALTER TABLE PROF
MODIFY (name VARCHAR(20));

--10) ��ü���� �䱸����
--(1) �� ����
CREATE VIEW PROF_LIST_VU
AS
    SELECT profno ������ȣ, name �����̸�, id
    FROM PROF;
    
--(2) ���Ǿ� ����
CREATE SYNONYM P_VU
FOR PROF_LIST_VU;

--(3) ������ ����
CREATE SEQUENCE prof_no_seq
                            INCREMENT BY 1
                            START WITH 1005
                            NOCACHE
                            NOCYCLE;
                            
--11)
--(1)�� ����
CREATE OR REPLACE VIEW PROF_LIST_VU
AS
    SELECT profno ������ȣ, name �����̸�, id, hiredate
    FROM PROF;

--(2)������ ����
ALTER SEQUENCE prof_no_seq
                            INCREMENT BY 2
                            NOCACHE
                            NOCYCLE;
                            
--12)


--13)
--(1) ���̺� ���� ����
DROP TABLE PROF PURGE;

--(2)���� �ε���, ��, ���Ǿ� ��ȸ
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'PROF';

SELECT * FROM PROF_LIST_VU;

SELECT * FROM P_VU;

�������� ����