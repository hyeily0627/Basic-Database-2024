-- 전체 고객 중 도서를 구매하지 않는 고객의 이름을 조회 
SELECT name 
  FROM Customer
EXCEPT
SELECT name 
  FROM Customer
WHERE custid IN (SELECT DISTINCT custid FROM Orders)

-- 합칩합 중복을 허용안함 
SELECT name 
  FROM Customer
  UNION 
SELECT ALL 
  FROM Customer 
WHERE custid IN(SELECT DISTINCT custid FROM Orders)

-- 합집합 중 중복을 허용함
SELECT name 
  FROM Customer
  UNION ALL 
SELECT ALL 
  FROM Customer 
WHERE custid IN(SELECT DISTINCT custid FROM Orders)




-- EXIST : 하나의 테이블에 존재하는 값만 보고싶다
SELECT name
      ,address 
 FROM Customer AS c 
WHERE EXISTS (SELECT *
               FROM Orders AS o 
               WHERE o.custid = c.custid)