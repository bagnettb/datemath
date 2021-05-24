::
:: DateMath, a general purpose date count-down routine that 
::           counts days between current day and other specific
::           days
::
:: note_dm.bat,
:: call_dm.bat, 
:: datemath.bat,
:: call_dm_out.txt,
:: D:\Docs\batch\    -- %CD% -- current directory, beware of spaces?
:: D:\Desktop\       -- place to see day count on desktop
:: notepad.exe
::
:: call_dm.bat - call datemath.bat with several significant dates to
::               count down
::
:: http://www.adamanthony.net/2009/04/dos-command-line-date-math.html
:: http://ss64.com/nt/syntax-datemath.html
:: renayme depends on a file that looks like "293-days_2021-05-01.url"
:: 
::
echo off
SETLOCAL EnableDelayedExpansion
call ::settup
:: Note how the quotes are used to enable spaces in the value
::set "dsktp=C:\Users\brianbagnetto\OneDrive - DTSI\Desktop"
set "dsktp=C:\Users\brianbagnetto\OneDrive - DTSI\Desktop"
echo %dsktp%
@echo :
@echo :          ---  Date Math  ---
@echo :
@echo :
@echo :
::
:: Grab today and set %MM% %YY% %DD%
::
call :dayt

::c:\temp\datemath %YY% %MM% %DD% + 60
::
@echo :
@echo :      --- Daily Date CountDown  ---
@echo :
::
::           category (no spaces)       mm dd
::           --------                   -- --
call :calldm New_Years_Day              01 01
call :calldm Dad's_Cynthia's_BD         01 25
call :calldm Mom's_BD                   01 30
call :calldm Rachel's_n_Cynthia's_BD    02 13
call :calldm Anniversary                02 18
call :calldm Pat's_n_Harrys_BD          03 17
call :calldm Mothers_Day_2021           05 09
call :calldm Aimee's_BD                 05 15
call :calldm Memorial_Day               05 31
:: Rename desktop file as xx-days_2021-05-01.url
call :reenaym
call :calldm Independence_Day           07 05
call :calldm Richard's_BD               07 13
call :calldm Gina's_BD                  08 07
call :calldm Missy's_BD                 08 23
call :calldm Labor_Day                  09 06
call :calldm Peggy's_BD                 10 11
call :calldm Columbus_Day               10 11
call :calldm Veterans_Day               11 11
call :calldm Thanksgiving_Day           11 25
call :calldm Christmas_Day              12 25

:: I commented this out so I can direct output to file call_dm_out.txt
::pause 
goto :eof


::
:: ------------------- < calldm > -------------------
::

:calldm

@echo.
@echo --- %1 ---
call %CD%\datemath.bat %YY% %2 %3 - %YY% %MM% %DD%

if %_dd_int% LSS 0 (
    call %CD%\datemath.bat %ZZ% %2 %3 - %YY% %MM% %DD%
 )
goto :eof

::
:: ------------------- < reenaym > -------------------
::
:: Had to add double quotes around %dsktp% because it has spaces in it
:: Display number of dats in a filename on the computer desktop
:: Rename desktop file as xx-days_2021-05-01.url
::
:: FOR /F  %%G IN ('dir /b C:\Users\b\Desktop\*-days*.url') DO ( 
:: rename "C:\Users\b\Desktop\!l_ff!" %_dd_int%-days_%YY%-%MM%-%DD%.url
::
:reenaym

FOR /F  %%G IN ('dir /b "%dsktp%\*-days*.url"') DO ( 
set l_ff=%%G
rename "%dsktp%\!l_ff!" %_dd_int%-days_%YY%-%MM%-%DD%.url
)
goto :eof


::
:: ------------------- < dayt > -------------------
::
:: Split Current Date
:: date
:: The current date is: Sat 05/01/2021  - output of date command
::              token     1  2/ 3/   4
::                          %A/%B/%C
:dayt

@FOR /F "TOKENS=2-4 DELIMS=/ " %%A IN ('ECHO.%DATE%') DO @(

            SET YY=%%C
            SET MM=%%A
            SET DD=%%B

)

@set /a ZZ=%YY% + 1
goto :eof


::
:: ------------------- < settup > -------------------
::  Set size (rows, cols) of batch console 
::
:settup
mode con:cols=80 lines=15
::
:: green (2) on black (0) background
color 02
goto :eof
