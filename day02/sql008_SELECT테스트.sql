-- 연습문제 풀이 

-- 1. 마당서점의 고객이 요구하는 다음질문에 대해 SQL문을 작성하시오.
-- 1) 도서번호가 1인 도서의 이름
SELECT *
  FROM Book 
  WHERE Bookid = 1

-- 2)가격이 20,000원 이상인 도서의 이름 
SELECT *
  FROM Book 
  WHERE price >= 20000

-------------------------------------------------------------------------------

-- 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL문을 작성하시오
-- 1) 마당서점 도서의 총 갯수 
SELECT COUNT(*) AS [도서 총 개수]
  FROM Book

-- 2) 마당서점에 도서를 출고하는 출판사의 총 개수 
SELECT COUNT(DISTINCT publisher) AS [출판사 개수(중복제외)]
  FROM Book

-- 3) 모든 고객의 이름, 주소 
SELECT name, address
  FROM Customer

-- 4) 2014년 7월 4일~ 7월 7일사이에 주문 받은 도서의 주문번호
SELECT orderid
  FROM Orders
  WHERE orderdate BETWEEN '2021-07-04' AND '2021-07-07'

SELECT orderid
  FROM Orders
  WHERE orderdate >= '2021-07-04' AND orderdate <= '2021-07-07'

-- 5) 2014년 7월 4일~ 7월 7일사이에 주문 받은 도서를 제외한 도서의 주문번호
SELECT *
  FROM Orders
  WHERE orderdate NOT BETWEEN '2021-07-04' AND '2021-07-07'

-- 6) 성이 '김'씨인 고객의 이름과 주소
SELECT name, address
  FROM Customer
  WHERE name LIKE '김%'

-- 7) 성이 '김'씨 이고, '아'로 끝나는 고객의 이름과 주소  
SELECT name, address
  FROM Customer
  WHERE name LIKE '김_아%'

SELECT name, address
  FROM Customer
  WHERE name LIKE '김%아'
-- 이렇게 하면 김마리아 같은 이름도 같이 검색