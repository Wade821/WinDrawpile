@echo off
title Drawpile Server
color 0B
set drawpilescriptversion=2.83
set scriptname="02 Drawpile Dedicated Server - Start.bat"
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
findstr /b /n "set drawpilescriptversion=" "%public%\02 Drawpile Dedicated Server - Start.bat" | find "4:set drawpilescriptversion=" > "%public%\tmpfile.txt"
set /p dpcheckversion1= < %public%\tmpfile.txt
del "%public%\tmpfile.txt"
set dpcheckversion=%dpcheckversion1:~28,4%
echo DP Check Version: %dpcheckversion%
REM 
set currentscriptname=%~n0%~x0
echo.

IF  "%drawpilescriptversion%" LSS "%dpcheckversion%" (
	echo Newest Script is using version %dpcheckversion%
	echo Newer version of script available, the old script has been copied over
	echo the old script.
    echo.
	copy /Y "%public%\%scriptname%" "%CURDIR%\%currentscriptname%"
	del "%public%\%scriptname%"
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

endlocal
exit /b
pause

echo --------------------------------------------------------------------------------

IF EXIST "C:\Program Files\Drawpile\" (
set DPF="C:\Program Files\Drawpile\" 
) ELSE (
set DPF="C:\Program Files (x86)\Drawpile\"
)

IF EXIST "C:\Program Files\Drawpile\drawpile.exe" (
set DP="C:\Program Files\Drawpile\drawpile.exe" 
) ELSE (
set DP="C:\Program Files (x86)\Drawpile\drawpile.exe"
)

IF EXIST "C:\Program Files\Drawpile\drawpile-srv.exe" (
set DPS="C:\Program Files\Drawpile\drawpile-srv.exe" 
) ELSE (
set DPS="C:\Program Files (x86)\Drawpile\drawpile-srv.exe"
)

echo.
echo -----------------------------------------------------------------------------------
echo.
echo Terminating the drawpile server if it's already running.
taskkill /t /f /IM drawpile-srv.exe
echo.
echo -----------------------------------------------------------------------------------
echo.
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a

echo Provide "%PublicIP%" to people outside of your home for them to join your server.
echo (this command works on Windows 7 and newer)
echo.
echo If you have Windows Vista or older, ignore the line above. 
echo.
echo To connect to your own computer hosting the drawpile server, use the 'Address:'
echo which appears in the Drawpile Server GUI window that pops up for hosting sessions.
echo Simply put that number under the Server section where it says 'Remote:'. Or try
echo one of the IP numbers listed below.
echo.
echo Most likely options . . .
ipconfig | find "IPv4" | find "192.168.1." 
ipconfig | find "IPv4" | find "192.168.0."
ipconfig | find "IPv4" | find "10.0.0."
echo.
echo Less likely options . . .
ipconfig | find "IPv4" | find /V "192.168.1." | find /V "192.168.0." | find /V "10.0.0."
echo.
echo -----------------------------------------------------------------------------------
echo.
echo This stage is for setting up an easy to remember way to connect to your server.
echo.
echo https://freedns.afraid.org/ 
echo Pros: Free registration, no need to renew use of the hostname.
echo Cons: Minor additional setup with script guided help required, guided setup.
echo       If a typo is made, you must use crontab -e to update the code manually.
echo.
echo https://www.noip.com/ 
echo Pros: Free registration, simple setup, only slightly less complex than above
echo       option listed above.
echo Cons: Must renew the hostname via notification received in email every 30 days
echo       or lose access. Might not be able to get the same name back.
echo.
echo *** Option 1: *** 
echo Use FreeDNS.Afraid.Org to get service instead! Free to use and no need 
echo to re-register the domain every 30 days. Register an account, go to Subdomains 
echo option on the left, select option Add a subdomain. Leave Type set to A, set any 
echo desired subdomain name that you wish to use. Domain options are listed in the 
echo dropbox, you can pick Many many more available in order to search for domain 
echo names you like that are listed as Public. Click the link Shared Domain Registry 
echo and search for a desired domain. Once you find a name you like, click on the link 
echo on the left. Leave the fields Destination, TTL, and Wildcard as they currently 
echo are... and fill in the Captcha that everyone loves and hates. Get a program to 
echo update your IP address by a 'Windows Client' or make your router do it under the 
echo 'Router Client' section. This web page as a whole list of different ways to do it! 
echo.
echo https://freedns.afraid.org/scripts/freedns.clients.php
echo http://tinyurl.com/kzh5nsy
echo.
echo Recommended Client for Windows:
echo Dynamic DNS for FreeDNS - http://smr.dekalbal.com/Download.php
echo.
echo.
echo *** Option 2: ***
echo No-IP to obscure your Internet IP address. This allows for users to 
echo more easily connect to you without knowing your current IP address, which may 
echo change due to the way the internet currently works. 
echo.
echo Once logged in, you should be looking at the dashboard. You will know if the 
echo hyperlink at the top is https://my.noip.com/#!/. Just type your desired hostname 
echo and choose a domain drop down that you like. from the 'Free Domains' options. 
echo Click the button 'Add Hostname'. You will just need your username and password 
echo to set this up. 
echo.
echo If using the classic site, click 'Add Host' on the left. Type in your Hostname 
echo and choose a domain on the right from the list of 'No-IP Free Domains'. Make 
echo sure the host type is set to 'DNS Host (A)'. For 'IP Address', open a new tab 
echo and go to www.whatismyip.com to get your IP and put it in this field. Leave 
echo other options at default values and click 'Add Host'.
echo.
echo https://www.noip.com/
echo. 
echo Read more here on setup and make sure to install the Dynamic DNS UPdate Client
echo (DUC) for Windows.
echo http://tinyurl.com/nqpcrey
echo https://www.noip.com/download?page=win
echo. 
REM ***==========================================================================***
REM This line is disabled by default below. Remove the "REM" from the line below
REM in order to automatically open a web page to check your IP address when
REM starting Drawpile. Press Ctrl + S to save.
REM ***==========================================================================***

REM explorer "https://www.google.com/search?q=what+is+my+ip&ie=&oe="
echo.
echo -----------------------------------------------------------------------------------
echo.
cd /d %DPF%

drawpile-srv --version
echo.
echo Displaying a list of supported command line parameters:
drawpile-srv -h
echo.
echo.
drawpile-srv --gui -h
echo.
echo -----------------------------------------------------------------------------------
echo.
echo Make sure to hit 'Start'! Close drawpile server configuration and the black CMD 
echo window to shut the server down. Leave this window open otherwise! You will also
echo see a Drawpile server icon in your notifications area near the clock that you
echo can right click to exit.
echo.
echo -----------------------------------------------------------------------------------
echo.
echo Short summary of options:
echo.
echo file backed sessions - write sessions to file, helps sessions to survive
echo     power outages and server crashes. Can serve as a recording if server
echo     database set to Archive terminated sessions, however filenames are
echo     saved like 926a80d5-3168-401d-b406-f05d3fc05c32.dprec with a
echo     corresponding text file, the session title is inside the text file.
echo     The file extension for the recording is *.dprec. The file extension
echo     for the text file is *.session, which you can right click, select 
echo     "Open With", and select a program like Notepad.
echo     To activate, click 'Settings' in the user interface and set the
echo     'Session storage:' option to 'File'.
echo hostname - Allows you to use a website like connection method instead of
echo     your public IP. 
echo     To activate, click 'Settings' in the user interface and set the
echo     'Local hostname' option to the hostname you picked out.
echo recording - records all sessions, may not be necessary with file backed
echo     sessions turned on, though it can be useful for debugging broken boards
echo     or recovering art from broken boards. This can be turned on an 
echo     individual basis when a room is active on the server by going to 
echo     File and then Record... , or by combining the file backed sessions 
echo     option and checking 'Archive terminated sessions'. Sessions which 
echo     are recorded can be found under the following location:
echo     %localappdata%\drawpile\drawpile-srv\sessions
echo     The file extension for the recording is *.dprec.archived. The file 
echo     extension for the text file is *.session.archived, which you can 
echo     right click, select  "Open With", and select a program like Notepad.
echo registered nicknames - Allows users connecting to your server to use
echo     their registered names on drawpile.net.
echo     To activate, click 'Settings' in the user interface and set the
echo     'Ext-auth' option to 'https://drawpile.net/api/ext-auth/'. Click
echo     'OK'. Check 'External Authentication' and copy this line into
echo     'Validation key:' 9eJ2tMJlqgSqHOIK/GI/qzS14WqIxHeB1Im5Hs/CCCk=
echo     It is highly suggested that the 'Permit guest logins when ext-auth
echo     server is unreachable' is checked and 'Allow ext-auth moderators' 
echo     is unchecked.
echo templates - provide default sessions that always exist on the server.
echo     This feature is not yet implemented in the graphical user interface.
echo ssl - Encrypt data sent so conversations and drawings are kept private.
echo     If you do not have this option on, sensitive information should not
echo     be shared in sessions. I.E. credit cards.
echo     To activate, click 'Settings' in the user interface and set the
echo     'TLS' option to either 'Enabled' or 'Required'. You then need
echo     to set the 'Certificate' and 'Key' fields to the files generated
echo     using OpenSSL script. These files are good for one year before
echo     they need to be regenerated with new files for security purposes.
echo     The key and cert can be found in the following location after using
echo     the OpenSSL script to generate them:
echo     %localappdata%\drawpile\drawpile-srv\
echo.
echo Note: The file guiserver.db located in %localappdata%\drawpile\drawpile-srv\
echo     contains all settings used on your server. If moving to a new computer,
echo     backup this file and copy it to the new computer in the same relative
echo     location in order to minimize setup requirements.
echo.
echo Note: Automatic Session resets are determined by 70% of the setting Session Size Limit. What this
echo      means is that a server set to 15 MB will automatically reset at 10.50 MB. A server set to
echo      20 MB will auto reset at 14 MB. A server set to 25 MB will auto reset at 17.50 MB. This is
echo      especially important to make the value large to account for large boards being hosted on the
echo      server. I suggest using 25 MB for the setting when remotely accessing the server to
echo      administrate the server settings.
echo.
echo -----------------------------------------------------------------------------------
echo.
drawpile-srv --gui



endlocal



