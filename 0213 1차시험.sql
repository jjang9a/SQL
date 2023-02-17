-- 1번) 모든 사원들에 대해 사원번호, 이름, 업무, 입사일 출력
SELECT employee_id, first_name, job_id, hire_date
FROM employees;

-- 2번) 매니저 직책의 사원번호 - 중복되지 않게 출력
SELECT DISTINCT manager_id
FROM employees;

-- 3번) 급여가 7000이상, 12000이하이며 이름이 'H'로 시작하는 사원의 사원번호, 이름, 급여, 부서번호 출력
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary BETWEEN 7000 AND 12000 AND last_name like 'H%';

--4번) 2005년 1월 1일 이후에 입사한 사원의 사번, 이름, 입사일, 첫 문자부터 3문자만 출력된 이메일계정, 이메일의 글자수 출력
SELECT employee_id, first_name, hire_date, SUBSTR(email, 1, 3) EMAIL, LENGTH(email) AS EMAIL_LENGTH
FROM employees
WHERE hire_date >= '2005/01/01';

-- 5번) 모든사원 : 이름, 입사일, 입사 6개월후의 날짜, 입사 후 첫 금요일, 총 근무 개월(버림), 첫 급여일(입사한 다음 달 1일) - 오름차순 정렬
SELECT first_name, hire_date, ADD_MONTHS (hire_date, 6) AS 여섯달후, NEXT_DAY(hire_date, '금요일') AS 다음금요일, 
            TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS 근무개월, TRUNC(ADD_MONTHS(hire_date,1),'month') AS 첫급여일 
FROM employees
ORDER BY hire_date;

-- 6번) 커미션을 받는 사원 대상 / 사원번호, 이름, 입사일, 수당(급여*커미션)
SELECT employee_id, first_name, TO_CHAR(hire_date, 'dd/mm/yyyy day') AS 입사일, TO_CHAR(salary*commission_pct, '$9,999.99') as 수당
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY 수당 DESC;

-- 7번) 부서번호가 50번과 60번 직원 가운데 급여가 5000보다 많은 직원의 사원번호, 이름, 업무ID, 급여, 부서번호
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE (department_id = 50 OR department_id = 60) AND salary > 5000;

-- 8번) 함수이용 - 전화번호의 지역번호가 515로 시작하는 사원의 사번, 업무ID, 전화번호, 부서번호 출력
SELECT employee_id, job_id, phone_number, department_id
FROM employees
WHERE SUBSTR(phone_number, 1, 3) = 515;

-- 9번) 사원번호, 사원이름, 연봉=(급여+수당)*12, 입사한 연도, 수당을 받는지 여부(COMM, NOCOMM)를 나타내는 비고, 부서번호 / 부서번호, 연봉에 오름차순
SELECT employee_id, first_name, (salary * (1+NVL(commission_pct,0)))*12 as 연봉, TO_CHAR(hire_date, 'yyyy') as 입사년도,
            NVL2(commission_pct, 'COMM', 'NOCOMM') AS 비고, department_id
FROM employees
ORDER BY department_id, salary;

-- 10번) 사원번호, 사원이름, 부서번호 및 근무지역 - 20 캐나다, 80 영국, 나머지 미국
SELECT employee_id, first_name, department_id,
            CASE department_id WHEN 20 THEN 'Canada'
                                       WHEN 80 THEN 'UK'
            ELSE                      'USA' END AS 근무지역
FROM employees;