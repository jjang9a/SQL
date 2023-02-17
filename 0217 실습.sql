--시퀀스의 생성

CREATE SEQUENCE dept_deptid_seq
                            INCREMENT BY 10
                            START WITH 200
                            MAXVALUE 9999
                            NOCACHE
                            NOCYCLE;
                            
--최초에 한번일때 currval 경우 데이터가 없고, 무조건 한번 nextval한 뒤에 값이 존재한다.
--currvla 데이터가 출력이 된다.
--시퀀스 200
INSERT INTO departments(department_id, department_name, location_id)
VALUES(dept_deptid_seq.nextval, 'Support', 2500);
SELECT * FROM departments;

ROLLBACK;
--시퀀스 210
INSERT INTO departments(department_id, department_name, location_id)
VALUES(dept_deptid_seq.nextval, 'Support', 2500);

SELECT * FROM departments;


--게시판 글 넘버 입력
--1) 시퀀스 활용해서 게시판 글 번호 입력
-- 순차적으로 글 번호 입력은 가능함
-- 문제점 : 가운데 게시글이 지워진다면 123 67 9 10 -> 1234567 11
-- 편함
--2) INSERT -> 그룹 함수를 활용해서 입력
-- 그룹함수를 사용하게 되면, 알아서 번호를 만들어서 게시판 번호 생성

--시퀀스 수정
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
 
 
 --동의어
SELECT * FROM dept_sum_vu;

CREATE SYNONYM d_sum
FOR dept_sum_vu;

SELECT * FROM d_sum;

--동의어 관련 데이터 딕셔너리 보기
SELECT synonym_name, table_owner, table_name
FROM user_synonyms;
--동의어 삭제
DROP SYNONYM d_sum;
--실습 정리
DROP TABLE emp;
DROP TABLE basket;
DROP TABLE iusers;
DROP TABLE products;
DROP TABLE market;



--추가 함수

--ROWNUM
--COLUMN에 순서 매길 때 사용
SELECT ROWNUM, employee_id, salary, hire_date, department_id
FROM employees;

--WITH절 : 복잡한 SQL이 동일한 블럭에 반복적으로 나올 때 사용
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
--기본형
SELECT RANK() OVER(ORDER BY salary) AS 급여순, last_name
FROM employees;

SELECT RANK() OVER(ORDER BY hire_date) AS 입사순, last_name
FROM employees;


-- DENSE_RANK() OVER
SELECT DENSE_RANK() OVER(ORDER BY salary) AS 급여순, last_name, salary
FROM employees;

--ROW_NUMBER() OVER
SELECT ROW_NUMBER() OVER(ORDER BY salary) AS 급여순, last_name, salary
FROM employees;

--RANK OVER() -> 그룹 함수 내에서 RANK OVER
--PARTITION BY 하면 부서별로 급여순 랭킹을 매겨달라는 의미
SELECT RANK() OVER(PARTITION BY department_id ORDER BY salary) AS 급여순, last_name, salary, department_id
FROM employees;

--휴지통 기능
--UNDOTBS -> 데이터 삭제
--drop table employees -> 자동 커밋 삭제
-- 사실은 삭제가 아니라 휴지통으로 이동한 것
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

--TABLE 영구 삭제
DROP TABLE temp PURGE;

show recyclebin;

SELECT * FROM temp;