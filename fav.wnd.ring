FavWin = New qApp {
	
	winaddfav = new qWidget() 
	{
		setparent(win1)
		setwindowflags( qt_dialog & ~ qt_WindowMaximizeButtonHint & qt_SubWindow)
		setwindowmodality(true)
		setwindowtitle("وردي - الإصدار التجريبي 0.9")
		setwinicon(self,"images/kuran.png")
		setStyleSheet("background-image:url('images/islamic-star.png');font-family:Tahoma, Verdana, Segoe, sans-serif")
		
		
		
		suraText = new qLabel(winaddfav) {settext("قم بتحديد صفحة")}	
		
		
		qPages= New QComboBox(winaddfav) 
		{
			pageList = pobulate_pages()
			for x in pageList additem( ""+x,0) next
		}
		
		addToFavBtn= new qPushButton(page4) {
			settext("إضافة")
			setclickevent("addFav()")
			setStyleSheet("qproperty-icon: url('images/add.png')")
		}
		
		
		table3 = new qTableWidget(winaddfav) {
			setStyleSheet("background-color:#fff;")
			setFixedWidth(270)
			setrowcount(0)
			setcolumncount(3)
			setHorizontalHeaderItem(0, new QTableWidgetItem("السورة"))
			setHorizontalHeaderItem(1, new QTableWidgetItem("الصفحة") )	
			setHorizontalHeaderItem(2, new QTableWidgetItem("التاريخ") )	
			setselectionbehavior(QAbstractItemView_SelectRows)
			setcellDoubleClickedEvent("goToFav()")
		}
		
		delFavBtn= new qPushButton(page4) {
			settext("حذف")
			setclickevent("delFav()")
			setStyleSheet("qproperty-icon: url('images/del.png')")
		}
		
		goToFavBtn= new qPushButton(page4) {
			settext("ذهاب إلى العلامة")
			setclickevent("goToFav()")
			setStyleSheet("qproperty-icon: url('images/bookmark.png')")
		}
		
		
		layout209 = new qHBoxLayout()
		{
			addWidget(addToFavBtn)
			addWidget(qPages)
			addWidget(suraText)
		}
		
		
		layout212= new qHBoxLayout()
		{
			addWidget(delFavBtn)
			addWidget(goToFavBtn)
		}
		
		layout211= new qVBoxLayout(winaddfav)
		{
			addLayout(layout209)
			addWidget(table3)
			addLayout(layout212)
		}
		
		
		setLayout(layout211)
		pobulate_fav()
		show()
		
		
	}
}


func pobulate_pages
	pageList = []
	for i=from_page to to_page
		add(pageList, i)
	next
	return pageList
	
func delFav
	dialogDelFavConf= new qmessagebox(winaddfav)
	{
		setwindowtitle("وردي")
		settext("هل تريد حذف العلامة المرجعية؟")
		setstandardbuttons(QMessageBox_Yes | QMessageBox_No)
		result = exec()
		win1 {
			if result= QMessageBox_Yes
				rpage= table3.currentRow()
				q= "select * from `fav` limit "+rpage+",1"
				odbc_execute(pODBC, q)
				odbc_fetch(pODBC)
				favID= 1*(odbc_getdata(pODBC,1))
				odbc_execute(pODBC, "delete from `fav` where `ID`='"+ favID +"'" )
				pobulate_fav()
			but result= QMessageBox_No
				dialogDelFavConf.close()
			ok
		}
	}
	
func goToFav
	rpage= table3.currentRow()
	q= "select * from `fav` limit "+rpage+",1"
	odbc_execute(pODBC, q)
	odbc_fetch(pODBC)
	p= 1*(odbc_getdata(pODBC,4))
	
	odbc_execute(pODBC, "select * from `Quran` where `page`='"+p+"'")
	odbc_fetch(pODBC)
	ayatID=1*odbc_getdata(pODBC,3)
	thePageData(p)
	setPageData()
	winaddfav.close()
	tab1.setCurrentIndex(0)
	
func addFav
	p= qPages.currentText()
	odbc_execute(pODBC, "select `SuraID`,name from Quran where `page`='"+ p +"'")
	odbc_fetch(pODBC)
	favSuraName= odbc_getdata(pODBC,2)
	favSuraID= odbc_getdata(pODBC,1)
	
	q= "select `ID` from `fav` where `page`='"+ p +"'"
	odbc_execute(pODBC, q)
	odbc_fetch(pODBC)
	r= odbc_getdata(pODBC,1)
	if(r)
		dialogBoxOk("عفواً ... هذ الصفحة موجودة من قبل", winaddfav)
	else
		q= "insert into `fav` (`SuraID`, `name`, `page`, `dateline`) values('"+ favSuraID +"', '"+favSuraName+"', '"+ p +"', datetime())"
		odbc_execute(pODBC, q)
		pobulate_fav()
	ok
	
	

func pobulate_fav
	m= table3.setRowCount(0)
	q= "select * from `fav` order by ID asc"
	i=0
	odbc_execute(pODBC, q)
	while odbc_fetch(pODBC)
		table3.insertRow(i)
		
		it1=QTableWidgetItem_new(odbc_getdata(pODBC,3))
		it2=QTableWidgetItem_new(odbc_getdata(pODBC,4))
		it3=QTableWidgetItem_new(odbc_getdata(pODBC,5))
		
		table3.setitem(i,0,it1)
		table3.setitem(i,1,it2)
		table3.setitem(i,2,it3)
		i++
	end