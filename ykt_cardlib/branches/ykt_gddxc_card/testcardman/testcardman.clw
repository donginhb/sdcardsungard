; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CTestcardmanDlg
LastTemplate=CWinThread
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "testcardman.h"

ClassCount=4
Class1=CTestcardmanApp
Class2=CTestcardmanDlg
Class3=CAboutDlg

ResourceCount=3
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Class4=CNewCardThread
Resource3=IDD_TESTCARDMAN_DIALOG

[CLS:CTestcardmanApp]
Type=0
HeaderFile=testcardman.h
ImplementationFile=testcardman.cpp
Filter=N
BaseClass=CWinApp
VirtualFilter=AC
LastObject=CTestcardmanApp

[CLS:CTestcardmanDlg]
Type=0
HeaderFile=testcardmanDlg.h
ImplementationFile=testcardmanDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=CTestcardmanDlg

[CLS:CAboutDlg]
Type=0
HeaderFile=testcardmanDlg.h
ImplementationFile=testcardmanDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_TESTCARDMAN_DIALOG]
Type=1
Class=CTestcardmanDlg
ControlCount=34
Control1=IDC_STATIC,button,1342177287
Control2=IDC_COM_PORT,combobox,1344340227
Control3=IDC_COM_BAND,combobox,1344339971
Control4=IDC_BTN_COM,button,1342242816
Control5=IDC_BTN_AUTH,button,1342242816
Control6=IDC_INIT_CARD,button,1342242816
Control7=IDC_REFIND_CARD,button,1342242816
Control8=IDCANCEL,button,1342242816
Control9=IDC_RESET_AUTH_CARD,button,1073807360
Control10=IDC_START_SECT,edit,1082196096
Control11=IDC_SPIN_START_SECT,msctls_updown32,1073741878
Control12=IDC_END_SECT,edit,1082196096
Control13=IDC_SPIN_END_SECT,msctls_updown32,1073741878
Control14=IDC_GET_BLOCK0,button,1073807363
Control15=IDC_GET_BLOCK1,button,1073807363
Control16=IDC_GET_BLOCK2,button,1073807363
Control17=IDC_GET_BLOCK3,button,1073807363
Control18=IDC_TEST_CARD,button,1342242816
Control19=IDC_BTN_CLEAR,button,1342242816
Control20=IDC_STATIC,button,1073741831
Control21=IDC_STATIC,static,1342308354
Control22=IDC_STATIC,static,1342308354
Control23=IDC_STATIC,button,1073741831
Control24=IDC_LOG_MSG,listbox,1353777409
Control25=IDC_STATIC,static,1073872896
Control26=IDC_STATIC,static,1073872896
Control27=IDC_STATIC,static,1073872896
Control28=IDC_AUTHKEY,combobox,1075904771
Control29=IDC_MANUAL_AUTH,button,1073807360
Control30=IDC_SHOWCARD_NO,edit,1350631552
Control31=IDC_STATIC,static,1342308352
Control32=IDC_COMBO_SELECTCARD,combobox,1344339971
Control33=IDC_COM_CARD_TYPE,combobox,1075904515
Control34=IDC_STATIC,static,1073872896

[CLS:CNewCardThread]
Type=0
HeaderFile=testcardmandlg.h
ImplementationFile=testcardmandlg.cpp
BaseClass=CWinThread
Filter=D
LastObject=CNewCardThread
VirtualFilter=TC

