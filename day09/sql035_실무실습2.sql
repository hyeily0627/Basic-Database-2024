-- p. 555 

/* 
5. 현재의 날짜 타입을 날짜 함수를 통해 확인하고, 
2006년 5월 20일 부터 2007년 5월 20일 사이에 고용된 사원의 이름(FIRST_NAME + ' ' + LAST_NAME)
, 사원번호, 고용일자를 출력하는데 단, 입사일이 빠른 순으로 정렬하시오(18개 행)
*/
SELECT FIRST_NAME + ' ' + LAST_NAME AS NAME
      ,EMPLOYEE_ID
      ,HIRE_DATE
  FROM employees
 WHERE HIRE_DATE BETWEEN '2006-05-20' AND '2007-05-20'
 ORDER BY HIRE_DATE ASC

/*
6. 급여와 수당율에 대한 지출 보고서를 작성하시오.
수당을 받는 모든 사원의 이름, 급여, 업무 ,수당율을 입력(35개 행)
급여가 큰 순으로 정렬하시오.
*/
SELECT FIRST_NAME + ' ' + LAST_NAME AS NAME
      ,SALARY
      ,JOB_ID
      ,COMMISSION_PCT
  FROM employees
 WHERE COMMISSION_PCT IS NOT NULL
 ORDER BY SALARY DESC, COMMISSION_PCT DESC 

-- p. 557
/*
✅단일행 함수, 변환함수 
60번 IT부서에서 신규 프로그램을 개발하고 성과를 거둬 사원 급여를 12.3% 인상하기로 했다.
정수만 반올림 하여 보고서를 작성하라.
보고서 항목은 사번, 이름, 급여, 인상된 급여(Increased Salary) 
*/
SELECT EMPLOYEE_ID
      ,FIRST_NAME + ' ' + LAST_NAME AS NAME
      ,SALARY
      ,CONVERT (INT, ROUND(SALARY + (SALARY *0.123),0)) AS 'Increased Salary'  -- 또는 ROUND(SALARY * 1.123,0)
       -- CONVERT (INT ~ 로 변환해줘야 정수 가능하네! 
  FROM employees
 WHERE DEPARTMENT_ID = 60


/*
7. 성이 S로 끝나는 사원의 이름과 업무를 아래와 같이 출력하라(18개 행)
   Michael Rogers is ST_CLERK 
*/
SELECT FIRST_NAME + ' ' + LAST_NAME + 'is a ' + JOB_ID AS 'employees Jobs'
  FROM employees
 WHERE LAST_NAME LIKE '%s'

/*
8. 이름, 급여, 수당 여부에 따른 연봉을 포함하여 출력하라
SALARY + COMMISSION / SALARY ONLY, 연봉이 높은 순 (107개행)
*/
SELECT FIRST_NAME + ' ' + LAST_NAME AS [NAME]
     , SALARY
     , SALARY *12 AS 'year salary'
    FROM employees
    ORDER BY [year salary] desc

-- 이거 pass 

/*
9. 이름, 입사일, 입사일의 요일을 출력하라
조건) 일요일부터 토요일 순으로 정렬 (107개행) 
*/
SELECT FIRST_NAME + ' ' + LAST_NAME AS NAME
      ,HIRE_DATE
      ,DATENAME(WEEKDAY,DATEPART(DW,HIRE_DATE)) AS 'Day of the week'
  FROM employees
 ORDER BY DATEPART(DW,HIRE_DATE)

 -- ✅집계함수 : SUM, COUNT, AVG, MAX, MIN...
/* 
11. 사원들의 업무별 전체 급여 평균이 $10,000 보다 큰 경우를 조회하고,업무, 급여평균을 출력하시오,
단, 사원(CLERK)이 포함된 경우는 제외하고, 전체급여가 높은 순으로 정렬하시오 -> 내림차순 
(7행)
*/
SELECT JOB_ID
      ,'$' + FORMAT(AVG(SALARY), '#,#') AS 급여평균
  FROM employees
 GROUP BY JOB_ID
 HAVING AVG(SALARY) > 10000
 ORDER BY AVG(SALARY) DESC  -- 또는 ORDER BY 2 DESC 
 
-- ✅JOIN 
/*
12. employees, Department 조인하기 
사원수가 5명 이상인 부서의 부서명과 사원수를 출력하세요 
*/
SELECT d.department_name
      ,COUNT(*) AS '사원수'
  FROM employees AS e, departments AS d 
 WHERE e.DEPARTMENT_ID = d.department_id
GROUP BY d.department_name
HAVING COUNT(*) >= 5
ORDER BY COUNT(*) DESC

-- ✅서브쿼리
/*
사원의 급여정보 중 업무별 최소 급여를 받는 사원의 이름, 업무 ,급여, 입사일을 출력하시오(21개 행)
*/
SELECT e.FIRST_NAME + ' ' + e.LAST_NAME AS NAME
      ,e.JOB_ID
      ,e.SALARY
      ,e.HIRE_DATE
  FROM employees AS e 
 WHERE e.SALARY <= (SELECT MIN(SALARY)
                      FROM employees
                     WHERE JOB_ID = e.JOB_ID
                  GROUP BY JOB_ID)

-- ✅CASE 연산자(프로그래밍적임)
/*
107명의 직원 중 HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
*/
SELECT EMPLOYEE_ID
      ,FIRST_NAME + ' ' + LAST_NAME AS NAME
      ,JOB_ID
      ,SALARY
      ,CASE JOB_ID WHEN 'HR_REP' THEN SALARY*1.1
                   WHEN 'MK_REP' THEN SALARY*1.2
                   WHEN 'PR_REP' THEN SALARY*1.5
                   WHEN 'SA_REP' THEN SALARY*1.8
                   WHEN ' IT_PROG' THEN SALARY*2.0
       ELSE SALARY END AS 'New Salary'
  FROM employees

-- ✅ROLLUP,CUBE : GROUP BY 제일 마지막에 WITH ROLLUP 쓰기! 
/*
부서과 업무별 급여 합계를 구하여 신년급여수준레벨을 지정하고자 한다.
부서번호, 업무를 기준으로 그룹별로 나누고, 급여합계와 인원수를 추가 
*/

SELECT DEPARTMENT_ID
      ,JOB_ID
      ,COUNT(EMPLOYEE_ID) AS 'count EMPs'
      ,'$' + FORMAT(SUM(SALARY), '#,#') AS 'salary SUM'
  FROM employees
 GROUP BY DEPARTMENT_ID, JOB_ID
 ORDER BY DEPARTMENT_ID

SELECT DEPARTMENT_ID
      ,JOB_ID
      ,COUNT(EMPLOYEE_ID) AS 'count EMPs'
      ,'$' + FORMAT(SUM(SALARY), '#,#') AS 'salary SUM'
  FROM employees
 GROUP BY DEPARTMENT_ID, JOB_ID WITH ROLLUP
-- ROLLUP 합계를 보여주는 강력한 구문 

SELECT DEPARTMENT_ID
      ,ISNULL(JOB_ID, '--합계--') AS JOB_ID
      ,COUNT(EMPLOYEE_ID) AS 'count EMPs'
      ,'$' + FORMAT(SUM(SALARY), '#,#') AS 'salary SUM'
  FROM employees
 GROUP BY DEPARTMENT_ID, JOB_ID WITH ROLLUP
-----------------------------------------------------------------
SELECT DEPARTMENT_ID
      ,JOB_ID
      ,COUNT(EMPLOYEE_ID) AS 'count EMPs'
      ,'$' + FORMAT(SUM(SALARY), '#,#') AS 'salary SUM'
  FROM employees
 GROUP BY DEPARTMENT_ID, JOB_ID WITH CUBE
-- 실무에서는 ROLLUP을 많이 쓰고 CUBE는 사용빈도가 낮음


-- ✅RANK, ROW_NUMBER, FIRST_VALUE
/*
사원들의 부서별 급여 기준으로 내림차순으로 정렬, 순위를 표시하시오(107개 행)
*/
SELECT EMPLOYEE_ID
      ,LAST_NAME
      ,SALARY
      ,DEPARTMENT_ID
      ,RANK() OVER (ORDER BY SALARY DESC) AS RANK
 FROM employees
 ORDER BY SALARY DESC
 -- RANK : 중복 등수 표시(7등, 7등 -> 9등 )

 SELECT EMPLOYEE_ID
      ,LAST_NAME
      ,SALARY
      ,DEPARTMENT_ID
      ,DENSE_RANK() OVER (ORDER BY SALARY DESC) AS RANK
 FROM employees
 ORDER BY SALARY DESC
 -- DENSE_RANK: 중복 등수 표시하나, 순차 증가(7등, 7등-> 8등 -> 9등, 9등 -> 10등)

SELECT ROW_NUMBER() OVER(ORDER BY EMPLOYEE_ID ASC)
       ,*
  FROM employees
-- ROW_NUMBER : 각 행의 번호를 가져오는 함수