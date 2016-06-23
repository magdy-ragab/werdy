MainWin = New qApp {

        win1 = new qwidget() {
			resize(400,500)
			setwindowtitle("وردي - الإصدار التجريبي 0.9")
			setwindowflags( qt_dialog)
            setwinicon(self,"images/icon.png")
			setStyleSheet("background-image:url('images/islamic-star.png');font-family:Tahoma, Verdana, Segoe, sans-serif")
			new qtimer(win1)
			{
				setinterval(werdyTimers()*1000*60)
				settimeoutevent("checkReadTime()")
				start()
			}
			
			trayMenu=new QSystemTrayIcon()
			{

				mymenu = new QMenu(win1)
				{
					oAction = new qAction(win1)
					{
						settext("إستعادة")
						oAction.setclickevent("showWind()")
					}
					addaction(oAction)
					
					
					
				
					addseparator()
					
					oAction = new qaction(win1)
					{
						oAction.settext("إنهاء")
						oAction.setclickevent("MainWin.quit()")
					}
					addaction(oAction)
				}

				setContextMenu(myMenu)
				setIcon( new QIcon(new QPixMap("images/icon-small.png") ) )
				show()
	
			}
			

/* main tab */			
			page1 = new qwidget() {
				suraText = new qLabel(page1) {}
				pageNum = new qLabel(page1) {}
				jozNum = new qLabel(page1) {}
				
				
				ayatHTML = new qwebview(page1){}
				
				TafseerBtn = new qPushButton(page1) {
                        settext("التفسير")
						setclickevent("tafseer()")
						setStyleSheet("qproperty-icon: url('images/1464846947_book.png');font-size:9pt;border:1px solid #B4A971;color:#55490C; height:30px;background-image: url('images/fff.png');border-radius:5px;")
                }
				
				favBtn = new qPushButton(page1) {
                        settext("العلامات")
						setclickevent("addToFavWind()")
						setStyleSheet("qproperty-icon: url('images/bookmark.png');font-size:9pt;border:1px solid #B4A971;color:#55490C; height:30px;background-image: url('images/fff.png');border-radius:5px;")
                }
				hideBtn = new qPushButton(page1) {
                        settext("إخفاء")
						setclickevent("hiddenMode()")
						setStyleSheet("qproperty-icon: url('images/hide.png');font-size:9pt;border:1px solid #B4A971;color:#55490C; height:30px;background-image: url('images/fff.png');border-radius:5px;")
                }
				
				NextBtn= new qPushButton(page1) {
                        //settext("«")
						setclickevent("nextClicked()")
						setStyleSheet("qproperty-icon: url('images/arrow-left-01.png');font-size:18pt;border:1px solid #B4A971;color:#55490C; height:30px;background-image: url('images/fff.png');border-radius:5px;font-weight:bold;")
                }
				
				PrevBtn = new qPushButton(page1) {
                        //settext("»")
						setclickevent("prevClicked()")
						setStyleSheet("qproperty-icon: url('images/arrow-right-01.png');font-size:18pt;border:1px solid #B4A971;color:#55490C; height:30px;background-image: url('images/fff.png');border-radius:5px;font-weight:bold;")
                }
				
				
				layout0 = new qHBoxLayout(page1) {
					addwidget(NextBtn)
					addwidget(PrevBtn)
					addwidget(hideBtn)
					addwidget(favBtn)
					addwidget(TafseerBtn)
					
				}
				
				layout1 = new qHBoxLayout(page1) {
					addwidget(pageNum)
					addwidget(jozNum)
					addwidget(suraText)
				}
				
				
				
				layout2 = new qVBoxLayout(page1) {
					
					addLayout(layout1)
					//addWidget(ayatText)
					addWidget(ayatHTML)
					addLayout(layout0)
					
				}
				setLayout(layout2)
				
				
			}
			
			
/* settings tab */
			
			win2 = new qwidget() {
				setFixedHeight(300)
				setStyleSheet("border:1px solid #B4A971;background-image:url('images/fff.png');height:25px;")
				
				PagesPerTime = new qLabel(win2) {
					settext("عدد الصفحات في المرة : ")
					setStyleSheet("border:0px none;")
                }
				
				spinnr = new qspinbox(win2) {
					pagesRead=pagesCount()
					pagesRead=1*pagesRead
					setvalue(pagesRead)
					setrange(1, 100)
				}
				
				
				reade = new qLabel(win2) {
					settext("عدد الدقائق بين كل ورد:")
					setStyleSheet("border:0px none;")
                }
				
				spinner2 = new qspinbox(win2) {
					werdHour=werdyTimers()
					werdHour=1*werdHour
					setvalue(werdHour)
					setrange(1, 500)
					setSingleStep(15)
				}
				
				readTimeLabel1 = new qLabel(win2) {
					settext("تشغيل بين الساعة")
					setStyleSheet("border:0px none;")
                }
				
				readTimeCombo1= New qspinbox(win2) 
				{
					getStartTimeV=getStartTime()
					getStartTimeV=1*getStartTimeV
					setvalue(getStartTimeV)
					setrange(0, 23)
				}
				readTimeLabel2 = new qLabel(win2) {
					settext("و الساعة")
					setStyleSheet("border:0px none;")
                }
				
				readTimeCombo2= New qspinbox(win2) 
				{
					getEndTimeV=getEndTime()
					getEndTimeV=1*getEndTimeV
					setvalue(getEndTimeV)
					setrange(1, 23)
				}
				
				
				clean_label= new qcheckbox(win2) {
                    settext("لاتعرض التشكيل")
					setStyleSheet("border:0px none;")
					if clean_only='1'
						setChecked(true)
					ok
                }
				
				
				aya_block_check= new qcheckbox(win2) {
                    settext("كل آيه في سطر")
					setStyleSheet("border:0px none;")
					if aya_block='1'
						setChecked(true)
					ok
                }
				
				
				setdefaultBtn  = new qPushButton(win2) {
                    settext("الإعدادات الإفتراضية")
					setStyleSheet("qproperty-icon: url('images/1466523816_Info.png'); color:red; font-weight:bold;")
					setclickevent("setdefault()")
                }
				
				/*appTypeLabel= new qlabel(win2)
				{
					settext("نمط البرنامج")
					setStyleSheet("border:0px none;")
				}
				
				appTypeCombo=New QComboBox(win2) {
                        setGeometry(150,100,200,30)
                        alist = ["ورد","قرآءة"]
                        for x in aList 
							additem(x,0) 
						next
                }*/
				
				picAyatColor  = new qPushButton(win2) {
                    settext("لون النص")
					setStyleSheet("qproperty-icon: url('images/mix_document.png');")
					setclickevent("changeAyatColor()")
                }
				
				picAyatColor2  = new qPushButton(win2) {
                    settext("لون أرقام الآيات")
					setStyleSheet("qproperty-icon: url('images/color.png');")
					setclickevent("changeAyatColor2()")
                }
				
				WerdContReadBtn  = new qPushButton(win2) {
                    settext("إعادة تشغيل الورد")
					setStyleSheet("qproperty-icon: url('images/1464846947_book.png');")
					setclickevent("WerdContRead()")
                }
				
				
				settingsSubmit= new qPushButton(win2) {
                    settext("حفظ")
					setclickevent("settingsSubmitClicked()")
                }
				
				
				
				
				layout200 = new qHBoxLayout(win2) {
					addwidget(spinnr)
					addwidget(PagesPerTime)
				}
				
				layout201 = new qHBoxLayout(win2) {
					addwidget(spinner2)
					addwidget(reade)
				}
				
				layout204 = new qHBoxLayout(win2) {
					addwidget(picAyatColor2)
					addwidget(picAyatColor)
					addwidget(WerdContReadBtn)
				}
				
				layout205 = new qHBoxLayout(win2) {
					addWidget(aya_block_check)
					addWidget(clean_label)
				}
				
				layout206 = new qHBoxLayout(win2) {
					addWidget(clean_label)
				}
				
				layout207 = new qHBoxLayout(win2) {
					addWidget(settingsSubmit)
				}
				
				layoutreadTimeSettings = new qHBoxLayout(win2) {
					addWidget(readTimeCombo2)
					addWidget(readTimeLabel2)
					addWidget(readTimeCombo1)
					addWidget(readTimeLabel1)
				}
				
				/*appTypeLayout= new qHboxLayout(win2)
				{
					addWidget(appTypeCombo)
					addWidget(appTypeLabel)
				}*/
				
				layout203 = new qVBoxLayout(win2) {
					addLayout(layout200)
					addLayout(layout201)
					//addLayout(appTypeLayout)
					addLayout(layoutreadTimeSettings)
					addWidget(setdefaultBtn)
					addLayout(layout205)
					addLayout(layout206)
					addLayout(layout204)
					addLayout(layout207)
				}
				
				setLayout(layout203)
				
			}
			
			
/* الفهرس */
			page3 = new qwidget() {
				searchSuraName= new qLabel(page3) {
					settext("السورة")
					setStyleSheet("border:0px none;")
                }
				searchText = new qLineEdit(page3) {
					setStyleSheet("background-color:#fff")
                }
				
				searchSuraBtn= new qPushButton(page3) {
                    settext("بحث")
					setclickevent("searchSuraName()")
                }
				
				Table1 = new qTableWidget(page3) {
					setStyleSheet("background-color:#fff")
					setrowcount(114)
					setcolumncount(3)
					setHorizontalHeaderItem(0, new QTableWidgetItem("السورة"))
					setHorizontalHeaderItem(1, new QTableWidgetItem("الصفحة") )	
					setHorizontalHeaderItem(2, new QTableWidgetItem("الآيات") )	
					setselectionbehavior(QAbstractItemView_SelectRows)
					setcellDoubleClickedEvent("goIndex()")
					load 'includes/sura.ring' 
				}
				layoutpage3_1 = new qHBoxLayout(page3) {
					addwidget(searchSuraBtn)
					addwidget(searchText)
					addwidget(searchSuraName)
				}
				layout208 = new qVBoxLayout(page3) {
					addLayout(layoutpage3_1)
					addwidget(Table1)
				}
				setLayout(layout208)
				
			}
			
/* search */
			page4= new qwidget() {
				//setStyleSheet("border:1px solid #B4A971;height:25px;")
				//setFixedHeight(40)
				searchLabel = new qlabel(page4){
					settext("بحث")
					//setFixedWidth(50)
					setStyleSheet("border:0px none;")
				}
				
				searchtxtBoxNew= new qLineEdit(page4) {
					setFixedHeight(30)
					//settext("دين الحق")
					setStyleSheet("border:2px solid #B4A971;background-image:url('images/fff.png');border-radius:5px; height:30px")
                }
				
				
				searchSubmit= new qPushButton(page4) {
                    settext("بحث")
					setclickevent("searchindex()")
					setStyleSheet("qproperty-icon: url('images/search.png')")
                }
				
				
				table2 = new qTableWidget(page4) {
					setStyleSheet("background-color:#fff;")
					setrowcount(0)
					setcolumncount(4)
					setHorizontalHeaderItem(0, new QTableWidgetItem("النص") )	
					setHorizontalHeaderItem(1, new QTableWidgetItem("السورة"))
					setHorizontalHeaderItem(2, new QTableWidgetItem("الصفحة") )	
					setHorizontalHeaderItem(3, new QTableWidgetItem("آية رقم") )	
					setselectionbehavior(QAbstractItemView_SelectRows)
					setcellDoubleClickedEvent("goToPage()")
				}
				
				layout209 = new qHBoxLayout() {
					addWidget(searchSubmit)
					addWidget(searchtxtBoxNew)
					addWidget(searchLabel)
				}
				
				//setLayout(layout209)
				
				layout210= new qVBoxLayout(page4)
				{
					addLayout(layout209)
					addWidget(table2)
				}
				setLayout(layout210)
				
			}
/* help */
			page5= new qwidget() {
				myweb = new qwebview(page5)
				{
					loadpage(new qurl("file:///"+werdyDir()+"/web/werdy-web/public_html/index.html"))
				}
				
				layoutWeb= new qVBoxLayout(page5)
				{
					addWidget(myweb)
				}
				setLayout(layoutWeb)
				
			}
			
			
			tab1 = new qtabwidget(win1) {
				
				inserttab(0,page1,"  القرآن  ")
				inserttab(1,page3,"  الفهرس  ")
				inserttab(2,win2,"  إعدادات  ")
				inserttab(3,page4,"  بحث  ")
				inserttab(4,page5,"  المساعدة  ")
				setStyleSheet("font-family:Tahoma;")
			}
			
			layout101= new qVBoxLayout(win1) {
				addwidget(tab1)
			}
			setLayout(layout101)
			
			
			
			show()
        }
		
		
		p=1+lastPage()
		if p>604 p=1 ok
		thePageData( p )
		setPageData()
		exec()
}






