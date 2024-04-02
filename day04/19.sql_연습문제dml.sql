-- 3-1
SELECT DISTINCT custid
    FROM Orders
    WHERE bookid IN (SELECT bookid
    FROM Book
    WHERE publisher IN (SELECT b.publisher
    FROM Customer AS c, Orders AS o, Book AS b
    WHERE c.custid = o.custid
    AND o.bookid = b.bookid
    AND c.[name] = '박지성'))

--3-3
SELECT b.custid
     , CONVERT(float,b.custCount) / b.totalCount AS '구매율'
    FROM (SELECT custid
               , COUNT(custid) AS custCount
               , (SELECT COUNT(custid) FROM Orders) AS totalCount
            FROM Orders
            GROUP BY custid) AS b
    WHERE CONVERT(float, b.custCount)/ b.totalCount>=0.3

-- 4-1
INSERT INTO Book (bookid,bookname,publisher,price)
    VALUES (14,'스포츠 세계','대한미디어',10000)
    
-- 4-2
DELETE FROM Book
    WHERE publisher = '삼성당'

-- 4-3
DELETE FROM Orders
    WHERE bookid = 7 AND bookid = 8
DELETE FROM Book
    WHERE publisher = '이상미디어'

-- 4-4
UPDATE Book
    SET publisher = '대한출판사'
    WHERE bookid IN (SELECT bookid
    FROM Book  where publisher = '대한미디어')
    
