-- 집계함수과 GROUP BY 검색
-- 고객이 주문한 도서의 총판매액을 구하시오 
SELECT SUM(saleprice)
  FROM Orders

SELECT SUM(saleprice) AS 총매출
  FROM Orders
/*SUM(saleprice)는 저장된 데이터를 가공하여 얻은 새로운 열이기때문에
결과테이블에 별도의 이름없이 출력됨.
이를 의미있는 열 이름 부여를 위해서는 속성이름의 별칭을 지정하는
AS 키워드를 사용하여 열이름을 부여 한다. 
*/
SELECT SUM(saleprice) AS "총 매출"
  FROM Orders
-- 별칭 중간에 공백이 필요한 경우 큰따옴표, 대괄호를 사용한다.

-- 김연아 고객이 주문한 도서의 총 판매액을 구하시오
SELECT *
  FROM Customer
-- 김연아는 custid가 2번임을 확인
SELECT SUM(saleprice) AS [김연아 고객 총판매액]
  FROM Orders
  WHERE custid = 2

-- COUNT()는 *을 사용할 수 있음. 
-- 나머지 집계함수는 열(컬럼)하나만 지정해서 사용할 것 
SELECT COUNT(saleprice) AS [주문갯수]
	  ,SUM(saleprice) AS [총 판매액]
	  ,AVG(saleprice) AS [판매액 평균]
	  ,MIN(saleprice) AS [주문도서 최소금액]
	  ,MAX(saleprice) AS [주문도서 최대금액]
  FROM Orders

-- 출판사 중복제거 개수
SELECT COUNT(DISTINCT publisher)
  FROM Book

-- GROUP BY 필요조건으로 그룹핑 하여 결과를 내거나 통계를 산출 
-- GROUP BY절에 들어있는 컬럼 외에는 SELECT문에 절대(!) 쓸 수 없음.
-- 단, saleprice는 집계함수안에 들어있으므로 예외이다. 
/*
SELECT *
  FROM Orders
  GROUP BY custid
집계 함수나 GROUP BY 절에 없으므로 SELECT 목록에서 사용할 수 없습니다. 라는 에러뜸 
*/

SELECT custid, SUM(saleprice) AS [판매액]
  FROM Orders
  GROUP BY custid

-- HAVING - WHERE절은 일반 필터링 조건 
-- HAVING은 통계, 집합함수의 필터링 조건
-- 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량을 구하시오
-- 단, 2권이상 구매한 고객만 구하기 
SELECT custid, count(*) AS 도서수량
  FROM Orders
  WHERE saleprice >= 8000
  GROUP BY custid
  HAVING count(*) >=2