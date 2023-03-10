--대소문자 변환 문자 함수
SELECT UPPER('Oracle Database'),
    LOWER('Oracle Datebase'),
    INITCAP('oracle database')
FROM dual;

SELECT employee_id, last_name, UPPER(last_name),
        job_id, INITCAP(job_id)
FROM employees;

SELECT employee_id, last_name, job_id
FROM employees
WHERE last_name = 'king';

SELECT employee_id, last_name, job_id
FROM employees
WHERE LOWER(last_name) = 'king';

SELECT employee_id, last_name, job_id
FROM employees
WHERE last_name = INITCAP('king');


-- <<여러가지 문자 함수>>

--CONCAT
SELECT CONCAT ('Hello', 'World')
FROM dual;

SELECT CONCAT(CONCAT('Hello', ' '), 'World')
FROM dual;
                    --연결 연산자(||)와 같은 역할
SELECT employee_id, CONCAT(first_name, last_name) full_name, job_id, email
FROM employees;

SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) full_name, job_id, email
FROM employees;

--SUBSTR
SELECT SUBSTR('HelloWorld', 1, 5), SUBSTR('HelloWorld', 6), SUBSTR('HelloWorld',5,5)
FROM dual;

SELECT *
FROM employees
WHERE SUBSTR(last_name, -1, 1) = 'n';
-- 같은결과가 나오게 하는 어제배운 방식
SELECT *
FROM employees
WHERE last_name LIKE '%n';

--LENGTH
SELECT LENGTH('Oracle Database'), LENGTH('오라클 데이터베이스')
FROM dual;

SELECT *
FROM employees
WHERE LENGTH(last_name) > 6;

--INSTR (Java : indexOf와 비슷)
SELECT INSTR('HelloWorld', 'l')
FROM dual;

SELECT INSTR(last_name, 'a'), last_name
FROM employees;

--a가 없는 사람만 출력하기
SELECT *
FROM employees
WHERE INSTR(last_name, 'a') = 0;
--같은 결과값 다른 방식
SELECT *
FROM employees
WHERE last_name NOT LIKE '%a%';

SELECT INSTR('HelloWorld', 'l', 4, 2), INSTR('HelloWorld', 'l', 1, 3)
FROM dual;

--LPAD
SELECT employee_id, RPAD(last_name, 15, '*') last_name, LPAD(salary, 10, '#')
FROM employees;

--REPLACE
SELECT REPLACE('Jack and Jue', 'J', 'BL')
FROM dual;

--REPLACE 응용
SELECT employee_id, last_name,
            REPLACE(last_name, SUBSTR(last_name, 2, 2), '**') AS RESULT
FROM employees;

--TRIM -> 1) 양쪽의 공백을 지움 / 2) 양쪽의 데이터를 지움
SELECT TRIM('   HelloWorld                     ')
FROM dual;

SELECT TRIM('H' FROM 'HelloWorld'), TRIM('d' FROM 'HelloWorld')
FROM dual;

SELECT TRIM('w' FROM 'window') ,TRIM(LEADING 'w' FROM 'window'), TRIM(TRAILING 'w' FROM 'window')
FROM dual;

SELECT TRIM(0 FROM 000012345670), TRIM(LEADING 0 FROM 000012345670)
FROM dual;
--안되는 예제 : 지우고자 하는 조건문자가 2글자 이상이면 안됨. 한글자만 가능.
SELECT TRIM('xy' FROM 'xyxyxyxykkkkxy')
FROM dual;




--실습문제 1)
--yedam, Database 두 단어를 합쳐 yedamDatabase로 출력하시오.
SELECT CONCAT('yedam', 'Database')
FROM dual;

--실습문제 2)
--lower 함수를 활용하여 it_prog(소문자) 직책을 가진 모든 직원들을 출력하시오.
SELECT *
FROM employees
WHERE LOWER(job_id) = 'it_prog';

--실습문제 3)
--WelcomeToCodingWorld 문자열에서 1)To 2) World 3) WelcomeToCodingWorl 를 출력하시오.
SELECT SUBSTR('WelcomcToCodingWorld', 8,2), SUBSTR('WelcomcToCodingWorld', -5), SUBSTR('WelcomcToCodingWorld', 1, 19),
        TRIM(TRAILING 'd' FROM 'WelcomcToCodingWorld')
FROM dual;

--실습문제 4)
--employees 테이블에서 last_name의 길이가 5 인 직원 중 가운데 3자리를 * 표시하여 employee_id, last_name, 변경된 last_name를 조회하시오
SELECT employee_id, last_name, REPLACE(last_name, SUBSTR(last_name, LENGTH(last_name)/2, 3), '***') AS RESULT
FROM employees
WHERE LENGTH(last_name) = 5;

--실습문제 5)
--LPAD와 RPAD를 적절히 활용하여 last_name은 10자리 중 왼쪽 남는 공간에 * 추가하여 출력, first_name은 10자리중 오른쪽 공간에 #을 추가하여 조회하시오.
SELECT LPAD(last_name, 10, '*'), RPAD(first_name, 10, '#')
FROM employees;

--실습문제 6)
--사번과 성과 이름이 합쳐진 이름, 직책, 이름의 길이, 이름 중 a가 몇 번째 포함 되어 있는지 직책이 REP가 포함 된 사람의 정보를 조회 하시오
--단, 직책이 REP가 포함 된 사람을 찾을때엔 LIKE를 쓰지 않는다.
--alias 도 적극 활용하여 결과물을 만들어보도록 한다.
SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) AS full_name,  job_id, LENGTH(first_name), INSTR(first_name, 'a') as A
FROM employees
WHERE INSTR(job_id, 'REP') <> 0;


--숫자 함수
SELECT ROUND(45.923, 2), ROUND(45.923), ROUND(45.923, -1)
FROM dual;

SELECT TRUNC(45.923, 2), TRUNC(45.923), TRUNC(45.923, -1)
FROM dual;

SELECT last_name, salary, MOD(salary, 500)
FROM employees
WHERE job_id = 'SA_REP';

SELECT FLOOR(45.999), CELL(45.999)
FROM dual;


--날짜 연산

--sysdate

SELECT sysdate
FROM dual;

--일 수 더하기
SELECT sysdate + 10
FROM dual;

--근무 일 수 구하기
SELECT employee_id, last_name, hire_date, sysdate-hire_date AS 근무일수
FROM employees;

SELECT employee_id, last_name, hire_date, TRUNC(sysdate-hire_date) AS 근무일수
FROM employees;

--근무한 주
SELECT last_name, ROUND((sysdate - hire_date) /7) AS WEEKS
FROM employees;

--날짜 함수

SELECT MONTHS_BETWEEN ('22/12/01', '22/01/01')
FROM dual;

SELECT employee_id, last_name,
TRUNC (MONTHS_BETWEEN (sysdate, hire_date)) AS 근무개월수
FROM employees;

SELECT ADD_MONTHS (sysdate, 3), LAST_DAY(sysdate), NEXT_DAY(sysdate, '금')
FROM dual;

SELECT NEXT_DAY (sysdate, '금요일'), NEXT_DAY(sysdate, '금'), NEXT_DAY(sysdate, 6)
FROM dual;

ALTER SESSION SET
NLS_DATE_FORMAT = 'RRRR-MM-DD HH24:MI';

SELECT sysdate
FROM dual;

ALTER SESSION SET
NLS_DATE_FORMAT = 'yy/mm/dd';

SELECT NEXT_DAY(sysdate, 'FRIDAY')
FROM dual; --현재 위치가 한국이라서 영어는 인식 못함

ALTER SESSION SET
NLS_DATE_LANGUAGE = 'american';
ALTER SESSION SET
NLS_DATE_LANGUAGE = 'korean';

--day는 요일 / dd는 오늘
--sysdate : 2023/02/10
SELECT ROUND (sysdate, 'year'), ROUND(sysdate, 'month'), ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;

SELECT TRUNC (sysdate, 'year'), TRUNC(sysdate, 'month'), TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;


--변환 함수
--날짜 -> 문자로 변환

SELECT employee_id, last_name, hire_date
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd')
FROM employees;

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
           TO_CHAR(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss'),
           TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

--DDSPTH
SELECT TO_CHAR(hire_date, 'yyyy"년" Ddspth month hh:mi:ss pm'), hire_date
FROM employees;

--숫자를 문자로 변환
SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999')
FROM employees;

SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999'), TO_CHAR(salary, '$099,999')
FROM employees;

SELECT employee_id, last_name, salary, TO_CHAR(salary, 'L999,999') ||'원'
FROM employees;

ALTER SESSION SET
NLS_TERRITORY = japan;

SELECT employee_id, last_name, salary, TO_CHAR(salary, 'L999,999')
FROM employees;

ALTER SESSION SET
NLS_TERRITORY = korea;

SELECT employee_id, last_name, 
            TO_CHAR(hire_date, 'yyyy-mm-dd') AS hire_data,
            TO_CHAR(hire_date, 'q') AS 분기, 
            TO_CHAR(hire_date, 'w')||'주차' AS 주수
FROM employees;

SELECT TO_CHAR(sysdate, 'w') || '주차'
FROM dual;


--문자를 숫자로 변환

SELECT TO_NUMBER('$3,400', '$99,999')
FROM dual;

SELECT TO_NUMBER('5000')
FROM dual;

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000', '$9,999');


--문자를 날짜로 변환
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > '1999/12/31';

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('1999/12/31', 'yyyy/mm/dd');

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'yy/mm/dd'); --2099년 이후 입사일로 인식하기때문에 결과값 없음

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'rr/mm/dd'); --rr방식으로 이전세기 값을 붙여 1999년으로 인식

--NVL
SELECT employee_id, last_name, salary, commission_pct, NVL(commission_pct, 0)
FROM employees;

SELECT employee_id, last_name, salary, (salary+salary*commission_pct) AS monthly_sal
FROM employees; --null값 때문에 제대로 계산이 안 됨

SELECT employee_id, last_name, salary, (salary+salary*NVL(commission_pct, 0)) AS monthly_sal
FROM employees;

SELECT employee_id, last_name, salary+salary*NVL(commission_pct, 0) AS monthly_sal,
            NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;
            
SELECT last_name, salary, commission_pct,
            NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees
WHERE department_id IN (50,80);
        
SELECT employee_id, last_name, salary+salary*NVL(commission_pct, 0) AS monthly_sal,
            NVL2(commission_pct, 'Y', 'N') AS comm_get,
            NULLIF(salary, salary+salary*NVL(commission_pct, 0)) AS result
FROM employees;

SELECT first_name, LENGTH(first_name) "expr1",
            last_name, LENGTH(last_name) "expr2",
            NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees;



--일반함수 COALESCE

SELECT employee_id, commission_pct, manager_id,
            COALESCE(commission_pct, manager_id, 1234) AS result
FROM employees;

SELECT last_name, employee_id,
            COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id),
            'No Commission and No Manager')
FROM employees;

--case when then

SELECT last_name, job_id, salary,
            CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                             WHEN 'ST_CLERK' THEN 1.15*salary
                             WHEN 'SA_REP' THEN 1.20*salary
            ELSE           salary END AS REVISED_SALARY
FROM employees;

SELECT last_name, job_id, salary,
            CASE WHEN job_id= 'IT_PROG' THEN 1.10*salary
                    WHEN job_id='ST_CLERK' THEN 1.15*salary
                    WHEN job_id='SA_REP' THEN 1.20*salary
            ELSE           salary END AS REVISED_SALARY
FROM employees;

SELECT employee_id, last_name, salary,
            CASE WHEN salary < 5000 THEN 'L'
                    WHEN salary BETWEEN 5000 AND 9000 THEN 'M'
                    ELSE 'H' END AS salary_grade
FROM employees;

--VNL2를 CASE-WHEN-THEN 으로 교체
SELECT employee_id, last_name, salary+salary*NVL(commission_pct, 0) AS monthly_sal,
            NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;

SELECT employee_id, last_name, salary+salary*NVL(commission_pct, 0) AS monthly_sal,
            CASE WHEN commission_pct IS NOT NULL THEN 'Y'
            ELSE 'N' END AS comm_get
FROM employees;


--DECODE
SELECT last_name, job_id, salary,
            CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                             WHEN 'ST_CLERK' THEN 1.15*salary
                             WHEN 'SA_REP' THEN 1.20*salary
            ELSE           salary END AS REVISED_SALARY
FROM employees;

SELECT last_name, job_id, salary,
            DECODE(job_id, 'IT_PROG', 1.10*salary,
                                  'ST_CLERK', 1.15*salary,
                                  'SA_REP', 1.20*salary,
                                  salary) REVISED_SALARY
FROM employees;

--Java switch, 시험성적 -> 99~90 / 9, 89~80 / 8

SELECT last_name, salary,
            DECODE (TRUNC(salary/2000, 0),
                        0, 0.00,
                        1, 0.09,
                        2, 0.20,
                        3, 0.30,
                        4, 0.40,
                        5, 0.42,
                        6, 0.44,
                            0.45) TAX_RATE
FROM employees;

