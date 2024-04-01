-- 책 가격이 가장 비싼 것
SELECT MAX(price)
  FROM Book

-- 35,000원인 책을 찾아보기 
SELECT *
  FROM Book
  WHERE price = 35000

-- >> 이렇게 두번 찾는건 정말 비효율적❗
-- >> 한번에 실행하는 방법은? = 서브쿼리  
SELECT *
  FROM Book 
  WHERE price = (SELECT MAX (price)
                   FROM Book)

-- 도서를 구매한 적이 있는 고객이름 검색
-- 서브쿼리로 구현 (SELECT, FROM, WHERE절 )
/*
SELECT *
  FROM Customer
WHERE custid = (SELECT DISTINCT custid 
                  FROM Orders)
불가능 (= 으로 동일할 수 없음)                  
*/ 
SELECT name AS 고객이름
  FROM Customer
WHERE custid IN (SELECT DISTINCT custid 
                  FROM Orders)                 
-- 조인으로 구현
SELECT DISTINCT c.name AS 고객이름
  FROM Customer AS c, Orders AS o
WHERE c.custid = o.custid

-- 구매한 적이 없는 고객 외부조인
SELECT DISTINCT c.name AS 고객이름
  FROM Customer AS c LEFT OUTER JOIN Orders AS o 
    ON c.custid = o.custid
WHERE o.orderid IS NULL

-- 서브쿼리를 FROM절에 
-- SELECT로 만들 실행결과(가상의 테이블)를 마치 DB에 있는 테이블처럼 사용가능하다. 
SELECT t.*
  FROM (
        SELECT b.bookid
            ,b.bookname
            ,b.publisher
            ,b.price
            ,o.orderdate
            ,o.orderid
        FROM Book AS b, Orders AS o 
        WHERE b.bookid = o.bookid
        ) AS t

-- 서브쿼리 SELECT절
-- 무조건 1건에 1컬럼만 연결
-- 조인으로도 가능하다. (해당 방법은 조인보다 성능에서 취약하다.)
SELECT o.orderid
      ,o.custid
      ,o.bookid
      ,(SELECT bookname FROM Book WHERE bookid = o.bookid) 
      ,o.saleprice
      ,o.orderdate
  FROM Orders AS o;

SELECT o.orderid
      ,o.custid
      ,(SELECT name FROM Customer WHERE custid = o.custid) AS '고객명'
      ,o.bookid
      ,(SELECT bookname FROM Book WHERE bookid = o.bookid) AS '도서명'
      ,o.saleprice
      ,o.orderdate
  FROM Orders AS o;

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 조회 
SELECT name AS 고객명
FROM Customer
WHERE custid IN (SELECT custid
                 FROM Orders 
                 WHERE bookid IN (SELECT bookid 
                                  FROM Book
                                  WHERE publisher = '대한미디어'))

-- 계산결과를 서브쿼리로 사용
SELECT b1.*
  FROM Book b1
WHERE b1.price > ( SELECT AVG(b2.price)
                   FROM Book AS b2
                   WHERE b2.publisher = b1.publisher)

-- 각 출판사별 평균가격 
SELECT AVG(b2.price), b2.publisher
  FROM Book b2
  GROUP BY b2.publisher