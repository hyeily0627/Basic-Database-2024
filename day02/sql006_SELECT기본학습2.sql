-- 조회 복합 조건
-- 축구에 관한 도서중, 가격이 20,000원 이상인 도서를 검색하시오
SELECT bookid
	 , bookname
	 , publisher
	 , price
-- 줄 나눠서 쓰는 이유는 필요없어졌을때 쉽게 지우기 위해서
  FROM Book 
 WHERE bookname LIKE '%축구%' 
   AND price >=20000

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서 검색 
SELECT * 
  FROM Book 
 WHERE publisher ='굿스포츠' 
	   OR publisher = '대한미디어'

-- 도서를 이름순으로 검색하시오 
SELECT *
  FROM Book 
  ORDER BY bookname;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
SELECT *
  FROM Book
  ORDER BY price, bookname

-- 최근에 등록된 도서부터 검색하시오
SELECT *
  FROM Book
  ORDER BY bookid DESC