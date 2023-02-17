DESC employees;

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT department_id, department_name
FROM departments;

SELECT manager_id, location_id
FROM departments;

--산술연산자
SELECT last_name, salary, salary+100
FROM employees;

SELECT last_name, salary, 12*salary+100
FROM employees;

SELECT last_name, salary, 12*(salary+100), 12*salary+100
FROM employees;

--널값과 산술연산
SELECT last_name, job_id, salary, commission_pct
FROM employees;

SELECT last_name, 12*salary*commission_pct, commission_pct
FROM employees;

SELECT commission_pct+100
FROM employees;

--Columm Alias(별칭)
SELECT last_name AS name, job_id JOB_ID, salary*12 "Annual_Sal"
FROM employees;

--연결 연산자(||)
SELECT first_name, last_name, first_name || ' ' ||last_name As full_name
FROM employees;

SELECT employee_id || '-' || last_name || '''s Salary : ' || salary
FROM employees;

--Q연산자로 가독성 증대
SELECT employee_id || '-' || last_name || q'['s Salary :]' || salary
FROM employees;

--DISTINCT 사용으로 결과에서 중복 제거
SELECT department_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;

SELECT DISTINCT department_id, job_id
FROM employees;


--WHERE 기본적인 사용

--department_id가 60인 정보 중에서 조회 해주세요
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 60;

SELECT last_name, job_id, department_id
FROM employees;

SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'King';

SELECT last_name, hire_date
FROM employees;

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '1999/09/21';

SELECT employee_id, salary, department_id
FROM employees
WHERE department_id <> 90;

SELECT last_name, salary
FROM employees
WHERE salary <= 5000;

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '00/01/01';

SELECT last_name, hire_date
FROM employees
WHERE last_name < 'King';


--Between 연산자의 사용
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 6000 AND 9000;

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 9000 AND 6000;


--IN 연산자의 사용

SELECT employee_id, last_name, salary, department_id
FROM employees
--java : department_id = 50 || department_id = 60 || department_id = 80
WHERE department_id IN (50,60,80);

SELECT employee_id, last_name, salary, department_id
FROM employees
--java : job_id = IT_PROG || job_id = SA_REP
WHERE job_id IN ('IT_PROG', 'SA_REP');


--LIKE 연산자 (패턴을 활용해서 조건에 맞는 데이터를 조회)
SELECT employee_id, last_name, job_id, department_id
FROM employees
--A로 시작하는 단어
WHERE Last_name LIKE 'A%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--가운데에 a가 들어가는 단어
WHERE Last_name LIKE '%a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--last_name에서 첫 글자는 아무거나 한개 존재하고 a로 시작하는 단어(두번째 글자가 a인 단어)
WHERE Last_name LIKE '_a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--last_name에서 a앞에 아무거나 두 글자가 존재하고 a는 세번째에 오는 단어
WHERE Last_name LIKE '__a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--Last_name 에서 세글자로 된 단어
WHERE Last_name LIKE '___';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--last_name에서 s로 끝나는 단어
WHERE Last_name LIKE '%s';


--ESCAPE문자 사용
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id LIKE '%SA\_%' ESCAPE '\';


--NULL값 검색
SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id = null;

SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id IS NULL;


--논리 연산자의 사용
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
OR salary > 8000;

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
AND salary > 8000;


--NOT 연산자
SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id IS NOT NULL;

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name NOT LIKE '%a%';

SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 6000 AND 9000;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE department_id NOT IN (50,60,80);


--연산자의 우선 순위
select employee_id, last_name, job_id, salary
from employees
where job_id like 'IT%'
or job_id like '%CLERK%'
and salary < 5000;

select employee_id, last_name, job_id, salary
from employees
where (job_id like 'IT%'
or job_id like '%CLERK%')
and salary < 5000;


--ORDER BY 데이터 정렬
--1개 열 기준으로 정렬
SELECT *
FROM employees
ORDER BY last_name;

--입사일이 빠른 순서대로 정렬
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY hire_date;

--급여가 많은 순서대로 출력
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY salary DESC;

--2개 이상의 열 기준 정렬
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY department_id, salary DESC;

--표현식 또는 별칭 기준 정렬
SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY department_id, salary*12 DESC;

SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY department_id, annsal DESC;


--위치값 (position Number)에 따른 정렬 방식
SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY 5,4 DESC;

SELECT *
FROM employees
ORDER BY 6;

--테이블 구조 확인
DESC employees;


--UNION 집합 (합집합)
SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;

SELECT employee_id FROM employees
UNION ALL
SELECT employee_id FROM job_history;

--MINUS (차집합)
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;

SELECT employee_id FROM job_history
MINUS
SELECT employee_id FROM employees;

--INTERSECT (교집합)
SELECT employee_id FROM employees
INTERSECT
SELECT employee_id FROM job_history;


--UNION 참고사항
--SELECT employee_id, department_id FROM employees
--UNION  열의 개수가 다름. 한쪽을 추가하거나 한쪽을 줄여야 함
--SELECT employee_id FROM job_history;

--SELECT employee_id, department_id FROM employees
--UNION  위 아래 순서 맞게 데이터 타입이 같아야함
--SELECT employee_id, job_id FROM job_history;

--SELECT employee_id, last_name FROM employees
--ORDER BY 정렬하고 더하고 또 다시 정렬한다? 비효율적! 맨 밑으로 가라
--UNION
--SELECT employee_idm job_id FROM job_history;

SELECT employee_id, last_name FROM employees
UNION
SELECT employee_id, job_id FROM job_history
ORDER BY employee_id;



--치환변수
set verify on
show verify
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = &dept_no;
set verify off

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id = UPPER ('&job_title');

SELECT employee_id, last_name, job_id, &column_name
FROM employees
ORDER BY &column_name;

define column_name;
undefine column_name;
