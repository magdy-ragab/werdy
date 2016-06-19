TafsserWin = New qApp {
	
	TafsserWinWidget = new qWidget() 
	{
		resize(400,500)
		setparent(win1)
		setwindowflags( qt_dialog & ~ qt_WindowMaximizeButtonHint & qt_SubWindow)
		setwindowmodality(true)
		setwindowtitle("وردي - التفسير الميسر")
		setwinicon(self,"images/icon.png")
		setStyleSheet("font-family:Tahoma, Verdana, Segoe, sans-serif")
		
		
		
		TafsserLabel= new qLabel(TafsserWinWidget) {settext("التفسير الميسر")}	
		
		
		TafsserText= New qtextedit(TafsserWinWidget) 
		{
			pagea1=getCurrenpage()
			pagea2=(getCurrenpage()+pagesCount())-1
			m= ""
			
			for i = pagea1 to pagea2
				tafseerAyat=tafseerAyatClean(i)
				jq=1
				q="select * from `ar_muyassar` where page='"+ i +"'"
				query.exec( q)
				m+="<p align=left style='background-color:lightgray'><span>صفحة : "+ i +"</span></p>"
				while query.movenext()
					aya= 1*(query.value(4).tostring())
					ayaID= 1*(query.value(1).tostring())
					tafseerText= query.value(5).tostring()
					m+= "<p>("+ aya +")&nbsp;&nbsp;&nbsp;<span style='color:rgb(50,50,50);'>"+ tafseerAyat[jq] +"</span><br /><strong>"+tafseerText+"</strong></p>"
					jq++
				end 
			next
			settext(m)
			setStyleSheet("background-image:url('../images/fff.png')")
		}
		
		
		
		
		
		TafsserWinEx= new qPushButton(page4) {
			settext("إنهاء")
			setclickevent("closeTafseer()")
			setStyleSheet("qproperty-icon: url('images/del.png')")
		}
		
		layout220 = new qVBoxLayout()
		{
			addWidget(TafsserLabel)
			addWidget(TafsserText)
			addWidget(TafsserWinEx)
		}
		
		
		
		
		
		setLayout(layout220)
		show()
		
		
	}
}



func closeTafseer 
	TafsserWinWidget.close()

func tafseerAyatClean fp1
	tafseerAyat= []
	query.exec( "select `clean` from `Quran` where `page`='"+ fp1 +"'")
	while query.movenext()
		add( tafseerAyat, query.value(0).tostring() )
	end
	
	return tafseerAyat
	