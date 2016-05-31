load "guilib.ring"
load "includes/globals.ring"

pODBC = odbc_init()
if isLinux()
	n=odbc_connect(pODBC,'DRIVER=SQLite3;Database=quran.db;LongNames=1;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;PRAGMA encoding = "UTF-8"; ')
but isWindows()
	n=odbc_connect(pODBC,'DRIVER=SQLite3 ODBC Driver;Database=quran.db;LongNames=1;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;PRAGMA encoding = "UTF-8"; ')
but IsAndroid()
	n= openOrCreateDatabase("quran.db",MODE_PRIVATE,null);
ok

if n!=1
	see nl+"** error connecting to databse **"+nl
	MyApp = New qApp
	{
        win1 = new qWidget()
		{
			new qmessagebox(win1) {
				setFixedWidth(300)
				setwindowtitle("وردي")
				settext("  مشغل sqlite غير مثبت  ")
				show()
			}
		}
		exec()
	}
	
else
	clean_only= isCleanText()
	pagesRead=pagesCount()
	werdHour= werdyTimers()
	ayat_color= getAyatColor()
	no_color= getNumColor()
	aya_block= aya_block_func()



	load "includes/wnd.ring"



	odbc_disconnect(pODBC)
	odbc_close(pODBC)

ok


func nextClicked
	p= (1*page)+1
	if p>604 p=1 ok
	thePageData(p)
	
func prevClicked
	p= (1*getCurrenpage())-(1*pagesCount())
	if p<1 p=1 ok
	see p+nl
	thePageData(p)

func thePageData px
	ayat=''
	im= get_img()
	for i=0 to (1*pagesCount())-1
		q= "select * from Quran q where `page`='"+ (px+i) +"'"
		odbc_execute(pODBC, q)
		if( (px+i)%2 ) d="left" else d="right" ok
		ayat+='<p style="text-align:'+d+';" class="pageNum"><span>'+ (px+i) +'</span></p>'
		ayat+="<p class='pageText'>"
		while odbc_fetch(pODBC)
			theid= 1*(odbc_getdata(pODBC,1))
			aya_no= 1*(odbc_getdata(pODBC,3))
			suraid = 1*(odbc_getdata(pODBC,2))
			joz= odbc_getdata(pODBC,5)
			page= odbc_getdata(pODBC,4)
			suraName= odbc_getdata(pODBC,8)
			sura  =suraName
			
			if(aya_no = 1)
				ayat += "</p><h2 style='color:blue;padding:0px; margin:0px;' align=center>("+ suraName +")</h2><p class='pageText'>" 
			ok
			
			if(clean_only=1)
				aya_text=odbc_getdata(pODBC,9)
			else
				aya_text= odbc_getdata(pODBC,7)
			ok
			
			if(im=theid)
				aya_text= "<span style='background-color:#FFEFD5;'>"+aya_text+"</span>"
			ok
			
			ayat +=  aya_text+ " <span style='color:"+no_color+";' class='ayaNum'>"+ aya_no +"</span> " 
			
			if(aya_block=1)
				ayat+="<br />"
			ok
			
			
		end
		ayat+="</p>"
	next
	setPageData()
	odbc_execute(pODBC, "update user_data set `page_id`='"+ px +"'")
	
func goIndex
	rpage= Table1.currentRow()
	rpage=1+(1*rpage)
	
	odbc_execute(pODBC, "select `page` from Quran where `SuraID`='"+ rpage +"'")
	odbc_fetch(pODBC)
	page= (1*odbc_getdata(pODBC,1))
	thePageData(page)
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
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	thelastpage  =odbc_getdata(pODBC,1)
	return thelastpage

	
	

func pagesCount
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	pagesRead  =odbc_getdata(pODBC,2)
	return 1*pagesRead
	
func werdyTimers
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	werdHour  =odbc_getdata(pODBC,3)
	return 1*werdHour
	

func isCleanText
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	clean_only  =odbc_getdata(pODBC,4)
	return clean_only

func getAyatColor
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	ayat_color  =odbc_getdata(pODBC,5)
	return ayat_color
	
	
func get_img
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	im  =odbc_getdata(pODBC,8)
	return 

func getStartTime
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	r  =odbc_getdata(pODBC,10)
	return r

func getEndTime
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	r  =odbc_getdata(pODBC,11)
	return r
	
func getNumColor
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	no_color  =odbc_getdata(pODBC,6)
	return no_color

func aya_block_func
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	aya_block  =odbc_getdata(pODBC,7)
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
		
		odbc_execute(pODBC, "update `user_data` set `pages`='"+setNewPages+"', `minutes`='"+ setNewMinutes +"', `clean`='"+ clean_only +"', `aya_block`='"+aya_block+"', `timeEnd`='"+timeStart+"' , `timeStart`='"+timeEnd+"'")
		tab1.setCurrentIndex(0)
	ok
	ayatHTML.reload()

func getCurrenpage
	odbc_execute(pODBC, "select * from user_data")
	odbc_fetch(pODBC)
	cpage  =odbc_getdata(pODBC,1)
	return 1*cpage
	
func searchindex
	m= table2.setRowCount(0)
	searchTextResult= searchtxtBox.text()
	/*n1= QStringList
	str= n1::fromLatin1('3\xb7')
	see n+nl*/
	if searchTextResult != ''
		qx= new QObject
		q= "select * from `Quran` where `clean` like '%" + searchTextResult + "%'"
		see q+nl
		i=0
		odbc_execute(pODBC, q)
		while odbc_fetch(pODBC)
			cleanAyatSearch=odbc_getdata(pODBC,9)
			suraSearch=odbc_getdata(pODBC,8)
			pageSearch=odbc_getdata(pODBC,4)
			VerseIDSearch=odbc_getdata(pODBC,3)
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
	searchTextResult= searchtxtBox.text()
	rpage= table2.currentRow()
	q= "select * from `Quran` where `clean` like '%" + searchTextResult + "%' limit "+rpage+",1"
	odbc_execute(pODBC, q)
	odbc_fetch(pODBC)
	p= 1*(odbc_getdata(pODBC,4))
	ayatID= 1*(odbc_getdata(pODBC,1))
	odbc_execute(pODBC, "update `user_data` set `im`='"+ayatID +"'")
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
	see "Housr : "+nHour +" "+s1+ " "+s2 + nl
	if(nHour>= s1 )
		odbc_execute(pODBC, "select snoozeTo, datetime() as t ,(case when snoozeTo> datetime() then '0' else '1' end ) as re from user_data")
		odbc_fetch(pODBC)
		cdate  =1*odbc_getdata(pODBC,3)
		csnooze =odbc_getdata(pODBC,1)
		cnow =odbc_getdata(pODBC,2)
		
		if cdate=1
			see "start Read !"+nl
			win1.showNormal()
			pagea1=getCurrenpage()
			pagea2=getCurrenpage()+pagesCount()
			nextpage= pagea1+pagesCount()
			if nextpage>604 nextpage=1 ok
			thePageData(nextpage)
			setPageData()
			tab1.setCurrentIndex(0)
			win1.activateWindow()
		else
			//see nl+"** Snoozed to : "+ csnooze +"**"+nl;
			see "snoozed "+csnooze+" (now : "+cnow+")"+nl
		ok
	ok
Func changeAyatColor
	cobj= new qcolordialog()
    ccolor= cobj.GetColor()
    r=ccolor[1] g=ccolor[2] b=ccolor[3]
    //ayatText.setstylesheet("color: rgb("+r+", " + g+ "," + b + ")")
	ayat_color="rgb("+r+", " + g+ "," + b + ")"
	q="update `user_data` set `ayat_color`='"+ayat_color+"'"
	odbc_execute(pODBC, q)
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
	odbc_execute(pODBC, q)
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
		exec()
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
	odbc_execute(pODBC, q)
	
	pagea1=getCurrenpage()
	pagea2=getCurrenpage()-pagesCount()
	prevpage= pagea1+pagesCount()
	if prevpage<1 prevpage=1 ok
	odbc_execute(pODBC, "update `user_data` set `pageID`='"+prevpage +"'")
	snoozW.close()
	hiddenMode()
	
func WerdContRead
	q="update `user_data` set `snoozeTo`= '2100-12-31 00:00:00'"
	odbc_execute(pODBC, q)
	
func SnoozeReading
	load "includes/snooze.wnd.ring"
	
func werdyDir
	cDir= currentdir()
	return cDir+DS