--1) 사원번호, 이름, 부서번호, 부서이름을 표시하시오 (부서가 정해지지 않은 사원도 함께)
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

--2) 부서번호, 부서이름, 도시명을 출력하시오
SELECT d.department_id, d.department_name, l.city
FROM departments d NATURAL JOIN locations l;

--3) 서브쿼리 이용. IT부서에서 근무하는 사원들의 사원번호, 이름, 업무
SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id = (
                                    SELECT department_id
                                    FROM departments
                                    WHERE department_name = 'IT'
                                    );

--4) PROP테이블 생성
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
--5) PROF 테이블의 deptno열에 department_id열을 참조하는 외래키를 생성하시오 / prof_deptno_fk
ALTER TABLE PROF
MODIFY (deptno NUMBER(4)
CONSTRAINT prof_deptno_fk FOREIGN KEY (null) REFERENCES departments(department_id));

--6) 이름, 유형, 상태 등 제약조건에 대한 정보를 모두 데이터 딕셔너리에서 조회하시오
SELECT *
FROM user_constraints
WHERE table_name = 'PROF';

--7) 데이터 입력
--(1)
INSERT INTO prof
VALUES (1001,'차은우','c1001','17/03/01',800,10);
INSERT INTO prof
VALUES (1002,'김제니','k1002','20/11/28',750,20);
INSERT INTO prof
VALUES (1003,'손담비','s1003','21/03/02', null, null);
COMMIT;

--(2)
UPDATE prof
SET pay = 1100
WHERE profno = 1001;

--(3)
COMMIT;

--8) 인덱스 생성
--(1)
CREATE INDEX PROF_ID_IX ON PROF(id);

--(2) 데이터 딕셔너리에서 인덱스 조회
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'PROF';

--(3) PROF 관련 인덱스는 몇 개?
3개

--9)
--(1) 열 추가
ALTER TABLE PROF
ADD (gender CHAR(3));

--(2) 열 수정
ALTER TABLE PROF
MODIFY (name VARCHAR(20));

--10) 객체생성 요구사항
--(1) 뷰 생성
CREATE VIEW PROF_LIST_VU
AS
    SELECT profno 교수번호, name 교수이름, id
    FROM PROF;
    
--(2) 동의어 생성
CREATE SYNONYM P_VU
FOR PROF_LIST_VU;

--(3) 시퀀스 생성
CREATE SEQUENCE prof_no_seq
                            INCREMENT BY 1
                            START WITH 1005
                            NOCACHE
                            NOCYCLE;
                            
--11)
--(1)뷰 수정
CREATE OR REPLACE VIEW PROF_LIST_VU
AS
    SELECT profno 교수번호, name 교수이름, id, hiredate
    FROM PROF;

--(2)시퀀스 수정
ALTER SEQUENCE prof_no_seq
                            INCREMENT BY 2
                            NOCACHE
                            NOCYCLE;
                            
--12)


--13)
--(1) 테이블 영구 삭제
DROP TABLE PROF PURGE;

--(2)관련 인덱스, 뷰, 동의어 조회
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'PROF';

SELECT * FROM PROF_LIST_VU;

SELECT * FROM P_VU;

존재하지 않음