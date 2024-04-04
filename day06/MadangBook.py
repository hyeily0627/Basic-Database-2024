# 파이썬 DB 연동 프로그램

import sys
from PyQt5 import uic
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
import webbrowser
from PyQt5.QtWidgets import QWidget

## MSSQL 연동할 라이브러리(모듈)
import pymssql

## 전역변수 설정
serverName = '127.0.0.1'
userId = 'sa'
userPass = 'mssql_p@ss'
dbName = 'Madang'
dbCharset = 'UTF-8' ## EUC-KR 설정하면 에러! 
# 저장버튼 클릭 시, 삽입/수정을 구분짓기 위한 구분자
mode = 'I'

## 화면 불러오기
class qtAPP(QMainWindow):
    def __init__(self) -> None:
        super().__init__()
        uic.loadUi('./day06/MadangBook.ui', self) ## 나한테 ui를 던져줘
        self.initUI()

    def initUI(self) -> None:
        # 입력제한
        self.txtBookid.setValidator(QIntValidator(self)) # 숫자만 입력되도록 제한
        self.txtPrice.setValidator(QIntValidator(self))
        
        # Button 4개에 대해서 사용등록
        self.btnNew.clicked.connect(self.btnNewClicked) ## 신규버튼 시그널(이벤트)에 대한 슬롯함수(26행) 생성
        self.btnSave.clicked.connect(self.btnSaveClicked) ## 저장버튼
        self.btnDel.clicked.connect(self.btnDelClicked) ## 삭제버튼
        self.btnReload.clicked.connect(self.btnReloadClicked) ## 조회버튼
        self.tblBooks.itemSelectionChanged.connect(self.tblBooksSelected) ## 테이블위젯 결과를 클릭 시 발생
        self.show()

        self.btnReloadClicked() 

    def btnNewClicked(self): # 신규버튼 클릭
        global mode ## 전역변수 사용
        mode = 'I'
        
        ## 입력 창(QLineEdit) 초기화
        self.txtBookid.setText('')
        self.txtBookname.setText('')
        self.txtPublisher.setText('')
        self.txtPrice.setText('')
        #선택한 데이터에서 신규를 누르면 self.txtBookid 사용여부는 변경해줘야함
        self.txtBookid.setEnabled(True) # 사용허용
    
    def btnSaveClicked(self): # 저장버튼 클릭
        # 입력검증(Validation Check) 필수
        ## 1. 텍스트박스를 비워두고 저장버튼을 누르는것 막기
        bookid = self.txtBookid.text()
        bookName = self.txtBookname.text()
        publisher = self.txtPublisher.text()
        price = self.txtPrice.text()
        #print(bookid, bookName, publisher, price)
        
        warningMsg = '' # 경고메세지
        isValid = True # 빈 값이 있으면 False로 변경

        if bookid == None or bookid == '':
            warningMsg = '책 번호가 없습니다.\n'
            isValid = False
        if bookName == None or bookName == '':
            warningMsg += '책 제목이 없습니다.\n'
            isValid = False
        if publisher == None or publisher == '':
            warningMsg += '출판사가 없습니다.\n'
            isValid = False
        if price == None or price == '':
            warningMsg += '정가가 없습니다.\n'
            isValid = False
        
        if isValid == False: # 위 입력값 중에 하나라도 빈값이 존재
            QMessageBox.warning(self, '저장경고', warningMsg)
            return # 함수 탈출 

        ## QlingEdig(=txtbox)는 NONE이 아닌 Empty('')상태!


        ## mode='I' 일때는 중복번호를 체크해야하지만, mode='U'는 체크해서 막으면 수정자체가 안된다. 
        if mode == 'I':
        ## 2. 현재 존재하는 번호와 같은 번호를 사용했는지 체크, 이미 있는 번호면 DB입력 쿼리 실행이 안되도록 막아야 함
        ## txtBookid의 QLineEdit에 입력된 data가 Book 테이블에 이미 있는 번호면 COINT => 1, 없으면 카운트 안되니까 0
            conn = pymssql.connect(server=serverName, user=userId, password=userPass, database=dbName, charset=dbCharset)
            cursor = conn.cursor(as_dict=False)# COUNT(*)은 데이터가 딱 1개이기때문에 as_dict=False 

            query = f'''SELECT COUNT(*)
                        FROM Book
                        WHERE bookid = {bookid}'''
            cursor.execute(query)
        
        # 데이터 하나 => cursor.fetchone()함수로 튜플(1, )을 가져옴
            valid = cursor.fetchone()[0] ## 튜플의 첫번째 값만
            conn.close()

            if valid == 1: # DB Book테이블에 같은 번호 이미 존재
                QMessageBox.warning(self, '저장경고', '이미 같은 번호의 데이터가 존재합니다.\n번호를 변경하세요.')
                return 
        
        ## 3. 입력검증 후 DB Book 테이블에 삽입
        ## bookid, bookName, publisher, price
        if mode == 'I':
            query = f'''INSERT INTO Book
                        VALUES ({bookid}, N'{bookName}', N'{publisher}', {price})'''
        elif mode == 'U': # 수정
            query = f'''UPDATE Book 
               SET bookname = N'{bookName}'
	              ,publisher = N'{publisher}'
	              ,price = {price}
             WHERE bookid = {bookid} ''' 

        conn = pymssql.connect(server=serverName, user=userId, password=userPass, database=dbName, charset=dbCharset)
        cursor = conn.cursor(as_dict=False) # INSERT는 데이터를 가져오는게 아님 => False
        
        try: 
            cursor.execute(query)
            conn.commit() # 저장 확립 = commit

            if mode == 'I':
                QMessageBox.about(self, '저장성공', '데이터를 저장했습니다.')
            else : 
                QMessageBox.about(self, '수정성공', '데이터를 수정했습니다.')

        except Exception as e:
            QMessageBox.warning(self, '저장실패', f'{e}')
            conn.rollback() #원상복귀
        finally:
            conn.close() # 오류가 나든 안나든, DB는 닫기 

        self.btnReloadClicked()     

    def btnDelClicked(self): # 삭제버튼 클릭
        # 삭제기능 
        bookid = self.txtBookid.text()
        # 검증(Validation Check)
        if bookid == None or bookid == '':
            QMessageBox.warning(self, '삭제경고', '책 번호 없이 삭제 할 수 없습니다.')
            return
        
        re = QMessageBox.question(self, '삭제여부', '삭제하시겠습니까?', QMessageBox.Yes | QMessageBox.No)
        if re == QMessageBox.No:
            return
        
        conn = pymssql.connect(server=serverName, user=userId, password=userPass, database=dbName, charset=dbCharset)
        cursor = conn.cursor(as_dict=False) # INSERT는 데이터를 가져오는게 아님 => False
        query = f'''DELETE FROM Book 
                     WHERE bookid = {bookid} '''
        
        try:
            cursor.execute(query)
            conn.commit()

            QMessageBox.about(self, '삭제성공', '데이터를 삭제했습니다.')
        except Exception as e:
            QMessageBox.warning(self, '삭제실패', f'{e}')
            conn.rollback()
        finally:
            conn.close()
        self.btnReloadClicked() # 삭제 후에도 재조회 하기

    def btnReloadClicked(self): # 조회버튼 클릭
        lstResult = []
        conn = pymssql.connect(server=serverName, user=userId, password=userPass, database=dbName, charset=dbCharset)
        cursor = conn.cursor(as_dict=True)


        ## 정가 price 출력형태가 #,# && NULL값이 '0'으로 출력 되도록 쿼리 수정 
        query = '''
                SELECT bookid
                     , bookname
                     , publisher
                     , ISNULL(FORMAT(price, '#,#'), '') AS price
                  FROM Book 
                '''
        
        cursor.execute(query)
        for row in cursor:
            #print(f'bookid={row["bookid"]}, bookname{row["bookname"]}, publisher={row["publisher"]}, price={row["price"]}')
            # dictionary로 만든 결과를 lstResult에 append()
            temp = {'bookid': row["bookid"], 'bookname': row["bookname"], 'publisher': row["publisher"], 'price' : row["price"]}
            lstResult.append(temp)
        conn.close() # DB는 접속해서 끝나면 무조건 닫는다.

        # print(lstResult)
        self.makeTable(lstResult)
    
    def makeTable(self, data): # tblBooks위젯에 데이터와 컬럼(=속성, 열) 생성해주는 함수
        self.tblBooks.setColumnCount(4) # bookid, bookname, publisher, price
        self.tblBooks.setRowCount(len(data)) # 조회에서 나온 리스트 갯수로 결정 즉, lstResult의 길이만큼 (= DB의 튜플 수)
        self.tblBooks.setHorizontalHeaderLabels(['책 번호', '책 제목', '출판사', '정가'])
        
        n = 0
        for item in data:
            #print(item['bookid'])

            ## 숫자로 출력되는 값 오른쪽 정렬 (bookid, price)
            idItem = QTableWidgetItem(str(item['bookid'])) # set(row, colmn, str type text), bookid의 값은 int 이기에 문자로 변경해줘야 출력됨
            idItem.setTextAlignment(Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)
            # setTextAlignment(Qt.AlignmentFlag.정렬옵션)
            # 정렬옵션 : AlignRight/Left(오른쪽/왼쪽 정렬), AlignVCenter(세로 중심정렬), AlignHCenter(가로 중심정렬)
            priceItem = QTableWidgetItem(item['price'])
            priceItem.setTextAlignment(Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)

            ## tblBooks 표에 값 집어넣기
            self.tblBooks.setItem(n, 0, idItem)
            self.tblBooks.setItem(n, 1, QTableWidgetItem(item['bookname']))
            self.tblBooks.setItem(n, 2, QTableWidgetItem(item['publisher']))
            self.tblBooks.setItem(n, 3, priceItem)
            
            n += 1
        
        # tblBooks 위젯 표의 가로길이 설정: setColumnWidth(열번호, 넓이값)
        self.tblBooks.setColumnWidth(0, 65)
        self.tblBooks.setColumnWidth(1, 230)
        self.tblBooks.setColumnWidth(2, 130)
        self.tblBooks.setColumnWidth(3, 80)

        # 컬럼 더블클릭 금지 (내용 수정 불가능하게)
        ## setEditTriggers(-> 수정하려는 행위).QAbstractItemView.NoEditTriggers(-> 금지)
        self.tblBooks.setEditTriggers(QAbstractItemView.NoEditTriggers)
        
    def tblBooksSelected(self): # 조회결과 테이블위젯 내용 클릭 
        rowIndex = self.tblBooks.currentRow() # 마우스로 선택된 행의 인덱스
        
        bookId = self.tblBooks.item(rowIndex, 0).text()
        bookName = self.tblBooks.item(rowIndex, 1).text()
        publisher = self.tblBooks.item(rowIndex, 2).text()
        price = self.tblBooks.item(rowIndex, 3).text().replace(',','') # 앞서 쿼리에서 FORMAT한 형태를 다시 재설정 숫자만 나오도록
        # print(bookId, bookName, publisher, price)

        # 지정된 QlineEdit(TextBox)에 각각 할당
        ## Qt Designer에서 설정한 각각의 QLineEdit(txtBookid, txtBookname ...)에 마우스로 클릭한 행의 값이 출력되도록 각각 대입시키기
        self.txtBookid.setText(bookId)
        self.txtBookname.setText(bookName)
        self.txtPublisher.setText(publisher)
        self.txtPrice.setText(price)
        # 모드를 Update로 변경
        global mode # 전역변수를 내부에서 사용할께! 
        mode = 'U'
        # txtBookid를 사용하지 못하게 설정
        self.txtBookid.setEnabled(False)


    # 원래 PyQt에 있는 함수 closeEvent를 재정의(Override)
    def closeEvent(self, event) -> None:
        re = QMessageBox.question(self, '종료여부', '종료하시겠습니까?', QMessageBox.Yes | QMessageBox.No)
        if re == QMessageBox.Yes:
            event.accept() # 완전히 꺼짐
        else:
            event.ignore()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    inst = qtAPP()
    sys.exit(app.exec_())