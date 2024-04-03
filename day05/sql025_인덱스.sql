-- 인덱스(책의 목차와 기능이 동일)
-- Book의 bookname 열에 NONCLUSTERED 인덱스 IX_Book_bookname을 생성 하시오 

CREATE INDEX IX_Book_bookname ON Book(bookname)

-- Customer의 name 열에 클러스터링 인덱스 CIX_Customer_name
-- 보통 기본키에 CLUSTERED, 나머지 컬럼에 NONCLUSTERED 인덱스 설정 
-- 아래는 위 같이 안함
CREATE CLUSTERED INDEX CIX_Customer_name ON Customer(name)

-- Book에 publisher 와 price 동시에 인덱스 IX_Book_pubprice 인덱스 생성 
CREATE INDEX IX_Book_pubprice ON Book(publisher,price)

-- 인덱스 재구성
-- PK인 기본키는 값이 추가되면 자동으로 인덱스를 재구성함
-- NONCLUSTERED 인덱스는 재구성이 필요할 수 있다. (DBA 정기적으로 작업...)
-- IX_Book_pubprice를 재구성하라 
ALTER INDEX IX_Book_pubprice ON Book REBUILD 
ALTER INDEX IX_Book_pubprice ON Book REORGANIZE -- 인덱스 재정리

-- 인덱스 삭제
DROP INDEX IX_Book_bookname ON Book 
DROP INDEX CIX_Customer_name ON Customer
