CREATE TABLE NewBook
( 
	bookid               integer  NOT NULL ,
	bookname             nvarchar(40)  NOT NULL ,
	price                integer  NULL ,
	pubname_FK_          nvarchar(40)  NOT NULL ,
	pubdate              datetime  NOT NULL 
)
go



ALTER TABLE NewBook
	ADD CONSTRAINT XPK도서 PRIMARY KEY  CLUSTERED (bookid ASC)
go



CREATE TABLE NewCustomer
( 
	custid               integer  NOT NULL ,
	address              nvarchar(140)  NOT NULL ,
	name                 nvarchar(40)  NOT NULL ,
	phone                nvarchar(20)  NULL 
)
go



ALTER TABLE NewCustomer
	ADD CONSTRAINT XPK고객 PRIMARY KEY  CLUSTERED (custid ASC)
go



CREATE TABLE NewOrder
( 
	bookid               integer  NOT NULL ,
	custid               integer  NOT NULL ,
	oderdate             datetime  NOT NULL ,
	saleprice            integer  NOT NULL ,
	orderid              integer  NOT NULL 
)
go



ALTER TABLE NewOrder
	ADD CONSTRAINT XPK주문 PRIMARY KEY  CLUSTERED (orderid ASC)
go



CREATE TABLE NewPublisher
( 
	pubname              nvarchar(40)  NOT NULL ,
	stname               nvarchar(50)  NOT NULL ,
	officephone          varchar(20)  NULL 
)
go



ALTER TABLE NewPublisher
	ADD CONSTRAINT XPK출판사 PRIMARY KEY  CLUSTERED (pubname ASC)
go




ALTER TABLE NewBook
	ADD CONSTRAINT R_5 FOREIGN KEY (pubname_FK_) REFERENCES NewPublisher(pubname)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE NewOrder
	ADD CONSTRAINT R_6 FOREIGN KEY (bookid) REFERENCES NewBook(bookid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE NewOrder
	ADD CONSTRAINT R_8 FOREIGN KEY (custid) REFERENCES NewCustomer(custid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




