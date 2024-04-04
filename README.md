# Basic-Database-2024
부경대학교 2024 IoT 개발자 과정 - SQLServer 학습 리포지토리

## 1일차 
- MS SQL Server 설치 : https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 - 개발자 버젼
        - ** ISO 다운로드 후 설치 추천
        - 다운로드 폴더 - 파일 선택 - 오른쪽 마우스 - 탑재 - setup.exe 클릭(설치센터)
        - 설치센터 - 메뉴:설치 - 새 SQL Server 독립실행형 또는~ 설치 
        - Developer / 표준 / -> Azure확장 체크해제 
        - 기능선택 : 데이터베이스 엔진 서비스,  SQL Server복제 , 검색을 위한 전체 텍스트~, intergration Services 
        - 인스턴스 구성: 이름 굳이 바꿀 필요없으나, 여러 서버 사용시에는 지정 이름이 필요
        - 서버구성 : 손댈거 없음 / *데이터 정렬에 엔진 보면 CI 는 대소문자 구분안함
        - 데이터베이스 엔진 구성 (혼합모드로 선택!)
            - WINDOWS인증모드 : 외부에서 접근 불가 
            - 혼합모드(sa) : sa에 대한 암호를 지정(8자이상, 대소문자구분, 특수문자 포함) / 현재 mssql_p@ss 으로 설정함 - 현재 사용자 추가 
            - 데이터루트 디렉토리는 변경 - C: Datas 폴더 생성 후 설정 
        - 설치 준비 - 설치 클릭 
    - 개발툴 설치 
        - SSMS(Sql Server Management Studio) : https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16 - 사용가능한 언어에서 '한국어' 설치 - 다운로드 후 바로 설치하기! 
        : DB에 접근, 여러 개발 작업 
        
        -SSMS 로그인 화면

        ![SSMS로그인](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS.png)

        - SSMS 메인화면
        ![SSMS로그인](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS3.png)

 - SQL 기본 학습
    - SSMS 실행        
        - 도구 - 옵션 - 글자체 및 크기 설정 
        -> 모든 언어 - 줄번호 체크 
        -> 디자이너 - 테이블 다시 만들어야하는 변경내용 저장 안 함 체크해제 - NULL 기본키 경고 체크 
        -> SQL Server 개체탐색기 - 테이블 및 뷰 옵션 - 명령의 값 2개 다 0으로 바꾸기 

        - 새쿼리로 생성하여 콘솔 열기(ctrl + n) 
        - utf - 8 
        - F5로 실행

        ![SSMS생성예시](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS1.png)

        - (주석관련) -- , /* */  사용가능
        - equal 연산자 == 사용하지 않고 = 사용
        - "" 사용하지 않고 '' 사용
        - ; 는 필수가 아니나, 중요한 사항에서는 사용할 것
        - 데이터베이스에서 all 은 * 이다!!(모든 컬럼을 읽어오다) 
        - ctrl + shift + U  : 대문자 변환
        - ctrl + shift + L  : 소문자 변환
            => 스크롤 해서 사용인가봄 
        - ctrl + h 검색해서 바꾸기 

        - 인코딩 관련 
            - 도구 - 텍스트편집기 - 파일 확장명 - 아래 사진 같이 설정 - ctrl+n 안내창 뜸  
            ![SSMS인코딩](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS2.png)

- SSMS 특이사항(sql002.sql 파일참조)
: SSMS 쿼리창에서 소스코드 작성시 빨간색 오류 밑줄이 가끔 표현됨(전부 오휴는 아님!)
-------------------------------------------------------------------------------------------------------------

- 데이터베이스 개념
1. 데이터, 정보, 지식  
    - 데이터 : 관찰의 결과로 나타난 정량적 혹은 실제적 값 
    - 정보 : 데이터에 의미 부여
    - 지식 : 사물이나 현상에 대한 이해 
2. 데이터베이스의 활용 : 검색과 변경(삽입,삭제,수정)
3. 데이터베이스 개념 및 특징  
    - 개념: 통합된 데이터 / 저장된 데이터 / 운영데이터 / 공용데이터 
    - 특징: 실시간 접근성 / 계속적인 변화 / 동시공유 /내용에 따른 참조 
4. 데이터베이스 시스템의 구성 
: DBMS < DATABASE < DATA (MODEL) 

-데이터베이스 시스템의 구성 
1. DB 언어 
    - SQL(Structured Query Language) : 구조화된 질의 언어 
        - DDL(Data Definition Lang) - 데이터 정의어 : CREATE, ALTER, DROP (데이터베이스, 테이블, 인덱스 생성 )
        - DML(Data Manipulation Lang) - 데이터 조작어 : SELECT, INSERT, DELETE, UPDATE
        - DCL(Data Control Lang) - 데이터 제어어 : GRANT, REVOKE (보안, 사용자 권한 부여/제거 기능)
        - TCL(Transaction) - 트랜젝션 제어 : COMMIT, ROLLBACK (원래 DCL 의 일부지만, 기능이 특이해서 TCL로 분리)

2. 데이터 모델 
    - 계층 데이터모델(사용x)
    - 네트워트 데이터모델(사용x)
    - 관계 데이터모델(주로사용)
    - 객체 데이터모델
    - 겍체-관계 데이터모델

3. 스키마
- PK(primary key: 기본키) - : 박스에서 줄 위에 위치 

- FK(foreign key: 외래키(외부키)) 

4. DML 학습
    - SQL 명령어 키워드 : SELECT, INSERT, DELETE, UPDATE
    - IT 개발에서 표현하는 언어 : Create, Request, Update, Delete => CRUD로 부름 
      (ex. CRU 개발하라 의 뜻은 Create, Request, Update를 기능을 가진 것을 개발)
    - SELECT문의 기본 문법
        ```sql
        SELECT [ALL|DISTINCT] 속성이름(들) - (All* 전부 | DISTINCT 를 사용하여 중복제거 )
        FROM 테이블이름(들)
        [WHERE 검색조건(들)]
        [HAVING 검색조건(들)]
        [ORDER BY 속성이름(들) [ASC|DESC]]
        ```
   - 중복제거 : DISTINCT
   - 조건 연산자 : < > = 
   - 집합 : (ex) IN ('굿스포츠' , '대한미디어') , NOT IN
   - 패턴비교 - LIKE 사용 : '축구%' -- '축구'라는 글자로 시작 
   - 패턴비교 - 와일드문자 _ 사용 : '_구%' _(밑줄기호)특정 위치에 한문자만 대신할때 사용 

## 2일차
- DataBase 학습
    - DB 개발시 사용할 수 있는 툴 
        - SSMS(기본)
        - Visual Studio : 아무런 설치 없이 개발 가능 
        - Visual Studio Code : 플러그인 설치시 가능(SQL Server(mssql)) 
        - ServerName(hostName) - 내 컴퓨터 이름|내네트워크주소|127.0.0.1(LoopBack IP)|localhost(LoopBack URL) 중에서 선호하는거 아무거나 선택

- 관계 데이터 모델 :데이터를 2차원 테이블 형태인 릴레이션으로 표현하며, 릴레이션에 대한 제약조건과 관계연산을 위한 관계대수를 정의
    1.  릴레이션(relation) : 행과 열로 구성된 테이블 
        : 행(튜플), 열(속성), 스키마, 인스턴스 용어 
        - 릴레이션 특징 
        1) 속성은 단일값을 가진다.
        2) 속성은 다른 이름으로 구성
        3) 속성의 값은 정의된 도메인값만 가짐 (ex 대학교 1~4학년 외에 5학년 있으면 안됨)
        4) 릴레이션 내 중복된 튜플 허용하지 않음
        5) 튜플 순서는 상관 없음  

    ![릴레이션개념](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/re.png)

        - 매핑되는 이름 테이블(실제 DB)
            - 행(레코드), 열(필드,컬럼), 내포(필드명), 외연(데이터)
        - 차수(degree) - 속성의 갯수
        - 카디날리티(cardinality) - 튜플의 수 
    2. 제약조건(constraints)

    3. 관계대수(relational algebra)

-------------------------------------------------------------------------------------------------------------

- DML 학습(*줄 나눠서 쓰는 이유는 필요없어졌을때 쉽게 지우기 위해서!!)
    - 복합조건  
        (ex) WHERE bookname LIKE '%축구%' 
                   AND price >=20000
    - 정렬 : ORDER BY     
        - 기본은 오름차순(ASC 생략) 
        - 내림차순은 ORDER BY price DESC 

    - 집계함수 : SUM, AVG, MIN, MAX, COUNT
        - COUNT()는 *을 사용할 수 있음. 
        - 나머지 집계함수는 열(컬럼)하나만 지정해서 사용할 것 
        - HAVING은 집계함수의 필터 GROUP BY 뒤에 작성

    ```sql
    SELECT SUM(saleprice) AS 총매출
    FROM Orders
    /*
    SUM(saleprice)는 저장된 데이터를 가공하여 얻은 새로운 열이기때문에
    결과테이블에 별도의 이름없이 출력됨.
    이를 의미있는 열 이름 부여를 위해서는 속성이름의 별칭을 지정하는
    AS 키워드를 사용하여 열이름을 부여 한다. 
    */
    SELECT SUM(saleprice) AS "총 매출"
    FROM Orders
    -- 별칭 중간에 공백이 필요한 경우 큰따옴표, 대괄호를 사용한다.
    
    ```
    
    - 🚨GROUP BY 검색 : 필요조건으로 그룹핑 하여 결과를 내거나 통계를 산출
    
    ```sql
    -- 이거 🚨짱짱짱짱짱🚨 중요
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

    ```
    - 2개 이상의 테이블 질의(Query) 163p
        - 관계형 DB에서 가장 중요한 기법 중 하나 = 조인

        [참조] https://sql-joins.leopard.in.ua/ 조인 보여주는 사이트 

        1) Inner Join(내부조인) : 교집합

        ```sql
        -- 주문한 책의 고객이름과 책판매액의 조회
            SELECT Customer.name
                 , Orders.saleprice
            FROM Customer, Orders
            WHERE Customer.custid = Orders.custid
            ORDER BY Customer.custid ASC;
        ``` 
        2) Outer Join(외부조인) : LEFT OUTER JOIN vs RIGHT OUTER JOIN5
        -> 어느 테이블이 기준인지에 따라서 결과가 상이함

        ![조인](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/join.png)

## 3일차 
- Database 학습
    - 관계 데이터 모델
        1. 키   
            1) 슈퍼키 : 튜플을 유일하게 식별할 수 있는 하나의 속성 혹은 속성의 집합
            2) 후보키 : 튜플을 유일하게 식별할 수 있는 속성의 최소 집합 
                - 복합키 : 후보키 중 속성을 2개이상을 집합으로 한 키 
            3) 🚨기본키(PK: primary key) : 여러 후보키 중 하나를 선택하여 대표로 삼는 키
                - 릴레이션 내 튜플을 식별할 수 있는 고유한 값을 가져야함.
                - NULL 값은 허용하지 않는다
                - 키 값의 변동이 일어나지 않아야한다. 
                - 최대한 적은 수의 속성을 가진 것이라야한다.
                - 향후 키를 사용하는데 있어서 문제 발생 소지가 없어야한다. 
                - 유니크 & not null ❗만 기억하자 
            4) 대리키 : 키본키에 보안이 필요하거나 여러 개의 속성으로 구성되어 복잡하거나, 마땅한 기본키가 없을 때는 일련번호 같은 가상의 속성을 만들어 기본키로 부여하는 키 
            5) 대체키 : 기본키로 선정되지 않은 후보키 
            6) 🚨외래키(FK: foriegn key) : 기본키를 참조하여 사용하는 것 
                - 고려사항 : 다른 릴레이션과의 관계, 다른 릴레이션의 기본키를 호칭함
                - 참조하고(외래키) 참조되는(기본키) 양쪽 릴레이션의 도메인은 서로 같아야한다. 
                - 참조되는(기본키) 값이 변경되면 잠조하는(외래키)값도 변경된다.
                - NULL값과 중복값들이 허용된다. 
                - 자기 자신의 기본키를 참조하는 외래키도 가능하다. 
                - 외래키가 기본키의 일부가 될 수 있다. 
        
        2. 무결성 제약조건(84p)
            1) 데이터 무결성(integrity) : 데이터베이스에 저장된 데이터의 일관성과 정확성을 지키는 것   
                - 도메인 무결성 제약조건 : '도메인 제약' 이라고도 하며, 릴레이션 내의 튜플들이 각 속성의 도메인에 지정된 값만을 가져야 한다는 조건
                    - SQL문에서 데이터형식, 널, 기본값, 체크 특성을 지키는 것
                - 개체 무결성 제약조건 : '기본키 제약' 으로도 부름. 릴레이션은 기본키를 지정하고 그에 따른 무결성 원칙, 즉 기본키는 NULL 값을 가져서는 안되며, 릴레이션 내에 오직 하나의 값만 존재해야한다. 
                - 참조 무결성 제약 조건 : '외래키 제약' 으로도 부름. 부모의 키가 아닌 값은 사용할 수 없음(외래키가 바뀔떄 기본키의 값이 아닌 것은 제약을 받는다.)
                    -> 참조 무결성제약조건의 옵션(부모릴레이션에서 튜플 삭제 경우)
                    - RESTRICTED : 자식릴레이션에서 참조하고 있으면 부모 릴레이션의 삭제작업 거부 
                    - CASCADE : 부모가 지워지면, 해당 자식도 같이 삭제
                    - DEFAULT : 부모가 지워지면, 자식은 지정된 기본값으로 변경 
                    - NULL : 부모가 지워지면, 자식의 해당값을 NULL로 변경 
                - 유일성 제약조건 : 일반 속성의 값이 중복되면 안되는 제약 조건. NULL값은 허용함. 

- DML 학습 
    - SELECT문 
        - Outer Join(외부조인) 
            - LEFT : 왼쪽 테이블을 기준으로 조건에 일치하지 않는 왼쪽 테이블 데이터도 모두 표시
            - RIGHT : 오른쪽 테이블 기준으로 조건에 일치하지 않는 오른쪽 테이블 데이터도 모두 표시 
            - FULL(거의사용x) 

        - 부속질의(SubQuery)
            - 쿼리 내에 다시 쿼리를 작성하는 것 
            - 서브쿼리를 쓸 수 있는 장소 
                1) SELECT절 : 한 컬럼에 하나의 값만 
                ```sql
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
                                0
                ```

                2) FROM절 : 가상의 테이블로 사용

                3) WHERE절 : 여러조건에 많이 사용 

        - 집합연산(97p) : join도 집합이지만, 속성별로 가로로 병합하기 때문에 집합이라 부르지 않음. 집합은 데이터를 세로로 합치는 것을 뜻함
            - 합집합(UNION, 진짜 많이 사용) - UNION(중복제거), UNION ALL(중복허용)
            - 차집합(EXCEPT, 거의 사용안함) - 하나의 테이블에서 교집합 값을 뺀 나머지
            - 교집합(INTERSECT, 거의 사용안함) - 두 테이블에 모두 존재하는 값
            - EXISTS - 데이터 자체의 존재여부로

- DDL 학습
    - CREATE : 개체(데이터베이스, 테이블, 뷰, 사용자 등)를 생성하는 구문

    ```sql
    -- 테이블 생성에 한정
    CREATE TABLE 테이블명
    ({ 속성이름 데이터타입
        [NOT NULL]
        [UNIQUE]
        [DEFAULT 기본값]
        [CHECK 체크조건]
    }
        [PRIMARY KEY 속성이름(들)]
        {[FORIEGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
            [ON UPDATE [NO ACTION | CASCADE | SET NULL | SET DEFAULT]]
        }
    );
        
    ```
    - ALTER : 개체를 변경(수정)하는 구문 

     ```sql
    ALTER TABLE 테이블명
    [ADD 속성이름 데이터타입]
    [DROP COLUMN 속성이름]
    [ALTER COLUMN 속성이름 데이터타입]
    [ALTER COLUMN 속성이름 [NULL | NOT NULL]]
    [ADD PRIMARY KEY(속성이름)]
    [[ADD | DROP] 제약조건이름];
    
    ```
    - DROP : 개체를 삭제 하는 구문 
     ```sql
    DROP TABLE 테이블명;

    ```
        - 외래키로 사용되는 기본키가 있으면 외래키를 사용하는 테이블 삭제 후, 기본키의 테이블 삭제해야 함!!

## 4일차 
- 관계 데이터 모델
    - 관계 대수 - 릴레이션에서 원하는 결과를 얻기위한 수학의 대수와 같은 연산 사용 기술하는 언어
    - 셀렉션, 프로젝션, 집합, 조인, 카티션 프로덕트, etc...

- DML 학습(SELECT외)
    - INSERT
      ```sql
      INSERT INTO 테이블이름[(속성리스트)]
      VALUES(값리스트);
      ```
      
    - UPDATE
      ```sql
       -- 트랜잭션을 걸어서 복구 대비
        UPDATE 테이블이름
        SET 속성이름1=값, [속성이름2=값 ....]
        WHERE <검색조건> -- 실무에서 빼지 않는게 좋음
      ```
      
    - DELETE
      ```sql
      -- 트랜잭션을 걸어서 보국 대비
        DELETE FROM 테이블이름
        WHERE <검색조건> -- 실무에서는 빼면 큰일남
      ```
- SQL 고급
    - 내장함수
      - 수학 함수, 문자열 함수, 날짜/시간 함수, 변환 함수, 커서 함수(!), 보안 함수, 시스템 함수 등
      - NULL(🚨)
    - 서브쿼리 리뷰
      - SELECT - 단일행, 단일열 (스칼라 서브쿼리)
      - FROM - 다수행, 다수열
      - WHERE - 다수행, 단일열(보통)
        - 비교연산, 집합연산, 한정연산, 존재연산 가능
    - 뷰
    - 인덱스


## 5일차 
- SQL 고급
    - 서브쿼리 리뷰
       * ~ ALL : 서브쿼리의 모든 결과에 대해 ~하다
       * ~ ANY : 서브쿼리의 하나 이상의 결과에 대해 ~하다

       1) 스칼라 부속질의(SELECT 부속질의)
       2) 인라인뷰(FROM 부속질의)

    - 뷰(233p) : 하나 이상의 테이블을 합하여 만든 가상의 테이블 
      -> 복잡한 쿼리로 생성되는 결과를 자주 사용하기 위해서 만드는 개체 
      -> 조인이나, 유니언도 테이블을 합쳐 만들 수 있는데 뷰가 이를 다 대체 가능하다.
        - 편리하고 보안에 강하며, 논리적 독립성을 띰 
        - 원본데이터가 변경되면 같이 변경되고, 인덱스 생성은 어렵다
        - CUD연산에 제약이 있다
        ```sql
        -- 생성
        CREATE VIEW 뷰이름[(열이름 [, ...])]
        AS <SELECT 쿼리문>
        
        -- 수정
        ALTER VIEW 뷰이름[(열이름 [, ...])]
        AS <SELECT 쿼리문>

        -- 삭제
        DROP VIEW 뷰이름
        ```

    - 인덱스(240p) : 도서의 색인이나 사전과 같이 데이터를 쉽고 빠르게 찾을 수 있도록 만든 데이터 구조 
        ```sql
         -- 생성
        CREATE [UNIQUE] [CLUSTERED|NONCLUSTERED] INDEX 인덱스 이름
        ON 테이블명(속성이름 [ASC|DESC] [, ...n])

        --수정
        ALTER INDEX {인덱스 이름|ALL}
        ON 테이블명 { REBUILD | DISABLE | REORGANIZE }

        -- 삭제
        DROP INDEX 인덱스이름 ON 테이블명;
        ```

        - SQL서버의 인덱스는 B-tree 구조 
        1) 클러스터 인덱스
            - 테이블 생성시 기본키(PK)를 생성하면 자동 생성 
        2) 비클러스터 인덱스 

        - SSMS에서 실행계획을 가지고 쿼리 실행 성능을 체크할 수 있음
            - SSMS - 마당 테이블 - dbo.Book 오른쪽 클릭 / dbo.Mybook 각각  - 모든행선택 - 상단 쿼리 - 예상실행계획표시 
      
- 파이썬 SQL Server 연동 프로그래밍
    - Madang DB 관리 프로그램 
        - PyQT GUI 생성 (파일명 MadangBook.ui)
            - QT deginer 진입 - Main window 선택 - 생성 
            - group box(책정보) / table widget / label(책번호,책제목,출판사,정가) / line Edit / pushbutton(신규등록,저장,삭제,조회)
            - 위 위젯들 이름 설정 해야함! (QT deginer 들어가서 확인해)
        - SQL Server 데이터 핸들링
            - pymssql 라이브러리 설치 

            ```shell
            > pip install pymssql
            ```
            - DB연결 설정  
                1. 윈도우 앱 - SQL server 2022 - 구성관리자 접속 
                2. sql서버 네트워트 구성 -> MSSQL에 대한 프로토콜 
                3. TCP/IP 사용으로 변경(TCP/IP 더블클릭 - TCP/IP속성창 )
                4. TCP/IP속성창 - IP주소탭에서 IP2(본인아이피인 것)랑 IP4(127.1.0.1으로 된 주소 ) 사용을 예로 변경 
                ![설정](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/db001.png)
                5. 적용 후 오른쪽 탭 SQL Server 서비스 > SQL Server(MSSQLServer) 더블클릭 - **다시시작** 버튼 클릭, 재시작 필요


## 6일차 (24.04.04)
- 파이썬 SQL Server 연동 프로그래밍 
    - Madang DB 관리 프로그램 
        - PyQt5 + pymssql

- <문제❗한글 깨짐> 해결방안 
    1. DB 테이블의 varchar(ASCII) -> nvarchar(UTF-8) 변경
    2. 파이썬에서 pymssql로 접속할 때, charset을 'UTF-8'로 설정 
    3. INSERT 쿼리에 한글 입력되는 컬럼은 N'{컬럼이름}'을 붙여줌(N 유니코드로 입력하라는 뜻)

- 실행화면 
픽픽사용 / MP4 FPS 15 / 중간화질
    
https://github.com/hyeily0627/Basic-Database-2024/assets/156732476/84c10c07-ecc2-4e97-b70f-98d4b755e96b


## 7일차 
- SQL 고급 
    - 트랜잭션 

- 데이터베이스 모델링 
