ECHO OFF
REM ----------------------------------------------------------------
REM	ATLMK.BAT For Poplar/Anzu_L
REM
REM		Ｍａｋｅ用バッチ・ファイル
REM
REM		M.Kotani
REM		1996/10/23 From APRCT.BAT
REM ----------------------------------------------------------------

set ROOT=
set BATCHNAME=%0
set ID=%USERNAME%

if "%DOS16M%" == ""	goto	SET_DOS16M
goto START

:SET_DOS16M
rem set DOS16M=1,@5M:1024
rem set DOS16M=0,@5M:3M

:START
set MSG=0

rem		実行ドライブチェック
if exist \src\atlanta\define\product.h		goto DRV_OK
	echo [1;33mカレントのドライブ(ボリューム)が違います[0m
	echo [1;33mArisa\usr1で実行して下さい[0m
	goto ENDHELP
:DRV_OK


if "%1"=="KEISATSU"		goto	NEXT1
ECHO [モデル名の指定が違います]
goto	ENDHELP

:NEXT1

if "%2"=="JPN"	goto	NEXT2
ECHO [国名の指定が違います]
goto	ENDHELP

:NEXT2
set ROOT=\src\atlanta
set MACHINE=%1
set COUNTRY=%2
set WORK_DIRECTORY=\src\atlanta\%MACHINE%\work\%COUNTRY%

REM WORK_DIRECTORY
cd	%WORK_DIRECTORY%
REM systime >> %WORK_DIRECTORY%\%BATCHNAME%.log
echo "%0 %1 %2 %3 %4 %5 %6 %ID%が上記の時刻にメイクを開始" >> %BATCHNAME%.log

REM	by O.kimoto 1997/06/12
set MDM_R288F=2

REM	by O.kimoto 1997/08/12
set OPR_KANJI=0

REM ﾌﾟﾘﾝﾀの切り分け
set MDM_SP322=2

REM	ＨＩＮＯＫＩ固有データメイク	/*  By O.Kimoto 1998/09/21 */
set HINOKI_DATA=1

REM	ナンバーディスプレイのメイク by H.Hirao 1999/01/12
set ND=0
if "COUNTRY"=="JPN"			set ND=1
if "COUNTRY"=="HONCHO"		set ND=1
if "COUNTRY"=="KOBAN"		set ND=1

rem SHIFT
set S_MK=0


if "%3"=="ON"		goto	MESSAGE_ON
goto MODULE_CHECK

:MESSAGE_ON
set MSG=1
SHIFT
goto MODULE_CHECK

:MODULE_CHECK
if "%3"==""			goto	ALL_MODULE
if "%3"=="STOP"		goto	TERMINATE
if "%3"=="LOCATE"	goto	LOCATE_EXEC
if "%3"=="IFAX"	goto	NOREGIST
if "%3"=="SHDATA"	goto	NEW_MASK_MODULE
if "%3"=="SHTABLE"	goto	NEW_MASK_MODULE
if "%3"=="INI"		goto	NEW_MASK_MODULE
if "%3"=="MON"		goto	NEW_MASK_MODULE
if "%3"=="SCD"		goto	NEW_MASK_MODULE
if "%3"=="INT"		goto	NEW_MASK_MODULE
if "%3"=="HINO_INT"	goto	NEW_MASK_MODULE
goto	COMMON_MODULE

:NOREGIST
ECHO あなたの指定したモジュールは、メイクバッチファイルに登録されていません。
ECHO atlmkの全体メークに追加してください。その後この処理を解除してください。
goto	END


:COMMON_MODULE
rem --------------------------------
rem	 ＣＰＵ共通モジュール別のリンク
rem --------------------------------
ECHO [" %3 " モジュールのリンク]
if "%3" == "MDM" goto MDM_MAKE
if "%3" == "mdm" goto MDM_MAKE
 nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\%3.mk
if errorlevel 1 goto ERROR
goto	CHECK_OTHER_LINK

:UNIQUE_MODULE
rem --------------------------------
rem	 ＣＰＵ依存モジュール別のリンク
rem --------------------------------
ECHO [" %MACHINE%  %3 " モジュールのリンク]
 nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\%3.mk
if errorlevel 1 goto ERROR
goto	CHECK_OTHER_LINK

:NEW_MASK_MODULE
rem --------------------------------
rem	 ＣＰＵ依存モジュール別のリンク
rem --------------------------------
ECHO [" %MACHINE%  %3 " モジュールのリンク]
 nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" \src\cpu\sh7043_a\make\%3.mk
if errorlevel 1 goto ERROR
goto	CHECK_OTHER_LINK

:COUNTRY_MODULE
rem ----------------------------------
rem	 各国仕様依存モジュール別のリンク
rem ----------------------------------
ECHO [" %MACHINE%  %COUNTRY% %3 " モジュールのリンク]
 nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\%3.mk
if errorlevel 1 goto ERROR
goto	CHECK_OTHER_LINK

:CHECK_OTHER_LINK
set S_MK=1
rem echo --------------------------------
rem echo  他のモジュールもリンクしますか
rem echo --------------------------------
SHIFT
goto	MODULE_CHECK

:ALL_MODULE
if "%S_MK%"=="1" GOTO ALL_LINK

rem -----------------------------
rem	 ATLANTA 共通モジュール
rem -----------------------------
ECHO [ATLANTA ダイヤラ モジュール（ＡＴＤ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\ATD.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 符号処理 モジュール（ＣＤＣ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\CDC.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 共通関数 モジュール（ＣＭＮ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\CMN.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 共通データ モジュール（ＤＡＴＡ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\DATA.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 通信手順 モジュール（ＦＣＭ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\FCM.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 通信コンパチチェック モジュール（ＦＣＭ＿Ｃ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\FCM_COMP.mk
if errorlevel 1 goto ERROR

rem ＨＩＮＯＫＩはＩＤＰは使用しません。By O.Kimoto 1998/09/07
rem ECHO [ATLANTA 画像処理 モジュール（ＩＤＰ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\IDP.mk
rem if errorlevel 1 goto ERROR

ECHO [ATLANTA リスト モジュール（ＬＳＴ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\lst.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA リストワーディング モジュール（ＬＳＴ＿ＷＲＤ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\lstword.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 共通メイン モジュール（ＭＡＮ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MAN.mk
if errorlevel 1 goto ERROR

rem ECHO [ATLANTA モデム モジュール（ＭＤＭ）のリンク]	機種依存の方に持っていく 1997/02/15	 By T.Yamaguchi
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MDM.mk
rem if errorlevel 1 goto ERROR

ECHO [ATLANTA メモリ管理 モジュール（ＭＥＭ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MEM.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 回線監視モジュール（ＮＣＵ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\NCU.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA オペレーション モジュール（ＯＰＲ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\OPR.mk
rem if errorlevel 1 goto ERROR

ECHO [ATLANTA 表示ワーデッング モジュール（ＯＰＲ＿ＷＲＤ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\OPRWORD.mk
if errorlevel 1 goto ERROR

#ECHO [ATLANTA ジャーナル特許 モジュール（ＰＡＴ）のリンク]
#nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\pat.mk
#if errorlevel 1 goto ERROR

ECHO [ATLANTA プリンタ モジュール（ＰＲＮ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\PRINT.mk
rem if errorlevel 1 goto ERROR

rem HINOKIはスキャナーは別モジュールです。
rem ECHO [ATLANTA スキャナ モジュール（ＳＣＮ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\SCN.mk
rem if errorlevel 1 goto ERROR

ECHO [ATLANTA 共通ＲＯＭテーブル（ＴＡＢＬＥ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\TABLE.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA ＤＭＡ モジュール（ＤＭＡ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\DMA.mk
if errorlevel 1 goto ERROR

rem ECHO [ATLANTA ＤＰＲＡＭモジュール（ＤＰＲ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\DPR.mk
rem if errorlevel 1 goto ERROR

rem ECHO [ATLANTA 回転受信モジュール（ＲＯＴ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\ROT.mk
rem if errorlevel 1 goto ERROR

ECHO [ATLANTA S1モジュール（Ｓ１）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\s1.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA ２回線モジュール（ＭＵＬＴＩ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MULTI.mk
if errorlevel 1 goto ERROR

rem ECHO [ATLANTA クラス１モジュール（ＣＬ１）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\CL1.mk
rem if errorlevel 1 goto ERROR

REM ECHO [ATLANTA インターネットＦＡＸモジュール（ＩＦＡＸ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\IFAX.mk
rem if errorlevel 1 goto ERROR

ECHO [ATLANTA フラッシュ モジュール（ＦＬＡＳＨ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\FLASH.mk
if errorlevel 1 goto ERROR

rem -----------------------------
rem	 ATLANTA ＣＰＵ依存モジュール
rem -----------------------------
ECHO [ATLANTA ＣＰＵ依存データ モジュール（ＳＨＤＡＴＡ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" \src\cpu\sh7043_a\make\SHDATA.mk
if errorlevel 1 goto ERROR

rem ＨＩＮＯＫＩはＮｅｗＭａｓｋの為、Ｍａｋｅファイル変更
rem ECHO [ATLANTA スタート モジュール（ＩＮＩ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\INI.mk
rem if errorlevel 1 goto ERROR

ECHO [ATLANTA スタート モジュール（ＩＮＩ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" \src\cpu\sh7043_a\make\INI.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA 割込み モジュール（ＩＮＴ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" \src\cpu\sh7043_a\make\hino_int.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA モニタ モジュール（ＭＯＮ）のリンク]
rem ＨＩＮＯＫＩはＮｅｗＭａｓｋの為、Ｍａｋｅファイル変更
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" \src\cpu\sh7043_a\make\MON.mk
if errorlevel 1 goto ERROR

rem ECHO [ATLANTA ＣＰＵ依存テーブル（ＳＨＴＡＢＬＥ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" \src\cpu\sh7043_a\make\SHTABLE.mk
if errorlevel 1 goto ERROR

ECHO [ATLANTA ＳＣＤモジュール（ＳＣＤ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" \src\cpu\sh7043_a\make\SCD.mk
if errorlevel 1 goto ERROR

rem ECHO [ATLANTA ＪＢＩＧモジュール（ＪＢＧ）のリンク]
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\JBG.mk
rem if errorlevel 1 goto ERROR

rem -----------------------------
rem	 ATLANTA 機種依存モジュール
rem -----------------------------

if "%OPR_KANJI%"=="1" goto OPR_KANJI_MAKE

ECHO [ATLANTA ２行オペレーション モジュール（ＯＰＲ　ＡＮＫ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\OPR_ANK.mk
if errorlevel 1 goto ERROR
goto OPR_MAKE_END

:OPR_KANJI_MAKE
ECHO [ATLANTA ４行オペレーション モジュール（ＯＰＲ　ＫＡＮＪ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\OPR_KANJ.mk
if errorlevel 1 goto ERROR
goto OPR_MAKE_END

:OPR_MAKE_END
if "%MDM_SP322%"=="1" goto PRN_SP322_MAKE
if "%MDM_SP322%"=="2" goto PRN_IUTHERML_MAKE

ECHO [ATLANTA ＰＨ３プリンタ モジュール（ＰＲＮ＿ＰＨ３）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\PRN_PH3.mk
if errorlevel 1 goto ERROR
goto PRN_MAKE_END

:PRN_SP322_MAKE
ECHO [ATLANTA ＳＰ３２２プリンタ モジュール（ＰＲＮ＿ＳＰ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\PRN_SP.mk
if errorlevel 1 goto ERROR
goto PRN_MAKE_END

:PRN_IUTHERML_MAKE
ECHO [ATLANTA ＩＵ＿ＴＨＥＲＭＡＬプリンタ モジュールのリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\PRN_IUTH.mk
if errorlevel 1 goto ERROR
goto PRN_MAKE_END

:PRN_MAKE_END

:MDM_MAKE

if "%MDM_R288F%"=="1" goto MDM_R288F_MAKE
if "%MDM_R288F%"=="2" goto MDM_FM336_MAKE
if "%MDM_R288F%"=="3" goto MDM_MN195006		/* 松下モデムをリンクする */

:MDM_ORANGE_MAKE
ECHO [ATLANTA モデム モジュール（ＭＤＭ_ＯＲＮＧ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MDM_orng.mk
if errorlevel 1 goto ERROR
goto MDM_END

:MDM_R288F_MAKE
ECHO [ATLANTA モデム モジュール（ＭＤＭ_Ｒ２８８Ｆ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MDM_R288.mk
if errorlevel 1 goto ERROR
goto FCM_V34

:MDM_FM336_MAKE
ECHO [ATLANTA モデム モジュール（ＭＤＭ＿ＦＭ３３６）のリンク]
NMAKE "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MDM.mk
if errorlevel 1 goto ERROR
goto FCM_V34

:MDM_MN195006
ECHO [ATLANTA モデム モジュール（ＭＮ１９５００６）のリンク]
NMAKE "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\MDM_MN195006.mk
if errorlevel 1 goto ERROR


:FCM_V34
ECHO [ATLANTA モデム モジュール（ＦＣＭ＿Ｖ３４）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\FCM_V34.mk
if errorlevel 1 goto ERROR
goto MDM_END

:MDM_END

if "%HINOKI_DATA%"=="0" goto IU_DATA_END

:HINOKI_DATA_START
ECHO [HINOKI 固有データのリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\iu_data.mk
if errorlevel 1 goto ERROR

ECHO [ＨＩＮＯＫＩ ＳＣＮモジュールリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\scn_hino.mk
if errorlevel 1 goto ERROR

goto IU_DATA_END

:IU_DATA_END


if "%MDM_R288F%"=="3" goto ND_MN195006		/* 松下モデムをリンクする */
goto ND_FM336

:ND_FM336
ECHO [ATLANTA ＮｕｍｂｅｒＤｉｓｐｌａｙ（ＮＤ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\nd_336.mk
if errorlevel 1 goto ERROR

goto ND_END


:ND_MN195006
ECHO [ATLANTA ＮｕｍｂｅｒＤｉｓｐｌａｙ（ＮＤ）のリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\nd_195006.mk
if errorlevel 1 goto ERROR

goto ND_END


:ND_END

goto	ALL_LINK

:ALL_LINK
rem ##################################By M.Tachibana 1998/06/02
if "%COUNTRY%"=="JP1" goto ALL1_LINK
if "%COUNTRY%"=="JP2" goto ALL1_LINK
rem ##################################
rem ---------------------
rem	 ATLANTA 全体 リンク
rem ---------------------
ECHO [ATLANTA 全体モジュールのリンク]
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\%MACHINE%.mk
if errorlevel 1 goto ERROR

rem ##################################
goto LOCATE_EXEC
:ALL1_LINK
rem nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\%COUNTRY%\%MACHINE%.mk
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" "DEBUG=NONE" %ROOT%\make\%MACHINE%.mk
if errorlevel 1 goto ERROR
rem ##################################

ECHO [ATLANTA のリンク]
:LOCATE_EXEC
rem ##################################By M.Tachibana 1998/06/02
rem if "%COUNTRY%"=="JP1" goto LOCATE1_EXEC
if "%COUNTRY%"=="JP2" goto LOCATE1_EXEC
rem ##################################
rem LOCATE が同時に２カ所で実行されないようにする対策
IF EXIST LOCKFILE.TXT goto NOW_MAKING
echo "現在ＭＡＫＥを実行しているのは %ID%さんです。"> LOCKFILE.TXT
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" %ROOT%\make\loc
if errorlevel 1 goto ERROR

rem ##################################
goto CHECK_DUPLICATE_SYMBOL
:LOCATE1_EXEC
nmake "MODEL=%MACHINE%" "COUNTRY=%COUNTRY%" %ROOT%\make\%COUNTRY%\loc
if errorlevel 1 goto ERROR
rem ##################################

:CHECK_DUPLICATE_SYMBOL
rem --------------------------------------
rem	 デュープリケート・シンボルのチェック
rem --------------------------------------
ECHO [Check Duplicate Symbol]
bgrep -n CANNOT %WORK_DIRECTORY%\%MACHINE%.map > %WORK_DIRECTORY%\Diff.txt
bgrep -n UNDEFINED %WORK_DIRECTORY%\%MACHINE%.map >> %WORK_DIRECTORY%\Diff.txt
bgrep -n DUPLICATE %WORK_DIRECTORY%\%MACHINE%.map >> %WORK_DIRECTORY%\Diff.txt
if errorlevel 1 goto END_MSG
goto END_ERR



:END_ERR
echo Duplicate Duplicate Symbolがあります(-_-ﾒ)
echo %WORK_DIRECTORY%\Diff.txtで確認してください
if "%MSG%"=="0" goto END
rem net send "Error to Duplicate & C_COMMON" %ID% >nul
goto END



:END_MSG
echo ◎Ｍａｋｅできました！！＼(^o^)／
echo 
rem net send "Ｍａｋｅは正常終了しました。" %ID% >nul
if "%MSG%"=="0" goto END
rem net send "%MACHINE% %COUNTRY% の Make は正常終了" %ID% >nul
goto	END



:ERROR
rem	net send "Ｍａｋｅは異常終了しました。" %ID% >nul
echo Ｍａｋｅは異常終了しました(-_-x
if "%MSG%"=="0" goto END
rem net send "%MACHINE% %COUNTRY% の Make は異常終了" %ID% >nul
goto	END



:ENDHELP
ECHO "ﾓｼﾞｭｰﾙﾒｲｸ    ＋ﾛｹｰﾀｰ −＞ ATLMK [ﾓﾃﾞﾙ名] [国名] <ﾒｯｾｰｼﾞON> <ﾓｼﾞｭｰﾙ名>"
ECHO "全体ﾒｲｸ      ＋ﾛｹｰﾀｰ −＞ ATLMK [ﾓﾃﾞﾙ名] [国名] <ﾒｯｾｰｼﾞON>"
ECHO "             ＋ﾛｹｰﾀｰ −＞ ATLMK [ﾓﾃﾞﾙ名] [国名] <ﾒｯｾｰｼﾞON> <LOCATE>"
ECHO "ﾓｼﾞｭｰﾙﾒｲｸのみ        −＞ ATLMK [ﾓﾃﾞﾙ名] [国名] <ﾒｯｾｰｼﾞON> <ﾓｼﾞｭｰﾙ名> <STOP>"
ECHO "ﾓｼﾞｭｰﾙﾒｲｸ+*.COD      −＞ ATLMK [ﾓﾃﾞﾙ名] [国名] <ﾒｯｾｰｼﾞON> <ﾓｼﾞｭｰﾙ名> <STOP>"
ECHO "_________________________________________________________________________"
ECHO モデル名，国名, モジュール名 は大文字で入力して下さい
ECHO モジュールは複数個指定出来ます
ECHO 一部分だけメイクしたい場合には[モジュール名]の後に[ＳＴＯＰ]と入力してください。
ECHO ＊．ＣＯＤファイルが欲しい場合も同様に[モジュール名]の後に[ＳＴＯＰ]と入力してください。
ECHO ロケーターだけ実行したい場合には、[ＬＯＣＡＴＥ]と入力してください。
ECHO メイクの終了のメッセージを送りたい方は[国名]の後に[ON]と入力してください。
if "%MSG%"=="0" goto END2
rem net send "入力間違いです。" %ID% >nul
goto END3

:NOW_MAKING
if "%MSG%"=="0" goto MAKING1
rem net send "現在、他の人がＭＡＫＥ中です。" %ID% >nul
:MAKING1
ECHO 現在、以下の人がＭＡＫＥ中です。
type lockfile.txt
goto END2

:TERMINATE
if "%MSG%"=="0" goto MSG_TERMINATE
rem net send "指定分のメイクは正常終了しました。" %ID% >nul
:MSG_TERMINATE
ECHO 指定分のメイクは正常終了しました。
goto END2

:END
cd %WORK_DIRECTORY%
REM By Eguchi 1996/02/19 del *.cod
REM del *.cod
del lockfile.txt
:END2
REM systime >> %WORK_DIRECTORY%\%BATCHNAME%.log
echo "		%0 %1 %2 %3 %4 %5 %6 %ID%が上記の時刻にメイクを終了" >> %BATCHNAME%.log

goto END3

:END3
set MACHINE=
set COUNTRY=
set S_MK=
set MSG=
set ROOT=
set WORK_DIRECTORY=
set BATCHNAME=
set MDM_SP322=
set MDM_R288F=
set OPR_KANJI=
ECHO ON

