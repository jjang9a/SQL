-- Chapter 07 ) 조인


--1. LOCATIONS 및 COUNTRIES 테이블을 사용하여 HR 부서를 위해 모든 부서의 주소를 생성하는 query를 작성하시오.
--출력에 위치 ID, 주소, 구/군, 시/도 및 국가를 표시하며, NATURAL JOIN을 사용하여 결과를 생성합니다.
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name
FROM locations l NATURAL JOIN countries c;

--2. 모든 사원의 성, 소속 부서번호 및 부서 이름을 표시하는 query를 작성하시오.
SELECT e.last_name, department_id, d.department_name
FROM employees e JOIN departments d
USING (department_id);

--3. Toronto에 근무하는 사원에 대한 보고서를 필요로 합니다. toronto에서 근무하는 모든 사원의 성, 직무, 부서번호 및 부서 이름을 표시하시오. (힌트 : 3-way join 사용)
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
                            JOIN locations l ON (d.location_id = l.location_id)
WHERE l.city = 'Toronto';

--4. 사원의 성 및 사원 번호를 해당 관리자의 성 및 관리자 번호와 함께 표시하는 보고서를 작성하는데, 열 레이블을 각각 Employee, Emp#, Manager 및 Mgr#으로 지정하시오.
SELECT e.last_name as Employee, e.employee_id Emp#, m.last_name Manager, m.employee_id Mgr#
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

--5. King과 같이 해당 관리자가 지정되지 않은 모든 사원을 표시하도록 4번 문장을 수정합니다. 사원 번호순으로 결과를 정렬하시오. 
SELECT e.last_name as Employee, e.employee_id Emp#, m.last_name Manager, m.employee_id Mgr#
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id)
ORDER BY e.employee_id;

--6. 사원의 성과 부서 번호 및 주어진 사원과 동일한 부서에 근무하는 모든 사원을 표시하는 보고서를 작성하시오. 각열에 적절한 레이블을 자유롭게 지정해 봅니다.
SELECT e.last_name, e.department_id, m.last_name
FROM employees e, employees m
WHERE e.department_id = m.department_id
AND e.employee_id != m.employee_id;

-- Chapter 08 ) 서브쿼리

--1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하시오. Zlotkey는 결과에서제외하시오.
SELECT first_name, hire_date
FROM employees
WHERE department_id = (
                                    SELECT department_id
                                    FROM employees
                                    WHERE last_name = 'Zlotkey'
                                    );

--2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 결과를 급여에 대해 오름차순으로 정렬하시오.
SELECT employee_id, first_name
FROM employees
WHERE salary > (
                        SELECT TRUNC(AVG(salary))
                        FROM employees
                        )
ORDER BY salary;

--3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 질의를 실행하시오.
SELECT employee_id, first_name
FROM employees
WHERE department_id IN (
                                    SELECT department_id
                                    FROM employees
                                    WHERE first_name LIKE '%u%'
                                    );

--4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하시오.
SELECT first_name, department_id, job_id
FROM employees
WHERE department_id IN (
                                    SELECT department_id
                                    FROM departments
                                    WHERE location_id = 1700
                                    );

--5. King에게 보고하는(manager가 King) 모든 사원의 이름과 급여를 표시하시오.
SELECT first_name, salary
FROM employees
WHERE manager_id = (
                                SELECT employee_id
                                FROM employees
                                WHERE last_name = 'King'
                                );

--6. Executive 부서의 모든 사원에 대한 부서 번호, 이름 및 업무 ID를 표시하시오.
SELECT department_id, e.first_name, e.job_id
FROM employees e NATURAL JOIN departments d
WHERE d.department_name = (
                                            SELECT department_name
                                            FROM departments
                                            WHERE department_name = 'Executive'
                                            );

--7. 평균 급여보다 많은 급여를 받고 이름에 u가 포함된 사원과 같은 부서에서 근무하는 모든 사원의 사원 번호, 이름 및 급여를 표시하시오.
SELECT employee_id, first_name, salary 
FROM employees
WHERE salary > (
                        SELECT TRUNC(AVG(salary))
                        FROM employees
                        )
AND department_id IN (
                                SELECT department_id
                                FROM employees
                                WHERE first_name LIKE '%u%'
                                );
