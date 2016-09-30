FavWin = New qApp {
	
	winaddfav = new qWidget() 
	{
		setparent(win1)
		setwindowflags( qt_dialog & ~ qt_WindowMaximizeButtonHint & qt_SubWindow)
		setwindowmodality(true)
		setwindowtitle("وردي - الإصدار التجريبي 0.9")
		setwinicon(self,"icon.png")
		setStyleSheet("background-image:url('islamic-star.png');font-family:Tahoma, Verdana, Segoe, sans-serif")
		
		
		
		suraText = new qLabel(winaddfav) {settext("قم بتحديد صفحة")}	
		
		
		qPages= New QComboBox(winaddfav) 
		{
			pageList = pobulate_pages()
			for x in pageList additem( ""+x,0) next
		}
		
		addToFavBtn= new qPushButton(page4) {
			settext("إضافة")
			setclickevent("addFav()")
			setStyleSheet("qproperty-icon: url('add.png')")
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
			setStyleSheet("qproperty-icon: url('del.png')")
		}
		
		goToFavBtn= new qPushButton(page4) {
			settext("ذهاب إلى العلامة")
			setclickevent("goToFav()")
			setStyleSheet("qproperty-icon: url('bookmark.png')")
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
                showfullscreen()
		
		
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
		winaddfav
		{
			if result = QMessageBox_Yes
				row=table3.currentRow()
				if row= -1
					dialogBoxOk("لم تقم بتحديد صفحة !!", dialogDelFavConf)
				else
					row= table3.item(table3.currentRow(),1).text()
					q= "delete from `fav` where `page`='"+ row +"'"
					see q+nl
					query.exec(q)
					pobulate_fav()
				ok
			but result = QMessageBox_No
				dialogDelFavConf.close()
			ok
		}
	}
	
func goToFav
	row=table3.currentRow()
	if row= -1
		dialogBoxOk("لم تقم بتحديد صفحة !!", winaddfav)
		//see "error"+nl
	else
		favPageID= 1*(table3.item(row,1).text())
		see favPageID+nl
		/*query.exec("select * from `Quran` where `page`='"+rpage+"'")
		query.movenext()
		ayatID=1*query.value(3).tostring()*/
		thePageData(favPageID)
		setPageData()
		winaddfav.close()
		tab1.setCurrentIndex(0)
	ok
	
func addFav
	p= qPages.currentText()
	q= "select * from Quran where `page`='"+ p +"'"
	see q
	query.exec(q)
	query.movenext()
	favSuraName= query.value(7).tostring()
	favSuraID= query.value(1).tostring()
	q= "insert into `fav` (`SuraID`, `name`, `page`, `dateline`) values('"+ favSuraID +"', ('"+(favSuraName)+"'), '"+ p +"', datetime())"
	query.exec( q)
	pobulate_fav()

	
	

func pobulate_fav
	m= table3.setRowCount(0)
	q= "select * from `fav` order by ID asc"
	i=0
	query.exec( q)
	while query.movenext()
		table3.insertRow(i)
		
		it1=QTableWidgetItem_new(query.value(2).tostring())
		it2=QTableWidgetItem_new(query.value(3).tostring())
		it3=QTableWidgetItem_new(query.value(4).tostring())
		
		table3.setitem(i,0,it1)
		table3.setitem(i,1,it2)
		table3.setitem(i,2,it3)
		i++
	end
