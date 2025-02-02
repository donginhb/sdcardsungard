; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CRfTestDlg
LastTemplate=CWinThread
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "RfTest.h"

ClassCount=5
Class1=CRfTestApp
Class2=CRfTestDlg
Class3=CAboutDlg

ResourceCount=3
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Class4=CReadCard
Class5=Creadcard
Resource3=IDD_RFTEST_DIALOG

[CLS:CRfTestApp]
Type=0
HeaderFile=RfTest.h
ImplementationFile=RfTest.cpp
Filter=N
LastObject=CRfTestApp

[CLS:CRfTestDlg]
Type=0
HeaderFile=RfTestDlg.h
ImplementationFile=RfTestDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=CRfTestDlg

[CLS:CAboutDlg]
Type=0
HeaderFile=RfTestDlg.h
ImplementationFile=RfTestDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=14
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,static,1342308352
Control7=IDC_STATIC,static,1342308352
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352
Control10=IDC_STATIC,static,1342308352
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_STATIC,button,1342177287

[DLG:IDD_RFTEST_DIALOG]
Type=1
Class=CRfTestDlg
ControlCount=71
Control1=IDC_STATIC,button,1342177287
Control2=IDC_STATIC,button,1342177287
Control3=IDC_STATIC,button,1342177287
Control4=IDC_RADIO_ASY,button,1342308361
Control5=IDC_RADIO_SYN,button,1342177289
Control6=IDC_BUTTON_OPEN,button,1342242816
Control7=IDC_BUTTON_CLOSE,button,1342242816
Control8=IDC_BUTTON_START,button,1342242816
Control9=IDC_STATIC,button,1342177287
Control10=IDC_BUTTON_INIT,button,1342242816
Control11=IDC_BUTTON_ADD1,button,1342242816
Control12=IDC_BUTTON_DEC1,button,1342242816
Control13=IDC_BUTTON_READDATA,button,1342242816
Control14=IDC_BUTTON_WRITEDATA,button,1342242816
Control15=IDC_STATIC,button,1342177287
Control16=IDC_RESP_MSG,edit,1350631552
Control17=IDC_ERR_MSG,edit,1350631552
Control18=IDC_STATIC,button,1342177287
Control19=IDC_WRITE_BUF,edit,1350631552
Control20=IDC_START_WRITE,button,1342242816
Control21=IDC_OPENCOM,button,1342242816
Control22=IDC_POWERUP,button,1342242816
Control23=IDC_POWERDOWN,button,1342242816
Control24=IDC_STOPOPER,button,1073807360
Control25=IDC_SOFTREST,button,1342242816
Control26=IDC_READPOWERUP,button,1073807360
Control27=IDC_READTRACK2,button,1342251008
Control28=IDC_READTRACK3,button,1342242816
Control29=IDC_READTRACK23,button,1342242816
Control30=IDC_READSTATE,button,1342242816
Control31=IDC_READEDITION,button,1342242816
Control32=IDC_READRANDOM,button,1342242816
Control33=IDC_READWRITE,button,1342242816
Control34=IDC_CARDTYPE,combobox,1344340226
Control35=IDC_STATIC,static,1342308352
Control36=IDC_STATIC,static,1342308352
Control37=IDC_WAITTIME,edit,1350631552
Control38=IDC_STATIC,static,1342308352
Control39=IDC_TRACKNUM,edit,1350631552
Control40=IDC_STATIC,static,1342308352
Control41=IDC_CMDDATA,edit,1350631552
Control42=IDC_OUTDATA,edit,1350631428
Control43=IDC_STATIC,button,1342177287
Control44=IDC_STATIC,button,1342177287
Control45=IDC_BUTTON_LOOP,button,1342242816
Control46=IDC_BUTTON_EXITLOOP,button,1342242816
Control47=IDC_STATIC,static,1342308352
Control48=IDC_STATIC_,static,1342308352
Control49=IDC_STATIC_NUM,static,1342308352
Control50=IDC_COMBO_COMPORT,combobox,1344340227
Control51=IDC_COMBO_ICCOM,combobox,1344340226
Control52=IDC_OUT_TRACK2,edit,1350631552
Control53=IDC_BUTTON_CARDCLOSE,button,1342242816
Control54=IDC_BUTTON_CLEARBUF,button,1342242816
Control55=IDC_ICCARD_LOOP,button,1342242816
Control56=IDC_CARD_EXITLOOP,button,1342242816
Control57=IDC_BUTTON_END,button,1342242816
Control58=IDC_RFCARD_END,button,1342242816
Control59=IDC_EDIT_KEY,edit,1350631552
Control60=IDC_STATIC,static,1342308352
Control61=IDC_STATIC,static,1342308352
Control62=IDC_RADIO_KEYA,button,1342308361
Control63=IDC_RADIO_KEYB,button,1342177289
Control64=IDC_STATIC,static,1342308352
Control65=IDC_EDIT_SECTOR,edit,1350631552
Control66=IDC_EDIT_BLOCK,edit,1350631552
Control67=IDC_RADIO_STANDARDCARD,button,1342308361
Control68=IDC_RADIO_UNSTANDARDCARD,button,1342177289
Control69=IDC_BUTTON_READNO,button,1342242816
Control70=IDC_BUTTON_REQUEST,button,1073807360
Control71=IDC_BUTTON_ANTICOLL,button,1073807360

[CLS:CReadCard]
Type=0
HeaderFile=ReadCard.h
ImplementationFile=ReadCard.cpp
BaseClass=CWinThread
Filter=N
VirtualFilter=TC
LastObject=CReadCard

[CLS:Creadcard]
Type=0
HeaderFile=readcard1.h
ImplementationFile=readcard1.cpp
BaseClass=CWinThread
Filter=N
LastObject=Creadcard

