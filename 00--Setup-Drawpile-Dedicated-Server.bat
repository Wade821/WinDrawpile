@echo off
title Drawpile Server
color 0B
set drawpilescriptversion=2.83
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
pause
echo.
echo --------------------------------------------------------------------------------


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
echo.
echo This guide assumes that you are using Windows XP with Service Pack 2, 
echo Windows Vista, Windows 7, Windows 8, Windows 8.1, Windows 10, or newer.
echo Also bear in mind that this batch file does not set up an actual Drawpile
echo dedicated server, but verifies that all the other dependencies are set up
echo before proceeding onto those instructions, which will appear in a separate
echo batch file and Google Document.
echo.
echo First, we're going to check to see if Drawpile has full and complete access 
echo to the internet for TWO way communication. We're going to do that by reviewing
echo the status of the port Drawpile uses before actually doing anything!
echo.
Echo Please lengthen this window vertically before continuing any further. 
echo.
pause
echo.
echo ---------------------------------------------------------------------
echo.

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

echo Starting Drawpile...
start "" /d %DPF% /b drawpile.exe
echo.
echo If you get a popup stating "Windows Firewall has blocked some features
echo of this app", you'll want to make sure that both boxes are checked. If
echo you know that your computer's network type is set as private, you can
echo choose to just select the first option.
echo.
echo "Private networks, such as my home or work network"
echo --- and ---
echo "Public Networks, such as those in airports and coffee shops (not
echo recommended because these networks often have little or no security)"
echo.
echo If you do see this, I suggest picking "Windows Firewall" when the option
echo comes up for it later in this batch file.
echo.
echo.
pause
echo.
echo In Drawpile which should have just opened... go to Session, and Host. 
echo Under Settings tab, the following should be checked:
echo.
echo * Allow drawing by default
echo * Lock layer controls
echo.
Echo Under the "Session" tab, put in a room name, username, check the box for
echo "Announce at:" with the "drawpile.net" option selected. Make sure the type
echo is set to "Public". Then ensure under "Server" that the radio button for
echo "Built-in" is selected. Click Host. When this step is completed, we're
echo ready to test if the port is open for use.
echo.
echo.
pause
echo.
echo ---------------------------------------------------------------------
echo.
echo Now a website should have popped up. Type in the following number: 27750
echo and press "Check Port."
echo.
explorer http://www.canyouseeme.org/
echo.
echo Was your port open (provided that Drawpile was already open and "hosting" 
echo a session currently)? Type the letter and hit enter.
echo y = Yes
echo n = No
echo.
set /p a=
echo.

IF %a%==y echo Yay. You do not need to take any further action, you are ready to host.
IF %a%==y echo.
IF %a%==y echo.
IF %a%==y pause
IF %a%==y exit

IF %a%==n echo ---------------------------------------------------------------------
IF %a%==n echo.
IF %a%==n echo Unfortunately, you've got a lot of work ahead of you. We'll get it
IF %a%==n echo figured out though! Leave the page open for later.
IF %a%==n echo.
IF %a%==n echo If you have an Internet Security Suite or Antivirus which includes a
IF %a%==n echo firewall, you'll need to consult documentation regarding that specific
IF %a%==n echo software in order to do this step. You'll also need to select option 1 or 3
IF %a%==n echo in the following prompt if you've already done option 2, in order to avoid
IF %a%==n echo unnecessary additional changes to the firewall rules on your computer.
IF %a%==n echo.
IF %a%==n echo If you do not have any firewall software but you're running Windows XP with
IF %a%==n echo Service Pack 2 or newer, then you've got a firewall on your hands. 
IF %a%==n echo.
IF %a%==n echo So, do you have a 3rd party firewall or only the Windows firewall?
IF %a%==n echo (Use option 1 or 3 if you've picked 2 previously)
IF %a%==n echo.
IF %a%==n echo 1 = 3rd party firewall 
IF %a%==n echo 2 = Windows Firewall
IF %a%==n echo 3 = Skip this step.
IF %a%==n echo.
IF %a%==n set /p b=
IF %a%==n echo.

IF %b%==1 echo You're going to need to consult the documentation or creator of
IF %b%==1 echo the software in question. There are too many out there to list,
IF %b%==1 echo and no good way to link a general resource on how to do it.
IF %b%==1 echo Unfortunately, you'll be on your own for this. Try to figure out
IF %b%==1 echo the necessary steps and read below for additional information.
IF %b%==1 echo.
IF %b%==1 echo Make sure the following files are allowed through your firewall.
IF %b%==1 echo.
IF %b%==1 echo %DP%
IF %b%==1 echo %DPS%
IF %b%==1 echo.
IF %b%==1 echo Once you believe you've completed this, restart this batch file to
IF %b%==1 echo verify the port is open or use the web page that was opened earlier.
IF %b%==1 echo.
IF %b%==1 echo If the port is open, you do NOT need to continue this batch file and
IF %b%==1 echo you may exit the batch file.
IF %b%==1 echo.
IF %b%==1 echo If the port is closed still, you will need to continue working on this.
IF %b%==1 echo Make sure to verify on the documentation that you performed all 
IF %b%==1 echo the applicable steps. Be aware that you can correctly open the port on
IF %b%==1 echo your firewall software and still not work if your router is blocking 
IF %b%==1 echo the port. We'll review that in a later step.
IF %b%==1 echo.
IF %b%==1 echo.
IF %b%==1 pause

IF %b%==2 echo Time to take additional steps!
IF %b%==2 echo Processing firewall rules to allow Drawpile access to the internet.
IF %b%==2 echo.
IF %b%==2 FOR /r %DPF% %%G in ("*.exe") Do (@echo %%G
IF %b%==2 NETSH advfirewall firewall add rule name="Drawpile-%%~nxG" dir=in program="%%G" action="allow" enable="yes")
IF %b%==2 FOR /r %DPF% %%G in ("*.exe") Do (@echo %%G
IF %b%==2 NETSH advfirewall firewall add rule name="Drawpile-%%~nxG" dir=out program="%%G" action="allow" enable="yes")
IF %b%==2 echo.
IF %b%==2 echo This step should have auto completed without any intervention from you,
IF %b%==2 echo the end user! Restart this batch file to verify the port is open or 
IF %b%==2 echo use the web page that was opened earlier.
IF %b%==2 echo.
IF %b%==2 echo If the port is open, you do NOT need to continue this batch file and
IF %b%==2 echo you may exit the batch file.
IF %b%==2 echo.
IF %b%==2 echo If the port is closed still, you will need to continue working on this.
IF %b%==2 echo Make sure to verify on the documentation that you performed all 
IF %b%==2 echo the applicable steps. Be aware that you can correctly open the port on
IF %b%==2 echo your firewall software and still not work if your router is blocking 
IF %b%==2 echo the port. We'll review that in a later step.
IF %b%==2 echo.
IF %b%==2 echo.
IF %b%==2 pause

IF %b%==3 echo Skipping this step.
echo.
echo ---------------------------------------------------------------------
echo.
echo.
Echo Time to move onto the next step, port forwarding or Universal Plug
Echo n Play setup on your local router. Unfortunately, there are too many 
echo devices out there for me to give you precise instructions on how to 
echo do this. There are guides online available though, and I can point
echo you in the right direction. You can also always go to the manufacturer
echo of the device for support.
echo. 
echo You'll have to read some of the website links I provide later to
echo increase your understanding of your router as well as a huge 
echo assortment of instructions and information. However, I'll try to 
echo automatically provide the information I can with this batch file after
echo I explain some basic ideas. 
echo.
echo The overall process is as follows:
echo 1) Determine computer's networking device's MAC and current IP address.
echo 2) Access your router's web page interface. Enable Universal Plug n
echo ---- Play (UPnP) if it is not enabled and check to see if the port is
echo ---- open AFTER you rehost a drawpile session again. Your router may
echo ---- need to restart to apply the settings. If this doesn't work, move
echo ---- onto the next step.
echo 3) Use the MAC address to set a static IP address in the router that
echo ---- matches your current assigned IP address for your device. Your 
echo ---- router may need to restart to apply the settings.
echo 4) Set up port forwarding with the IP address you just set up. Your 
echo ---- router may need to restart to apply the settings. Then you will
echo ---- check to see if the port is open AFTER you rehost a drawpile 
echo ---- session again. 
echo.
echo.
echo Once you've read this...
echo.
echo.
pause
echo.
echo ---------------------------------------------------------------------
echo.
echo.
echo First, we'll start with a basic overview of how to access your router's 
echo interface via a web browser. The information I list below is an attempt
echo to simplify gathering the necessary information to proceed with setup,
echo which is used to connect to it from a web page. But first we need to
echo understand some things about the way a computer connects to another
echo computer. We'll need the IP for your computer, the default gateway, 
echo and the MAC address for your networking device on the echo computer. 
echo.
echo For example, common default gateways used are ...
echo 192.168.0.1
echo 192.168.1.0
echo 10.0.0.1
echo.
echo This list is not complete, but more to give a general idea. So let's
echo pretend for a moment that you find a number somewhere in the following
echo screen that looks like 10.0.0.105. That's probably the IP address 
echo currently assigned to your computer. So we should expect the default
echo gateway to have the first three sets of number to be the same as your IP. 
echo A default gateway refers to the location your computer must 
echo communicate with in order echo to communicate with the internet. 
echo.
echo The MAC address is an identifier for the hardware used to connect
echo to the internet. So if you connect your computer wireless, it will have a
echo MAC address that is different from the MAC address used for a wired
echo connection on your computer. These are IPv4 addresses, and are used
echo for most people connecting to the internet. If you see IPv6, you will not
echo be able to host Drawpile sessions as people using IPv4 won't be able to 
echo connect to you.
echo.
echo Once you've read this...
echo.
echo.
pause
echo.
echo However, the first physical address that appears in the list -ABOVE- 
echo the IPv4 echo address we found earlier in this example is the MAC address. 
echo When we find your number, you need to make a note of that!
echo.
echo We'll need it in order to specify that your router gives your computer
echo the correct IP address all the time when it is on this network. That's
echo important, because it makes it less of a hassle later if your IP address
echo on your network changes or if you have a laptop that you'd like to have
echo internet when you're not at home. 
echo.
echo After you've read this, please press any button to continue. This will open
echo two web pages. Hopefully one for your router and one to help you understand
echo the information I gave you earlier.
echo.
echo.
pause
echo.
echo I'll attempt to automatically open your router's configuration page 
echo automatically! I'll also list information about your computer's hardware 
echo below as I talked about earlier.
echo.
set "ip="
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|findstr "Default"') do if not defined ip set ip=%%b
echo.
SET IP=%IP:~1%
echo The Default Gateway is: %ip%
echo.
echo Listing all available adapters IP and MAC addresses.
echo -------------------------------------------------------
ipconfig /all | findstr /R /C:"IP.* Address" /C:"Physical Address"
echo.
echo.
echo Opening web pages for your router and how to access your router if that fails...
explorer http://%IP%
explorer http://www.howtogeek.com/168379/10-useful-options-you-can-configure-in-your-routers-web-interface/
echo.
echo Were you able to find the information you needed?
echo 3 = Yes
echo 4 = No
echo.
set /p c=
echo.

IF %c%==3 echo.
IF %c%==3 echo Great, moving on....
IF %c%==3 echo.

IF %c%==4 echo.
IF %c%==4 echo Alright, I'll open the networking control panel for you to look 
IF %c%==4 echo up the information using the guide that should have auto appeared.
IF %c%==4 ncpa.cpl
IF %c%==4 echo.
IF %c%==4 echo.
IF %c%==4 pause

echo.
echo -------------------------------------------------------
echo.
echo Opening web pages on...
echo How to set up Static IP Address on your router to your device!
explorer http://www.howtogeek.com/177648/how-to-force-your-pc-to-keep-its-private-ip-address/
echo.
echo Opening web pages on...
echo How to Forward Ports on your Router to your device
explorer https://portforward.com/router.htm
explorer https://portforward.com/help/portforwarding.htm
explorer http://www.howtogeek.com/66214/how-to-forward-ports-on-your-router/
echo.
echo.
echo You'll have to find the option to enable UPnP if you want the easy route out
echo of doing this, but you should know that UPnP is a potential security risk.
echo Read more here - UPnP as a possible security risk if it is enabled.
echo http://www.howtogeek.com/122487/htg-explains-is-upnp-a-security-risk/
echo.
echo.
echo.
echo Restart this batch file to verify the port is open or use the web page that 
echo was opened earlier (http://www.canyouseeme.org/). If you have just enabled
echo UPnP, make sure to close Drawpile and make a new hosting session as I
echo described earlier.
echo.
echo If the port is open, yay! You did it! Good thing cause there's really nothing
echo left to do here!.
echo.
echo If the port is closed still, you will need to continue working on this.
echo Review all the possible steps I listed previously in this batch file and 
echo make sure that you performed all steps correctly. 
echo.
echo.
echo You may want to make use of a free service called No-IP. This allows you to
echo specify a host name for people to connect to rather than your internet IP
echo address, which typically changes. You can also Google "what is my IP" and
echo Google will tell you your current IP address on the internet.
echo.
echo https://www.noip.com/
echo Read more here on setup. --> http://tinyurl.com/nqpcrey
echo Use "DNS Host (A)", set your IP address to your public IP address, which
echo you can find via the Google Link below. You don't need to assign a group. 
echo Once you've created the hostname, you can skip the section starting with
echo "If you wish to use No-IP to manage" and the picture below it. All that's 
echo left is to download their software noted on Step 5. The point of doing this
echo is to ensure that any changes to your public IP are dynamically updated
echo without you having to update it manually. You can skip step 6 and 7. 
echo. 
echo https://www.google.com/search?q=what+is+my+ip&ie=&oe=
echo.
echo Exiting the batch file....
echo.
echo.
echo.
echo.
pause