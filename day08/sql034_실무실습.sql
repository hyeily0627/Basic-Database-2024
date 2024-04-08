-- HR 데이터베이스 연습

-- Sample Q. 사원번호 테이블 사번, 이름, 급여, 입사일, 상사의 사원번호를 출력하시오(107개 행)
SELECT EMPLOYEE_ID
      ,FIRST_NAME + ' ' + LAST_NAME AS NAME
      ,SALARY
      ,HIRE_DATE
      ,MANAGER_ID 
  FROM employees

/* 
1. 사원정보에서 사원의 성과 이름을 NAME으로, 업무는 JOB, 급여는 SALARY, 
연봉에 100$ 보너스를 추가계산한 연봉은 Increased Ann Salary, 
월급에 100$ 보너스를 추가해서 Increased Salary의 별칭으로 출력하시오. 
*/
SELECT FIRST_NAME + ' ' + LAST_NAME AS NAME 
      ,JOB_ID AS JOB
      ,SALARY
      ,(SALARY * 12) + 100 AS Increased Ann Salary  
      (SALARY +100) SALARY * 12 AS  Increased Salary
  FROM employees


/* 
2. 사원정보에서 모든 사원의 Last name에 LAST NAME에 Last name : 
1 year Salary = 연봉 컬럼에 1Year Salary 별칭을 붙이시오 
*/
SELECT LAST_NAME + ': 1Year SALARY = $' + CONVERT(VARCHAR, SALARY * 12) AS 1Year SALARY
      ,SALARY * 12
  FROM employees 

-- 3. 부서별 담당하는 업무를 한번씩 출력하시오 (20개 행)
SELECT DISTINCT DEPARTMENT_ID
              , JOB_ID
           FROM employees

-- WHERE, ORDER BY 
/* 샘플문제 : HR부서에서 예산 문제로 급여정보 보고서를 작성 
사원정보에서 급여자 7,000~10,000 이외 사람의 성과 이름을 
급여자 작은 숙으로 출력하시오(75개)
*/
SELECT FIRST_NAME + ' ' + LAST_NAME AS NAME 
      ,SALARY 
  FROM employees
WHERE SALARY NOT BETWEEN 7000 AND 10000
ORDER BY SALARY ASC 

-- 4. lastname에서 e 와 0가 포함된 사원을 출력 
SELECT LAST_NAME AS ' e and o NAME'
  FROM employees
WHERE LAST_NAME LIKE '%e%' AND LAST_NAME LIKE '%o%'

/* 
5. 현재의 날짜 타입을 날짜 함수를 통해 확인하고, 
2006년 5월 20일 부터 2007년 5월 20일 사이에 고용된 사원의 이름(FIRST_NAME + ' ' + LAST_NAME)
, 사원번호, 고용일자를 출력하는데 단, 입사일이 빠른 순으로 정렬하시오(18개 행)
*/
SELECT GETDATE()