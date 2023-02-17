-- 1) 사원 테이블에서 사원번호와 이름과 월급을 출력하라.
SELECT employee_id, first_name, salary
FROM employees;

-- 2) 사원 테이블의 모든 컬럼을 전무 출력하라.
SELECT *
FROM employees;

-- 3) 사원 테이블의 사원번호와 이름, 월급을 출력하는데 컬럼명을 한글로 '사원 번호', '사원 이름'으로 출력하라.
SELECT employee_id AS 사원번호, first_name AS 사원이름, salary
FROM employees;

-- 4) 사원 테이블의 이름과 월급을 이용하여 다음과 같이 출력하라.
-- - 출력예제 ) 사원 이름이 Steven 이고 월급이 30000일 경우, 'Steven 의 월급은 30000 달러입니다.'
SELECT first_name, salary, first_name || '의 월급은 ' || salary || '달러입니다.' AS result
FROM employees;

-- 5) 사원 테이블에서 직업을 출력하는데 중복된 데이터를 제외하고 출력하라.
SELECT DISTINCT job_id
FROM employees;

-- 6) 모든 사원의 이름과 월급을 출력하는데 월급이 낮은 사원부터 출력하라.
SELECT first_name, salary
FROM employees
ORDER BY salary;

-- 7) 모든 사원 중 월급이 3000인 사원들의 이름, 월급, 업무를 출력하라.
SELECT first_name, salary, job_id
FROM employees
WHERE salary = 3000;

-- 8) 이름이 'Steven'인 사원의 이름, 월급, 업무, 입사일, 부서번호를 출력하라.
SELECT first_name, salary, job_id, hire_date, department_id
FROM employees
WHERE first_name = 'Steven';

-- 9) 연봉이 3600이상인 사원들의 이름과 연봉을 출력하라.
-- - 연봉은 커미션이 있는 경우 월급에 수당을 더하고 12를 곱해서 구한다.
-- - 수당은 월급에 커미션을 곱해서 구한다.
SELECT first_name, (salary + salary*commission_pct)*12 AS annsal
FROM employees
WHERE (salary + salary*commission_pct)*12 >= 3600;

-- 10) 월급이 12000이하인 사원들의 이름과, 월급, 업무, 부서번호를 출력하라.
SELECT first_name, salary, job_id, department_id
FROM employees
WHERE salary <= 12000;

-- 11) 업무가 'SA_MAN'이 아닌 사원들의 이름과 부서번호, 업무를 출력하라.
SELECT last_name, department_id, job_id
FROM employees
WHERE job_id != 'SA_MAN';

-- 12) 월급이 1000에서 3000사이인 사원들의 이름과 월급을 출력하라.
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 1000 AND 3000;

-- 13) 월급이 1000에서 3000사이인 아닌 사원들의 이름과 월급을 출력하라.
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1000 AND 3000;

-- 14) 2006년도에 입사한 사원들의 이름과 입사일을 출력하라.
SELECT last_name, hire_date
FROM employees
WHERE SUBSTR(hire_date, 1, 2) = 06;

-- 15) 이름의 첫 글자가 S로 시작하는 사원들의 이름과 월급을 출력하라.
SELECT first_name, salary
FROM employees
WHERE first_name LIKE 'S%';

-- 16) 이름의 끝 글자가 T로 끝나는 사원들의 이름과 월급을 출력하라.
SELECT first_name, salary
FROM employees
WHERE UPPER(first_name) LIKE '%T';

-- 17) 이름의 두번째 철자가 M 인 사원의 이름과 월급을 출력하라.
SELECT first_name, salary
FROM employees
WHERE UPPER(first_name) LIKE '_M%';

-- 18) 이름에 A를 포함하고 있는 사원들의 이름을 출력하라.
SELECT first_name, salary
FROM employees
WHERE UPPER(first_name) LIKE '%A%';

-- 19) 커미션이 NULL인 사원들의 이름과 커미션을 출력하라.
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NULL;

-- 20) 업무가 'SA_MAN', 'PU_CLERK', 'IT_PROG' 인 사원들의 이름, 월급, 직업을 출력하라.
SELECT first_name, salary, job_id
FROM employees
WHERE job_id = 'SA_MAN' OR job_id = 'PU_CLERK' OR job_id = 'IT_PROG';

-- 21) 업무가 'SA_MAN', 'PU_CLERK', 'IT_PROG' 가 아닌 사원들의 이름, 월급, 직업을 출력하라.
SELECT first_name, salary, job_id
FROM employees
WHERE job_id != 'SA_MAN' AND job_id != 'PU_CLERK' AND job_id != 'IT_PROG';

-- 22) 직업이 'SA_MAN'이고 월급이 1200이상인 사원들의 이름, 월급, 업무를 출력하라.
SELECT first_name, salary, job_id
FROM employees
WHERE job_id = 'SA_MAN' AND salary >= 1200;

-- 23) 사원 테이블의 이름을 출력하라. 단 첫 번째 컬럼은 이름을 대문자로 출력하고, 두 번째 컬럼은 이름을 소문자로 출력하고, 세 번째 컬럼은 이름의 첫 번째 철자는 대문자로, 나머지는 소문자로 출력하라.
SELECT UPPER(last_name), LOWER(last_name), INITCAP(last_name)
FROM employees;

-- 24) 이름이 alexander(모두 소문자)인 사원의 이름과 월급을 조회하라
SELECT LOWER(first_name), salary
FROM employees
WHERE LOWER(first_name) = 'alexander';

-- 25) 영어 단어 SMITH에서 SMI만 잘라서 출력하라.
SELECT SUBSTR('SMITH', 1, 3)
FROM dual;

-- 26) 사원들의 이름을 출력하고 그 옆에 이름의 철자 개수를 출력하라.
SELECT first_name, LENGTH(first_name)
FROM employees;

-- 27) 이름에 소문자 a가 존재하는 경우 몇번째 자리에 위치하는 지 출력하라.
SELECT first_name, INSTR(first_name, 'a')
FROM employees;

-- 28) 사원들의 이름과 월급을 출력하라. 단 월급 컬럼의 자릿수를 10자리로 하고, 월급을 출력하고 남은 나머지 자리에 *(별표)를 채워서 출력하라.
SELECT first_name, LPAD(salary, 10, '*')
FROM employees;

-- 29) 사원들의 이름과 월급을 출력하라. 단 월급 100을 네모(■) 하나로 출력하라.
SELECT first_name, REPLACE(salary, 100, '■')
FROM employees; 

-- 30) 876.567 숫자를 출력하라, 단 소수점 두 번째 자리인 6에서 반올림해서 출력하라.
SELECT ROUND(876.567, 1)
FROM dual;

-- 31) 876.567 숫자를 출력하라. 단 소수점 두 번째 자리인 6과 그 이후의 숫자들은 모두 버리고 출력하라
SELECT TRUNC(876.567, 1)
FROM dual;

-- 32) 숫자 10을 3으로 나눈 나머지 값을 출력하라
SELECT MOD(10,3)
FROM dual;

-- 33) 사원 번호와 사원 번호가 홀수이면 1, 짝수이면 0을 출력하라.
SELECT employee_id, MOD(employee_id, 2)
FROM employees;

-- 34) 사원번호가 짝수인 사원들의 사원 번호와 이름을 출력하라.
SELECT employee_id, first_name
FROM employees
WHERE MOD(employee_id, 2) = 0;

-- 35) 사원의 이름과 입사한 날짜부터 오늘 총 몇 달을 근무했는지 출력하라. 

-- 36) 2018년 10월 1일에서 2019년 6월 1일 사이의 총일수를 출력하라.

-- 37) 2018년 10월 1일에서 2019년 6월 1일 사이의 총 주(Week) 수를 출력하라.

-- 38) 2019년 5월 1일로부터 100달 뒤의 날짜는 어떻게 되는지 출력하라.

-- 39) 2019년 5월 1일로부터 100일 후에 돌아오는 날짜는 어떻게 되는지 출력하라.

-- 40) 2021년 6월 30일로부터 바로 돌아올 화요일의 날짜가 어떻게 되는지 출력하라

-- 41) 2019년 5월 22일로부터 바로 돌아올 월요일의 날짜가 어떻게 되는지 출력하라

-- 42) 오늘부터 앞으로 돌아올 화요일의 날짜를 출력하라

-- 43) 2019년 5월 22일부터 100달 뒤에 돌아오는 화요일의 날짜를 출력하라

-- 44) 오늘로부터 100달 뒤에 돌아오는 월요일의 날짜 출력

-- 45) 2019년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 출력하라

-- 46) 오늘부터 이번 달 말일까지 총 며칠 남았는지 출력하라

-- 47) 이름이 SUSAN인 사원의 이름, 입사일, 입사한 달의 마지막 날짜를 출력하라

-- 48) 이름이 GRANT인 사원의 이름과 입사한 요일을 출력하고, GRANT의 월급에 천단위를 구분할 수 있는 콤마(,)를 붙여 출력하라

-- 50) 2008년도에 입사한 사원의 이름과 입사일을 출력하라

-- 51) 월급이 1500 이상인 사원의 이름과, 월급에 천단위를 구분할 수 있는 콤마(,)와 화폐단위를 붙여 출력하라

-- 52) 2005년 06월 14일에 입사한 사원의 이름과 입사일을 출력하라

-- 53) 사원의 이름과 커미션을 출력하라. 단 커미션이 NULL인 사원들은 0으로 출력하라

-- 54) 직업이 'SA_MAN' 또는 'IT_PROG' 인 사원의 월급과 커미션, 그리고 월급과 커미션의 합을 출력하시오. 단 커미션이 NULL인 경우 0으로 표시하여 출력하라

-- 55) 사원의 이름과 부서 번호를 출력하시오, 또한 부서 번호가 10번이면 300을, 부서 번호가 20번이면 400을, 나머지 부서 번호는 0을 출력하는 '보너스'를 출력하라

-- 56) 사원 번호와 사원 번호가 짝수인지 홀수인지를 출력하라

-- 57) 사원의 이름, 직업, 보너스를 출력하시오. 단 직업이 'SA_MAN'이면 보너스 5000을 출력하고, 나머지 직업은 보너스 2000을 출력하라

-- 58) 사원의 이름, 직업, 월급, 보너스를 출력하시오. 단 보너스는 월급이 3000이상이면 500을, 월급이 2000이상 3000미만이면 300을, 월급이 1000이상 2000미만이면 200을, 나머지는 0을 출력하라

-- 59) 사원의 이름, 직업, 커미션, 보너스를 출력하시오. 단 보너스는 커미션이 NULL이면 500을, NULL이 아니면 0을 출력하라

-- 60) 사원의 이름, 직업, 보너스를 출력하시오. 단 보너스는 직업이 'SA_MAN', 'PU_CLERK' 이면 500을, 'ST_CLERK', 'FI_ACCOUNT'이면 400을, 나머지 JOB은 0을 출력하시오.