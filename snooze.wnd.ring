FavWin = New qApp {
	
		snoozW = new qWidget() 
		{
			setparent(win1)
			setwindowflags( qt_dialog & ~ qt_WindowMaximizeButtonHint & qt_SubWindow)
			setwindowmodality(true)
			setwindowtitle("وردي - تأجيل القراءة")
			setwinicon(self,"images/kuran.png")
			setStyleSheet("background-image:url('images/islamic-star.png');font-family:Tahoma, Verdana, Segoe, sans-serif")
			
			
			
			snoozeTextLabel = new qLabel(snoozW) {settext("قم بتأجيل القرآءة مدة : ")}	
			
			
			snoozeCombo= New QComboBox(snoozW) 
			{
				alist = ["15 دقيقة", "نصف ساعة","ساعة", "ساعتين","حتى الغد", "تشغيل يدوي"]
				for x in alist additem( ""+x,0) next
			}
			
			snoozNowBtn= new qPushButton(snoozW) {
				settext("تأجيل")
				setclickevent("SnoozeNow()")
				setStyleSheet("qproperty-icon: url('images/apply.png')")
			}
			snoozeTextNotice = new qLabel(snoozW) {settext("  في حالة التشغيل اليدوي يتم إعادة تشغيل الورد من الإعدادات  ")}
			
			layoutSnooze1= new qHBoxLayout()
			{
				addWidget(snoozeCombo)
				addWidget(snoozeTextLabel)
			}
			
			layoutSnooze2= new qVBoxLayout(snoozW)
			{
				addLayout(layoutSnooze1)
				addWidget(snoozNowBtn)
				addWidget(snoozeTextNotice)
			}
			
			
			setLayout(layoutSnooze2)
			show()
		}
	}