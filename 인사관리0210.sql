--��ҹ��� ��ȯ ���� �Լ�
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


-- <<�������� ���� �Լ�>>

--CONCAT
SELECT CONCAT ('Hello', 'World')
FROM dual;

SELECT CONCAT(CONCAT('Hello', ' '), 'World')
FROM dual;
                    --���� ������(||)�� ���� ����
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
-- ��������� ������ �ϴ� ������� ���
SELECT *
FROM employees
WHERE last_name LIKE '%n';

--LENGTH
SELECT LENGTH('Oracle Database'), LENGTH('����Ŭ �����ͺ��̽�')
FROM dual;

SELECT *
FROM employees
WHERE LENGTH(last_name) > 6;

--INSTR (Java : indexOf�� ���)
SELECT INSTR('HelloWorld', 'l')
FROM dual;

SELECT INSTR(last_name, 'a'), last_name
FROM employees;

--a�� ���� ����� ����ϱ�
SELECT *
FROM employees
WHERE INSTR(last_name, 'a') = 0;
--���� ����� �ٸ� ���
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

--REPLACE ����
SELECT employee_id, last_name,
            REPLACE(last_name, SUBSTR(last_name, 2, 2), '**') AS RESULT
FROM employees;

--TRIM -> 1) ������ ������ ���� / 2) ������ �����͸� ����
SELECT TRIM('   HelloWorld                     ')
FROM dual;

SELECT TRIM('H' FROM 'HelloWorld'), TRIM('d' FROM 'HelloWorld')
FROM dual;

SELECT TRIM('w' FROM 'window') ,TRIM(LEADING 'w' FROM 'window'), TRIM(TRAILING 'w' FROM 'window')
FROM dual;

SELECT TRIM(0 FROM 000012345670), TRIM(LEADING 0 FROM 000012345670)
FROM dual;
--�ȵǴ� ���� : ������� �ϴ� ���ǹ��ڰ� 2���� �̻��̸� �ȵ�. �ѱ��ڸ� ����.
SELECT TRIM('xy' FROM 'xyxyxyxykkkkxy')
FROM dual;




--�ǽ����� 1)
--yedam, Database �� �ܾ ���� yedamDatabase�� ����Ͻÿ�.
SELECT CONCAT('yedam', 'Database')
FROM dual;

--�ǽ����� 2)
--lower �Լ��� Ȱ���Ͽ� it_prog(�ҹ���) ��å�� ���� ��� �������� ����Ͻÿ�.
SELECT *
FROM employees
WHERE LOWER(job_id) = 'it_prog';

--�ǽ����� 3)
--WelcomeToCodingWorld ���ڿ����� 1)To 2) World 3) WelcomeToCodingWorl �� ����Ͻÿ�.
SELECT SUBSTR('WelcomcToCodingWorld', 8,2), SUBSTR('WelcomcToCodingWorld', -5), SUBSTR('WelcomcToCodingWorld', 1, 19),
        TRIM(TRAILING 'd' FROM 'WelcomcToCodingWorld')
FROM dual;

--�ǽ����� 4)
--employees ���̺��� last_name�� ���̰� 5 �� ���� �� ��� 3�ڸ��� * ǥ���Ͽ� employee_id, last_name, ����� last_name�� ��ȸ�Ͻÿ�
SELECT employee_id, last_name, REPLACE(last_name, SUBSTR(last_name, LENGTH(last_name)/2, 3), '***') AS RESULT
FROM employees
WHERE LENGTH(last_name) = 5;

--�ǽ����� 5)
--LPAD�� RPAD�� ������ Ȱ���Ͽ� last_name�� 10�ڸ� �� ���� ���� ������ * �߰��Ͽ� ���, first_name�� 10�ڸ��� ������ ������ #�� �߰��Ͽ� ��ȸ�Ͻÿ�.
SELECT LPAD(last_name, 10, '*'), RPAD(first_name, 10, '#')
FROM employees;

--�ǽ����� 6)
--����� ���� �̸��� ������ �̸�, ��å, �̸��� ����, �̸� �� a�� �� ��° ���� �Ǿ� �ִ��� ��å�� REP�� ���� �� ����� ������ ��ȸ �Ͻÿ�
--��, ��å�� REP�� ���� �� ����� ã������ LIKE�� ���� �ʴ´�.
--alias �� ���� Ȱ���Ͽ� ������� �������� �Ѵ�.
SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) AS full_name,  job_id, LENGTH(first_name), INSTR(first_name, 'a') as A
FROM employees
WHERE INSTR(job_id, 'REP') <> 0;


--���� �Լ�
SELECT ROUND(45.923, 2), ROUND(45.923), ROUND(45.923, -1)
FROM dual;

SELECT TRUNC(45.923, 2), TRUNC(45.923), TRUNC(45.923, -1)
FROM dual;

SELECT last_name, salary, MOD(salary, 500)
FROM employees
WHERE job_id = 'SA_REP';

SELECT FLOOR(45.999), CELL(45.999)
FROM dual;


--��¥ ����

--sysdate

SELECT sysdate
FROM dual;

--�� �� ���ϱ�
SELECT sysdate + 10
FROM dual;

--�ٹ� �� �� ���ϱ�
SELECT employee_id, last_name, hire_date, sysdate-hire_date AS �ٹ��ϼ�
FROM employees;

SELECT employee_id, last_name, hire_date, TRUNC(sysdate-hire_date) AS �ٹ��ϼ�
FROM employees;

--�ٹ��� ��
SELECT last_name, ROUND((sysdate - hire_date) /7) AS WEEKS
FROM employees;

--��¥ �Լ�

SELECT MONTHS_BETWEEN ('22/12/01', '22/01/01')
FROM dual;

SELECT employee_id, last_name,
TRUNC (MONTHS_BETWEEN (sysdate, hire_date)) AS �ٹ�������
FROM employees;

SELECT ADD_MONTHS (sysdate, 3), LAST_DAY(sysdate), NEXT_DAY(sysdate, '��')
FROM dual;

SELECT NEXT_DAY (sysdate, '�ݿ���'), NEXT_DAY(sysdate, '��'), NEXT_DAY(sysdate, 6)
FROM dual;

ALTER SESSION SET
NLS_DATE_FORMAT = 'RRRR-MM-DD HH24:MI';

SELECT sysdate
FROM dual;

ALTER SESSION SET
NLS_DATE_FORMAT = 'yy/mm/dd';

SELECT NEXT_DAY(sysdate, 'FRIDAY')
FROM dual; --���� ��ġ�� �ѱ��̶� ����� �ν� ����

ALTER SESSION SET
NLS_DATE_LANGUAGE = 'american';
ALTER SESSION SET
NLS_DATE_LANGUAGE = 'korean';

--day�� ���� / dd�� ����
--sysdate : 2023/02/10
SELECT ROUND (sysdate, 'year'), ROUND(sysdate, 'month'), ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;

SELECT TRUNC (sysdate, 'year'), TRUNC(sysdate, 'month'), TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;


--��ȯ �Լ�
--��¥ -> ���ڷ� ��ȯ

SELECT employee_id, last_name, hire_date
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd')
FROM employees;

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
           TO_CHAR(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss'),
           TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

--DDSPTH
SELECT TO_CHAR(hire_date, 'yyyy"��" Ddspth month hh:mi:ss pm'), hire_date
FROM employees;

--���ڸ� ���ڷ� ��ȯ
SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999')
FROM employees;

SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999'), TO_CHAR(salary, '$099,999')
FROM employees;

SELECT employee_id, last_name, salary, TO_CHAR(salary, 'L999,999') ||'��'
FROM employees;

ALTER SESSION SET
NLS_TERRITORY = japan;

SELECT employee_id, last_name, salary, TO_CHAR(salary, 'L999,999')
FROM employees;

ALTER SESSION SET
NLS_TERRITORY = korea;

SELECT employee_id, last_name, 
            TO_CHAR(hire_date, 'yyyy-mm-dd') AS hire_data,
            TO_CHAR(hire_date, 'q') AS �б�, 
            TO_CHAR(hire_date, 'w')||'����' AS �ּ�
FROM employees;

SELECT TO_CHAR(sysdate, 'w') || '����'
FROM dual;


--���ڸ� ���ڷ� ��ȯ

SELECT TO_NUMBER('$3,400', '$99,999')
FROM dual;

SELECT TO_NUMBER('5000')
FROM dual;

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000', '$9,999');


--���ڸ� ��¥�� ��ȯ
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > '1999/12/31';

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('1999/12/31', 'yyyy/mm/dd');

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'yy/mm/dd'); --2099�� ���� �Ի��Ϸ� �ν��ϱ⶧���� ����� ����

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'rr/mm/dd'); --rr������� �������� ���� �ٿ� 1999������ �ν�

--NVL
SELECT employee_id, last_name, salary, commission_pct, NVL(commission_pct, 0)
FROM employees;

SELECT employee_id, last_name, salary, (salary+salary*commission_pct) AS monthly_sal
FROM employees; --null�� ������ ����� ����� �� ��

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



--�Ϲ��Լ� COALESCE

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

--VNL2�� CASE-WHEN-THEN ���� ��ü
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

--Java switch, ���輺�� -> 99~90 / 9, 89~80 / 8

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

