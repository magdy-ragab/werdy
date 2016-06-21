load "guilib.ring"
load "includes/globals.ring"


oCon = new QSqlDatabase()
oCon = oCon.addDatabase("QSQLITE")
oCon.setDatabaseName("quran.db")
oCon.open()
query = new QSqlQuery( )

clean_only= isCleanText()
pagesRead=pagesCount()
werdHour= werdyTimers()
ayat_color= getAyatColor()
no_color= getNumColor()
aya_block= aya_block_func()

load "includes/wnd.ring"





func nextClicked
	p= (1*page)+1
	if p>604 p=1 ok
	thePageData(p)
	
func prevClicked
	p= (1*getCurrenpage())-(1*pagesCount())
	if p<1 p=1 ok
	thePageData(p)

func thePageData px
	ayat=''
	see px+nl
	im= get_img()
	
	for i=0 to (1*pagesCount())-1
		q= "select * from Quran q where `page`='"+ (px+i) +"'"
		query.exec(q)
		if( (px+i)%2 ) d="left" else d="right" ok
		ayat+='<p style="text-align:'+d+';" class="pageNum"><span>'+ (px+i) +'</span></p>'
		ayat+="<p class='pageText'>"
		while query.movenext()
			theid= query.value(0).tostring()
			aya_no= query.value(2).tostring()
			suraid = query.value(1).tostring()
			joz= query.value(4).tostring()
			page= query.value(3).tostring()
			suraName= query.value(7).tostring()
			sura  =suraName
			if(aya_no = 1)
				ayat += "</p><h2 style='color:blue;padding:0px; margin:0px;' align=center>("+ suraName +")</h2><p class='pageText'>" 
			ok
			
			if(clean_only=1)
				aya_text=query.value(8).tostring()
			else
				aya_text= query.value(6).tostring()
			ok
			
			if(im=theid)
				aya_text= "<span style='background-color:#feffe8;font-weight:bold;'>"+aya_text+"</span>"
			ok
			
			ayat += "<span style='color:"+ayat_color+"'>"+  aya_text +"</span>"+ " <span style='color:"+no_color+";' class='ayaNum'>"+ aya_no +"</span> " 
			
			if(aya_block=1)
				ayat+="<br />"
			ok
			
			
		end
		ayat+="</p>"
	next
	setPageData()
	query.exec("update user_data set `page_id`='"+ px +"'")
	
func goIndex
	row=1*(Table1.item(Table1.currentRow(),1).text())
	thePageData(row)
	setPageData()
	tab1.setCurrentIndex(0)
	
func setPageData
	pageNum.settext("صفحة : <b>"+page+"</b> / 604")
	suraText.setText("سورة : <b>"+ sura + "</b>")
	jozNum.setText("الجزء : <b>"+joz+"</b> / 30")
	
	nfile=werdyDir()+"web"+DS+ "web.html"
	write(nfile, HTMLFILESTART+ayat+HTMLFILEEND)
	ayatHTML.loadpage(new qurl("file:///"+nfile))
	//Remove(nfile)


func lastPage
	query.exec("select * from user_data")
	query.movenext()
	thelastpage  =query.value(0).tostring()
	return thelastpage

	
	

func pagesCount
	query.exec("select * from user_data")
	query.movenext()
	pagesRead  =query.value(1).tostring()
	return 1*pagesRead
	
func werdyTimers
	query.exec("select * from user_data")
	query.movenext()
	werdHour  =query.value(2).tostring()
	return 1*werdHour
	

func isCleanText
	query.exec("select * from user_data")
	query.movenext()
	clean_only  =query.value(3).tostring()
	return clean_only

func getAyatColor
	query.exec("select * from user_data")
	query.movenext()
	ayat_color  =query.value(4).tostring()
	return ayat_color
	
	
func get_img
	query.exec("select * from user_data")
	query.movenext()
	im  = query.value(7).tostring()
	return im

func getStartTime
	query.exec("select * from user_data")
	query.movenext()
	r  =query.value(9).tostring()
	return r

func getEndTime
	query.exec("select * from user_data")
	query.movenext()
	r  =query.value(10).tostring()
	return r
	
func getNumColor
	query.exec("select * from user_data")
	query.movenext()
	no_color  =query.value(5).tostring()
	return no_color

func aya_block_func
	query.exec("select * from user_data")
	query.movenext()
	aya_block  =query.value(6).tostring()
	return aya_block
	
func settingsSubmitClicked
	setNewPages   = spinnr.value()
	setNewMinutes = spinner2.value()
	clean_only = clean_label.ischecked()
	aya_block = aya_block_check.ischecked()
	
	timeStart=readTimeCombo1.value()
	timeEnd=readTimeCombo2.value()
	
	if(1*timeStart)>=(1*timeEnd)
		dialogBoxOk("عفواً ساعة الإنتهاء يجب أن تكون أقل من ساعة البداية",win1)
	else
		if len( string(timeStart))= 1
			timeStart="0"+timeStart
		ok
		
		if len( string(timeEnd))= 1
			timeEnd="0"+timeEnd
		ok
		
		query.exec("update `user_data` set `pages`='"+setNewPages+"', `minutes`='"+ setNewMinutes +"', `clean`='"+ clean_only +"', `aya_block`='"+aya_block+"', `timeEnd`='"+timeStart+"' , `timeStart`='"+timeEnd+"'")
		tab1.setCurrentIndex(0)
	ok
	getAyatColor()
	thePageData(getCurrenpage())
	setPageData()
	ayatHTML.reload()

func getCurrenpage
	query.exec("select * from user_data")
	query.movenext()
	cpage  =query.value(0).tostring()
	return 1*cpage

func translateTextUTF8 cStr
	return cStr
	
	
	
func searchindex
	searchTextResult=searchtxtBoxNew.text()
	if searchTextResult != ''
		table2.setRowCount(0)
		q= "select * from `Quran` where `clean` like '%"+ searchTextResult +"%'"
		i=0
		query.exec(q)
		while query.movenext()
			cleanAyatSearch=query.value(8).tostring()
			suraSearch=query.value(7).tostring()
			pageSearch=query.value(3).tostring()
			VerseIDSearch=query.value(2).tostring()
			table2.insertRow(i)
			it1=QTableWidgetItem_new(cleanAyatSearch)
			it2=QTableWidgetItem_new(suraSearch)
			it3=QTableWidgetItem_new(pageSearch)
			it4=QTableWidgetItem_new(VerseIDSearch)
			table2.setitem(i,0,it1)
			table2.setitem(i,1,it2)
			table2.setitem(i,2,it3)
			table2.setitem(i,3,it4)
			i++
		end
		
	else
		dialogBoxOk("لم تقم بكتابة شئ للبحث عنه", MainWin)
	ok
	
func goToPage
	searchTextResult= searchtxtBoxNew.text()
	rpage= table2.currentRow()
	q= "select * from `Quran` where `clean` like '%" + searchTextResult + "%' limit "+rpage+",1"
	query.exec(q)
	query.movenext()
	p= 1*(query.value(3).tostring())
	ayatID= 1*(query.value(0).tostring())
	query.exec("update `user_data` set `im`='"+ayatID +"'")
	thePageData(p)
	setPageData()
	tab1.setCurrentIndex(0)

func hiddenMode
	trayMenu.showMessage("البرنامج يعمل في الخلفية", "برنامج وردي لازال يعمل في الخلفية ... لإعادة تشغيله مرة أخرى انقر بالزر الأيمن على هذه الأيقونة و إضغط على 'إستعادة'", 1, 5000)
	win1.hide()

func showWind
	win1.showNormal()
	

func checkReadTime
	n=TimeList()
	nHour=1*n[7]
	s1= 1*getStartTime()
	s2= 1*getEndTime()
	/*see "Housr : "+nHour +" "+s1+ " "+s2 + nl*/
	if(nHour>= s1 )
		query.exec("select `snoozeTo`, datetime() as t ,(case when `snoozeTo`> datetime() then '0' else '1' end ) as re from user_data")
		query.movenext()
		cdate  =query.value(2).tostring()
		csnooze =query.value(0).tostring()
		cnow =query.value(1).tostring()
		
		if cdate=1
			see "lunch"+nl
			load 'includes/wrd.wind.ring'
		else
			//see "snoozed "+csnooze+" (now : "+cnow+" - cdate : "+ cdate +")"+nl
		ok
	ok
Func changeAyatColor
	cobj= new qcolordialog()
    ccolor= cobj.GetColor()
    r=ccolor[1] g=ccolor[2] b=ccolor[3]
    //ayatText.setstylesheet("color: rgb("+r+", " + g+ "," + b + ")")
	ayat_color="rgb("+r+", " + g+ "," + b + ")"
	q="update `user_data` set `ayat_color`='"+ayat_color+"'"
	query.exec( q)
	ayatHTML.reload()
	
Func changeAyatColor2
	cobj= new qcolordialog()
    ccolor= cobj.GetColor()
    r=ccolor[1] g=ccolor[2] b=ccolor[3]
    //ayatText.setstylesheet("color: rgb("+r+", " + g+ "," + b + ")")
	no_color="rgb("+r+", " + g+ "," + b + ")"
	q="update `user_data` set `number_color`='"+no_color+"'"
	f= fopen('images/aya_no.svg', 'w')
	fwrite(f, '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   version="1.1"
   width="45"
   height="30"
   id="svg2">
  <defs
     id="defs4" />
  <metadata
     id="metadata7">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     transform="translate(0,-1022.3622)"
     id="layer1">
    <path
       d="m 7.78125,1023.6875 c 0,0 -1.0295794,2.7521 -2.0625,5.6875 -0.5164603,1.4677 -1.0417412,2.9799 -1.4375,4.25 -0.1978794,0.6351 -0.3438109,1.1947 -0.46875,1.6875 -0.1249391,0.4928 -0.25,0.818 -0.25,1.4063 l 0,0.1874 0.0625,0.1563 c 0.8416699,4.1413 3.0276495,11.0357 4.65625,13.9687 l 3.09375,-1.7187 c -1.024767,-1.8456 -3.471209,-9.0351 -4.25,-12.7187 0.010509,-0.019 0.017904,-0.1071 0.09375,-0.4063 0.099284,-0.3916 0.2509977,-0.9327 0.4375,-1.5313 0.3730046,-1.1971 0.8976925,-2.6797 1.40625,-4.125 1.017115,-2.8905 2.03125,-5.5937 2.03125,-5.5937 l -3.3125,-1.25 z"
       id="path2987"
       style="font-size:medium;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-indent:0;text-align:start;text-decoration:none;line-height:normal;letter-spacing:normal;word-spacing:normal;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;text-anchor:start;baseline-shift:baseline;color:'+no_color+';fill:'+no_color+';fill-opacity:1;stroke:none;stroke-width:3.52769685;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate;font-family:Sans;-inkscape-font-specification:Sans" />
    <path
       d="m 7.0728476,14.940397 a 3.2582781,3.2582781 0 1 1 -6.51655626,0 3.2582781,3.2582781 0 1 1 6.51655626,0 z"
       transform="translate(2,1022.3622)"
       id="path3757"
       style="fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:'+no_color+';stroke-width:2;stroke-linecap:square;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;stroke-dashoffset:30" />
    <path
       d="m 36.958737,1023.7353 c 0,0 1.02958,2.7521 2.0625,5.6875 0.516461,1.4677 1.041742,2.9799 1.4375,4.25 0.19788,0.6351 0.343811,1.1947 0.46875,1.6875 0.124939,0.4928 0.25,0.818 0.25,1.4063 l 0,0.1874 -0.0625,0.1563 c -0.84167,4.1413 -3.027649,11.0357 -4.65625,13.9687 l -3.09375,-1.7187 c 1.024767,-1.8456 3.471209,-9.0351 4.25,-12.7187 -0.01051,-0.019 -0.0179,-0.1071 -0.09375,-0.4063 -0.09928,-0.3916 -0.250997,-0.9327 -0.4375,-1.5313 -0.373004,-1.1971 -0.897692,-2.6797 -1.40625,-4.125 -1.017115,-2.8905 -2.03125,-5.5937 -2.03125,-5.5937 l 3.3125,-1.25 z"
       id="path3761"
       style="font-size:medium;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-indent:0;text-align:start;text-decoration:none;line-height:normal;letter-spacing:normal;word-spacing:normal;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;text-anchor:start;baseline-shift:baseline;color:'+no_color+';fill:'+no_color+';fill-opacity:1;stroke:none;stroke-width:3.52769685;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate;font-family:Sans;-inkscape-font-specification:Sans" />
    <path
       d="m 7.0728476,14.940397 a 3.2582781,3.2582781 0 1 1 -6.51655626,0 3.2582781,3.2582781 0 1 1 6.51655626,0 z"
       transform="matrix(-1,0,0,1,42.739987,1022.41)"
       id="path3763"
       style="fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:'+no_color+';stroke-width:2;stroke-linecap:square;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;stroke-dashoffset:30" />
    <path
       d="m 10.410596,1026.1768 26.509983,0"
       id="path3765"
       style="fill:none;stroke:'+no_color+';stroke-width:1.00770843px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
    <path
       d="m 10.410596,1048.1768 26.509983,0"
       id="path3767"
       style="fill:none;stroke:'+no_color+';stroke-width:1.00770843px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
    <path
       d="m 4.8429373,1034.7429 c 0,0 -0.7569393,-3.4286 -1.8700853,-3.5176 -1.0670706,-0.086 -2.40439545,0.757 -2.3598696,2.1818 0.0445258,1.4248 2.1372403,4.0073 2.1372403,4.0073"
       id="path3837"
       style="fill:none;stroke:'+no_color+';stroke-width:0.93099487px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
    <path
       d="m 4.8429373,1039.8908 c 0,0 -0.7569393,3.4286 -1.8700853,3.5176 -1.0670706,0.086 -2.40439545,-0.757 -2.3598696,-2.1818 0.0445258,-1.4248 2.1372403,-4.0073 2.1372403,-4.0073"
       id="path3841"
       style="fill:none;stroke:'+no_color+';stroke-width:0.93099487px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
    <path
       d="m 40.420595,1034.7907 c 0,0 0.75694,-3.4286 1.870086,-3.5176 1.06707,-0.086 2.404395,0.757 2.359869,2.1818 -0.04453,1.4248 -2.13724,4.0073 -2.13724,4.0073"
       id="path3843"
       style="fill:none;stroke:'+no_color+';stroke-width:0.93099487px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
    <path
       d="m 40.420595,1039.9386 c 0,0 0.75694,3.4286 1.870086,3.5176 1.06707,0.086 2.404395,-0.757 2.359869,-2.1818 -0.04453,-1.4248 -2.13724,-4.0073 -2.13724,-4.0073"
       id="path3845"
       style="fill:none;stroke:'+no_color+';stroke-width:0.93099487px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
  </g>
</svg>')
	fclose(f)
	query.exec( q)
	nfile=werdyDir()+"web"+DS+ "web.html"
	ayatHTML.reload()
	


func addToFavWind
	from_page=getCurrenpage()
	to_page=(1*(getCurrenpage()))+((1*pagesCount())-1)
	load "includes/fav.wnd.ring"

func dialogBoxOk msg,w
	new qmessagebox(w)
	{
		setwindowtitle("وردي")
		settext("<span style='padding:10px;color: red;'>"+msg+"</span>")
		//setInformativeText(msg)
		setstandardbuttons(QMessageBox_Yes)
		setFixedWidth(200)
		r=exec()
		return r
	}


func hideTopLayout
	ReadNoticLabel.hide()
	snoozeBtn.hide()
	ReadNoticLabelSep.hide()

func SnoozeNow
	scIndex= snoozeCombo.currentIndex()
	if scIndex=0
		q="update `user_data` set `snoozeTo`= datetime(datetime(), '+15 minutes')"
	but scIndex=1
		q="update `user_data` set `snoozeTo`= datetime(datetime(), '+30 minutes')"
	but scIndex=2
		q="update `user_data` set `snoozeTo`= datetime(datetime(), '+60 minutes')"
	but scIndex=3
		q="update `user_data` set `snoozeTo`= datetime(datetime(), '+120 minutes')"
	but scIndex=4
		q="update `user_data` set `snoozeTo`= date(date(),'+1 days') || ' 00:00:00'"
	but scIndex=5
		q="update `user_data` set `snoozeTo`= '2100-12-31 00:00:00'"
	ok
	query.exec( q)
	
	pagea1=getCurrenpage()
	pagea2=getCurrenpage()-pagesCount()
	prevpage= pagea1+pagesCount()
	if prevpage<1 prevpage=1 ok
	query.exec("update `user_data` set `pageID`='"+prevpage +"'")
	snoozW.close()
	winwrd.close()
	hiddenMode()
	
	
func WerdContRead
	q="update `user_data` set `snoozeTo`= '2000-12-31 00:00:00'"
	query.exec( q)
	
func SnoozeReading
	load "includes/snooze.wnd.ring"
	
func werdyDir
	cDir= currentdir()
	return cDir+DS

func tafseer
	load 'includes/tafseer.ring'

func searchSuraName
	Table1.setRowCount(0)
    t=searchText.text()
	i=0
	query.exec("select distinct(`name`) , `page`,( select count(*) from `Quran` where SuraID=q.SuraID ) as c from `Quran` q where `name` like '%"+t +"%' and VerseID='1' group by name order by ID asc")
	while query.movenext()
		filterSuraName  =query.value(0).tostring()
		filterSuraPage  =query.value(1).tostring()
		filterSuraAya  =query.value(2).tostring()
		Table1.insertRow(i)
		it0=QTableWidgetItem_new(filterSuraName)
		it1=QTableWidgetItem_new(filterSuraPage)
		it2=QTableWidgetItem_new(filterSuraAya)
		Table1.setitem(i,0,it0)
		Table1.setitem(i,1,it1)
		Table1.setitem(i,2,it2)
		i++
	end 

func setdefault
	dialogDef= new qmessagebox(win1)
	{
		setwindowtitle("وردي")
		settext(" <p style='color:red; margin:20px;'>  هل تريد إستعادة الإعدادات الإفتراضية  <br />سيتم أيضاً العودة إلى الصفحة رقم 1  </span>")
		setstandardbuttons(QMessageBox_Yes | QMessageBox_No)
		result = exec()
		win1
		{
			if result = QMessageBox_Yes
					q= "update `user_data` set `page_id`=1,pages=3,clean=0,ayat_color='rgb(85,0,0)',number_color='rgb(44,45,0)',aya_block=0,im=0,snoozeTo='2000-12-31 00:00:00',timeEnd='01',timeStart='23'"
					query.exec(q)
					thePageData(1)
					setPageData()
					tab1.setCurrentIndex(0)
			but result = QMessageBox_No
				dialogDef.close()
			ok
		}
	}