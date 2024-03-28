-- 모든 도서의 이름과 가격을 검색하시오 
-- ctrl + shift + U  : 대문자 변환
-- ctrl + shift + L  : 소문자 변환

SELECT bookname, price
  FROM Book 

-- 모든 도서의 가격과 이름을 검색하시오 
SELECT price, bookname
  FROM Book 

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
SELECT * 
  FROM Book

SELECT bookid, bookname, publisher, price
  FROM Book
-- 실무에서 쓰는건 아래와 같이 쓰는 것!

-- 도서에서 출판사를 검색하시오(중복제거)
SELECT DISTINCT publisher
  FROM Book

-- 조건검색(조건 연산자 사용) 
-- 가격이 20,000원 미만인 도서를 검색하시오
SELECT *
  FROM Book
  WHERE price < 20000

-- 가격이 10,000원 이상 20,000원 이하인 도서를 검색하시오
SELECT *
  FROM Book
  WHERE price >= 10000 AND price <= 20000

SELECT *
  FROM Book
  WHERE price BETWEEN 10000 AND 20000 -- 미만이나 초과는 나타내기 어려움

-- 조건검색 (집합)
-- 출판사가 '굿스포츠' 또는 '대한미디어'인 도서를 검색하시오
SELECT * 
  FROM Book 
  WHERE publisher IN ('굿스포츠' , '대한미디어')

-- 출판사가 '굿스포츠' 또는 '대한미디어'가 아닌 도서를 검색하시오
SELECT * 
  FROM Book 
  WHERE publisher NOT IN ('굿스포츠' , '대한미디어')

-- 조건검색 (패턴비교 - LIKE 사용)
-- '축구의 역사'를 출판한 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book 
  WHERE bookname = '축구의 역사'

-- 도서이름에 축구가 포함된 출판사를 검색하시오 
SELECT bookname, publisher
  FROM Book 
  WHERE bookname LIKE '축구%' -- '축구'라는 글자로 시작 

SELECT bookname, publisher
  FROM Book 
  WHERE bookname LIKE '%축구%' -- '축구'라는 글자가 포함된 

--------------------------
SELECT bookname, publisher
  FROM Book 
  WHERE bookname LIKE '_구%' -- 무슨 글자든 한글자가 들어간
  -- 와일드문자 _(밑줄기호)특정 위치에 한문자만 대신할때 사용 