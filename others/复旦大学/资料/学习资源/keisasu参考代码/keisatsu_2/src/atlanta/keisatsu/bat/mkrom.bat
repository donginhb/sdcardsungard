ECHO OFF
REM ----------------------------------------------------------------
REM	HINOROM.BAT For HINOKI3
REM	1998/10/01  By H.Hirao
REM		ＲＯＭイメージ作成用バッチ・ファイル
REM ----------------------------------------------------------------

set ROOT=
set BATCHNAME=%0
if "%DOS16M%" == ""	goto	SET_DOS16M
goto START

:SET_DOS16M
rem set DOS16M=1,@5M:1024
set DOS16M=0,@5M:1024

:START
set MSG=0

rem		実行ドライブチェック
if exist \src\atlanta\define\product.h		goto DRV_OK
	echo [1;33mカレントのドライブ(ボリューム)が違います[0m
	echo [1;33mArisa\usr2で実行して下さい[0m
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
if "%3"==""		goto	NONAME
goto NEXT3

:NONAME
ECHO [バージョン名を指定して下さい！]
goto	ENDHELP

:NEXT3

set ROOT=\src\atlanta
set MACHINE=%1
set COUNTRY=%2
set WORK_DIRECTORY=\src\atlanta\%MACHINE%\work\%COUNTRY%\rom

cd	%WORK_DIRECTORY%
echo "****************************************************************" >> %BATCHNAME%.log
REM systime >> %WORK_DIRECTORY%\%BATCHNAME%.log
echo "%0 %1 %2 %3 %4 %5 %6 %ID%が上記の時刻にＲＯＭを作成開始" >> %BATCHNAME%.log
echo "****************************************************************" >> %BATCHNAME%.log

if exist \src\atlanta\%MACHINE%\work\%COUNTRY%\%MACHINE%.abs		goto VOL_OK
	echo [%1.abs がありません[0m
	goto	END
:VOL_OK

echo on
rem ncopy ..\%MACHINE%.abs %3.abs
rem ncopy ..\%MACHINE%.map %3.map
rem Windows NT?でncopyができないのでxcopyに変更 by H.Hirao 1999/05/13
rem xcopy ..\%MACHINE%.abs %3.ABS /V /F
rem xcopy ..\%MACHINE%.map %3.MAP /V /F
copy ..\%MACHINE%.abs %3.ABS
copy ..\%MACHINE%.map %3.MAP

:MakeMotFile
cnvs %3.abs %3.mot
echo off

if errorlevel 1 goto ERROR

echo on
rem mot2bin %3.mot %3.cpu /f >> %BATCHNAME%.log
if "%4" == "CPU"	goto MAKE_CPU
goto NEXT4

:MAKE_CPU
CPUのＲＯＭ作成
mot2binr 0 4 %3.mot %3.cpu /f >> %BATCHNAME%.log
lha a -w- %3 %WORK_DIRECTORY%\%3.cpu

:NEXT4
makebin 3 200000 11DE000 %3.mot %3.rom
rem mot2binr 200000 1 %3.mot %3.rom /f >> %BATCHNAME%.log
rem mot2binr 1000000 1 %3.mot %3.rom /f >> %BATCHNAME%.log

REM 後でLevel7で圧縮するので，
REM ここでLevel5で圧縮する必要はありません
REM lha a -w- %3 %WORK_DIRECTORY%\%3.abs
REM rem lha a -w- %3 %WORK_DIRECTORY%\%3.obj
REM lha a -w- %3 %WORK_DIRECTORY%\%3.map
REM rem lha a -w- %3 %WORK_DIRECTORY%\%3.mot

:END_MSG
echo off
rem echo [1;42;37mCPUのバージョン[0m
rem checkver %3.cpu 1000
echo [1;42;37mROMのバージョン[0m
checkver %3.rom 0
echo [1;42;37m焼く前に確認してください!![0m
divide8 %3.rom %3.rm0 %3.rm1

REM 後でLevel7で圧縮するので，
REM ここでLevel5で圧縮する必要はありません
REM lha a -w- %3 %WORK_DIRECTORY%\%3.rm0
REM lha a -w- %3 %WORK_DIRECTORY%\%3.rm1
echo .
REM sumcheck %3.rm0
REM sumcheck %3.rm1
sumcheck %3.rm?
copy readme.doc readme.txt
echo [1;42;37m◎警察ＦＡＸのＲＯＭできました！！[0m [1;37m＼(^o^)／[0m
goto END1

:ERROR
echo [1;37;41m警察ＦＡＸのＲＯＭ作成は異常終了しました[0m[1;37m(-_-x[0m
goto END1

:ENDHELP
ECHO "HINOFLA [ﾓﾃﾞﾙ名] [国名] [ﾊﾞｰｼﾞｮﾝ名] [(CPU)]"
ECHO モデル名，国名, バージョン名 は大文字で入力して下さい
ECHO ＣＰＵ内蔵ＲＯＭイメージが必要な場合、ＣＰＵと付けて下さい
goto END3


:END1
cd %WORK_DIRECTORY%
:END2
REM systime >> %WORK_DIRECTORY%\%BATCHNAME%.log
echo "%0 %1 %2 %3 %4 %5 %6 %ID%が上記の時刻にＲＯＭ作成を終了" >> %BATCHNAME%.log

rem motは要らないので削除する
del %3.mot

REM 後でLZHで圧縮するので消されては困る
REM rem abs map romも要らないので削除する
REM del %3.abs
REM del %3.map
REM rem del %3.rom

goto END3
set MACHINE=
set COUNTRY=
set S_MK=
set CHECK=
set MSG=
set ROOT=
set WORK_DIRECTORY=
set BATCHNAME=

:END3
ECHO ON

