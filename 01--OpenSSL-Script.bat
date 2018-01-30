@echo off
title Drawpile OpenSSL Key and Certificate Generation
color 0B
set drawpilescriptversion=2.83
set scriptname="01--OpenSSL-Script.bat"
Set scriptname=%scriptname:"=%
set CURDIR="%~dp0"
Set CURDIR=%CURDIR:"=%
echo.
echo Made with the assistance of the Creator of Drawpile! His PayPal E-mail if
echo you want to donate some money as thanks for all that he does!
echo laakkonenc@gmail.com
echo.
echo Script Version %drawpilescriptversion%
echo Google Doc http://tinyurl.com/jx5oe4h
echo.
echo Please make sure you are using the latest version of this script before
echo continuing. You can get the latest version by making sure the script number
echo above matches the Drawpile Google document version number in the upper right
echo of every page where this script was obtained. If not, close this window 
echo and get the newest version before proceeding.
echo.
REM pause
echo.
echo --------------------------------------------------------------------------------
echo.
CD /D "%~dp0"
setlocal
REM Read more on returning to local directory after changes
REM https://stackoverflow.com/questions/6990198/how-to-return-to-the-original-directory-after-invoking-change-directory-in-dos-b

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

IF EXIST "C:\Program Files (x86)\GnuWin32\bin\wget.exe" set wget="C:\Program Files (x86)\GnuWin32\bin\wget.exe"
IF EXIST "C:\Program Files\GnuWin32\bin\wget.exe" set wget="C:\Program Files\GnuWin32\bin\wget.exe"
cd /D "%public%"
%wget% --no-check-certificate "https://raw.githubusercontent.com/Wade821/WinDrawpile/master/%scriptname%"
echo.
echo '--------------------------------------------------------------------------------'
echo '--------------------------------------------------------------------------------'
echo.
findstr /b /n "set drawpilescriptversion=" "%public%\%scriptname%" | find "4:set drawpilescriptversion=" > "%public%\tmpfile.txt"
set /p dpcheckversion1= < %public%\tmpfile.txt
set dpcheckversion=%dpcheckversion1:~28,4%
del "%public%\tmpfile.txt"
REM 
set currentscriptname=%~n0%~x0
echo.

IF  "%drawpilescriptversion%" LSS "%dpcheckversion%" (
	echo Newest Script is using version %dpcheckversion%
	echo Newer version of script available, the old script has been copied over
	echo the old script. Please re-run script.
    echo.
	copy /Y "%public%\%scriptname%" "%CURDIR%\%currentscriptname%"
	del "%public%\%scriptname%"
	echo.
	timeout /t 30
	endlocal
	exit /b
) ELSE IF  "%drawpilescriptversion%" EQU "%dpcheckversion%" (
    echo Script is newest version available.
	del "%public%\%scriptname%"
) ELSE IF  "%drawpilescriptversion%" GTR "%dpcheckversion%" (
	echo It appears the creator of the script has failed to update github with the newest version.
	echo Please contact him to update the script there by emailing him at wadeschlueter@gmail.com
	echo.
	echo Script in use: %drawpilescriptversion%
	echo Github Script: %dpcheckversion%
	echo.
	pause
	del "%public%\%scriptname%"
) ELSE ( 
    echo Unable to determine script version, proceeding with script.
)

echo --------------------------------------------------------------------------------


IF EXIST "C:\Program Files (x86)\GnuWin32\bin\openssl.exe" goto x86
IF EXIST "C:\Program Files\GnuWin32\bin\openssl.exe" goto x64
GOTO exitbatch

:x86
set openSSL="C:\Program Files (x86)\GnuWin32\bin\" 
set openSSLcnf="C:\Program Files (x86)\GnuWin32\share\openssl.cnf"
goto processbatch

:x64
set openSSL="C:\Program Files\GnuWin32\bin\" 
set openSSLcnf="C:\Program Files\GnuWin32\share\openssl.cnf"
goto processbatch

:processbatch
echo This script assumes you have a hostname, and it is required for
echo encrypted server connections to protect private conversations
echo and also to mask your Public IP address when connecting to the
echo server.
echo.
echo Make sure this is correctly typed both times before proceeding
echo with the script. If you do not enter it correctly, users will
echo not be able to connect to hosted sessions with the server using
echo encryption by SSL.
echo.
echo For example:
echo example.hostwebsite.com
echo.
echo If you do not have one, simply leave it blank and hit enter
echo twice. However, it is highly recommended to have one, they
echo are free after all!
echo.
set /p  hostname1="Enter hostname: " 
set /p hostname2="Enter hostname again: "
if %hostname1% NEQ %hostname2% (
	echo.
    echo "Hostnames entered do not match!"
	echo.
    set /p hostname1="Enter hostname: " 
    set /p hostname2="Enter hostname again: "
)

set hostname=%hostname1%
echo.
echo Your hostname is: %hostname%
echo.
echo.

echo "***** Setting up SSL Certificate Creation . . . *****"
echo.
echo This section is for encrypting sessions to keep them more private.
echo Fill out this section regardless of whether you plan to use encryption
echo or not, as later on you will have the option to decide if you want to
echo use this or not.
echo.
echo Please note in the following sections that the parts contained within
echo the brackets are the default option if no information is entered.
echo.
echo Country Name (2 letter code) [AU]:
echo.
set /p country=
echo.
if "%country%"=="" (
  SET country=AU
)
echo Selected: %country%
echo.
echo --------------------------------------------------------------------------------
echo.
echo State or Province Name (full name) [Some-State]:
echo.
set /p state=
echo.
if "%state%"=="" (
  SET state=Some-State
)
echo Selected: %state%
echo.
echo --------------------------------------------------------------------------------
echo.
echo Locality name (e.g., city) [Some-City]:
echo.
set /p locality=
echo.
if "%locality%"=="" (
  SET locality=Some-City
)
echo Selected: %locality%
echo.
echo --------------------------------------------------------------------------------
echo.
echo Organization Name (eg, company) [Internet Widgits Pty Ltd]:
echo.
set /p organization=
echo.
if "%organization%"=="" (
  SET organization=Internet Widgits Pty Ltd
)
echo Selected: %organization%
echo.
echo --------------------------------------------------------------------------------
echo.
echo Organizational Unit Name (e.g., section) [Collaborating Artists]:
echo.
set /p unitname=
echo.
if "%unitname%"=="" (
  SET unitname=Collaborating Artists
)
echo Selected: %unitname%
echo.
echo --------------------------------------------------------------------------------
echo.
echo Email Address [noemail@noemail.com]
echo.
set /p email=
echo.
if "%email%"=="" (
  SET email=noemail@noemail.com
)
echo Selected: %email%
echo.
echo --------------------------------------------------------------------------------
echo.
echo %openSSL%
echo %openSSLcnf%
echo.
mkdir "%localappdata%\drawpile\drawpile-srv"
CD /D "%openSSL%"
openssl.exe req -x509 -newkey rsa:2048 -nodes -config %openSSLcnf% -keyout %localappdata%\drawpile\drawpile-srv\key.pem -out %localappdata%\drawpile\drawpile-srv\cert.pem -days 365 -subj "/C=%country%/ST=%state%/L=%locality%/O=%organization%/OU=%unitname%/CN=%hostname%/emailAddress=%email%\"
explorer %localappdata%\drawpile\drawpile-srv\
echo.
echo Keys generated in folder, please keep this open for easy configuration 
echo of the server so you know where to find the files.
echo You may need to substitute backslashes (\) for forward slashes (/) when
echo writing out the folder and file path into Drawpile-srv.exe.
timeout /t 30
goto eof

:exitbatch
echo This script requires OpenSSL for Windows to be already installed.
echo Download 'Complete package, except sources' Setup link and install.
echo.
explorer http://gnuwin32.sourceforge.net/packages/openssl.htm
timeout /t 30 /nobreak
exit

:eof
endlocal
