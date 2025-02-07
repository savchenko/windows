::
:: https://github.com/stoptracking/windows10
::

@echo off
SETLOCAL EnableDelayedExpansion

echo.
echo This should be run with Administrator privileges, otherwise errors will occur.
set /p rtg="Press any key if you are ready, close this window if not."
cls

echo [101;93m Limit Cortana and Online/Bing search [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaInAAD /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v AllowInputPersonalization /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
REM Where is the documentation for "CortanaConsent"?..
REM reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f

echo [101;93m Limit Cortana application via Windows Firewall... [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules" /t REG_SZ /v "v2.25|Action=Block|Active=TRUE|Dir=Out|Protocol=6|App=%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\searchUI.exe|Name=Block outbound Cortana|" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"  /v "{2765E0F4-2918-4A46-B9C9-43CDD8FCBA2B}" /t REG_SZ /d  "BlockCortana|Action=Block|Active=TRUE|Dir=Out|App=C:\windows\systemapps\microsoft.windows.cortana_cw5n1h2txyewy\searchui.exe|Name=Search  and Cortana  application|AppPkgId=S-1-15-2-1861897761-1695161497-2927542615-642690995-327840285-2659745135-2630312742|" /f

echo [101;93m Disable indexing of encrypted files [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowIndexingEncryptedStoresOrItems /t REG_DWORD /d 0 /f

echo [101;93m Disable error reporting [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

echo [101;93m Disable Microsoft experimentation [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v value /t REG_DWORD /d 0 /f

echo [101;93m Do not allow WifiSense hotspots [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f

echo [101;93m Disable LLMNR and Smart-Name-Resoltion [0m
reg add "HKLM\Software\policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 0 /f
reg add "HKLM\Software\policies\Microsoft\Windows NT\DNSClient" /v DisableSmartNameResolution /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v DisableParallelAandAAAA /t REG_DWORD /d 1 /f

:: Windows updates

echo [101;93m Enable Windows Update [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DoNotConnectToWindowsUpdateInternetLocations /t REG_DWORD /d 0 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUServer /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUStatusServer /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v UseWUServer /f

echo [101;93m Keep auto-updates enabled [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f

echo [101;93m Notify before download or installation [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f

echo [101;93m Do not reboot automatically if someone is logged into the system [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f

echo [101;93m Do not wake-up the machine to install an update [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUPowerManagement /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrenLtVersion\Schedule\Maintenance" /v WakeUp /t REG_DWORD /d 0 /f

echo [101;93m Treat minor updates like other updates [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AutoInstallMinorUpdates /t REG_DWORD /d 0 /f

echo [101;93m Check for new updates every hour [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v DetectionFrequencyEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v DetectionFrequency /t REG_DWORD /d 1 /f

echo [101;93m Disable "featured software" in Windows update [0m
reg add	"HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /T REG_DWORD /V EnableFeaturedSoftware /D 0 /F

echo [101;93m Defer feature-updates by 360 days  [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /t REG_DWORD /v DeferFeatureUpdates /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /t REG_DWORD /v DeferFeatureUpdatesPeriodInDays /d 360 /f

echo [101;93m Ensure security updates are installed on day zero [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /t REG_DWORD /v DeferQualityUpdates /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /t REG_DWORD /v DeferQualityUpdatesPeriodInDays /d 0 /f

::

echo [101;93m Disable Windows tips [0m
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f

echo [101;93m Prevent sharing of handwriting and speech [0m
reg add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v PreventHandwritingDataSharing /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v AllowLinguisticDataCollection /t REG_DWORD /d 0 /f

echo [101;93m Do not leak information about AppV usage via Windows Customer Experience [0m
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /T REG_DWORD /V "CEIPEnable" /D 0 /F
reg add "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" /T REG_DWORD /V "CEIPEnable" /D 0 /F

echo [101;93m Disable "Windows Spotlight" [0m
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f
reg add "HKEY_Local_Machine\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization"/v LockScreenImage /d "%SystemRoot%\web\screen\img105.jpg" /f
reg add "HKEY_Local_Machine\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v LockScreenOverlaysDisabled /t REG_DWORD /d 1 /f

echo [101;93m Disable consumer features [0m
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg add "HKEY_Current_User\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f

echo [101;93m Do not show feedback notifications and disable "Feedback & diagnostics" [0m
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f
reg add	"HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V "AllowTelemetry" /D 0 /F

echo [101;93m Disable suggested apps [0m
reg add "HKLM\Software\Policies\Microsoft\WindowsInkWorkspace" /v AllowSuggestedAppsInWindowsInkWorkspace /t REG_DWORD /d 0 /f

echo [101;93m Disable password reveal [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Speech" /t REG_DWORD /v DisablePasswordReveal /d 1 /f

echo [101;93m Disable settings synchronization [0m
reg add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSync /t REG_DWORD /d 2 /f

echo [101;93m Disable user override of the settings synchronization [0m
reg add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSyncUserOverride /t REG_DWORD /d 1 /f

echo [101;93m Disable device metadata retrieval [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f

echo [101;93m Disable "Find my device" [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FindMyDevice" /v AllowFindMyDevice /t REG_DWORD /d 0 /f

echo [101;93m Disable font streaming  [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableFontProviders /t REG_DWORD /d 0 /f

echo [101;93m Disable web-search... [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /d 0 /f

echo [101;93m Disable biometrics [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /v Enabled /d 0 /f

echo [101;93m Disable camera from AppX [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Camera" /v AllowCamera /d 0 /f

echo [101;93m Disable Windows preview builds [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /t REG_DWORD /v AllowBuildPreview /d 0 /f

echo [101;93m Turn off "live tiles" [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /t REG_DWORD /v NoCloudApplicationNotification /d 1 /f

echo [101;93m Disable help ratings [0m
reg add "HKCU\Software\Policies\Microsoft\Assistance\Client\1.0" /v NoExplicitFeedback /t REG_DWORD /d 1 /f

echo [101;93m Disable Windows mail application [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Mail" /v ManualLaunchAllowed /t REG_DWORD /d 0 /f

echo [101;93m Disable Microsoft Account and do not nag about it[0m
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\wlidsvc" /t REG_DWORD /v Start /d 4 /f
reg add "HKCU\Software\Microsoft\Windows Security Health\State" /t REG_DWORD /v AccountProtection_MicrosoftAccount_Disconnected /d 1 /f

echo [101;93m Disable NCSI [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v NoActiveProbe /t REG_DWORD /d 1 /f

echo [101;93m Disable OneDrive [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OneDrive" /v PreventNetworkTrafficPreUserSignIn /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f

echo [101;93m Do not download maps data [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v AutoDownloadAndUpdateMapData /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v AllowUntriggeredNetworkTrafficOnSettingsPage /t REG_DWORD /d 0 /f

echo [101;93m Turn off advertising ID [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /t REG_DWORD /v Enabled /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /t REG_DWORD /v DisabledByGroupPolicy /d 1 /f

echo [101;93m Do not retrieve device metadata from the Internet [0m
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /V "PreventDeviceMetadataFromNetwork" /T REG_DWORD /D 1 /F

echo [101;93m Do not track application launches [0m
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v Start_TrackProgs /d 0 /f

echo [101;93m Do not share user's language list [0m
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /t REG_DWORD /v HttpAcceptLanguageOptOut /d 1 /f

echo [101;93m Do not share app status with random devices [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /t REG_DWORD /v EnableCdp /d 0 /f

echo [101;93m Do not share location and sensors data [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v DisableSensors /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessLocation /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LocationAndSensors" /t REG_DWORD /v DisableLocation /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LocationAndSensors" /t REG_DWORD /v DisableLocationScripting /d 1 /f

echo [101;93m Disable Maps updates [0m
reg add "HKEY_LOCAL_MACHINE\System\Maps" /t REG_DWORD /v AutoUpdateEnabled /d 0 /f

echo [101;93m Do not share across devices [0m
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CDP" /t REG_DWORD /v CdpSessionUserAuthzPolicy /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CDP" /t REG_DWORD /v RomeSdkChannelUserAuthzPolicy /d 0 /f

echo [101;93m Disable clipboard history [0m
reg add "HKCU\Software\Microsoft\Clipboard" /t REG_DWORD /v EnableClipboardHistory /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /t REG_DWORD /v AllowClipboardHistory /d 0 /f

echo [101;93m Adjust AppX privacy settings [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v AllowMessageSync /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessAccountInfo /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessCalendar /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessCallHistory /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessCamera /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessContacts /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessEmail /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessMessaging /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessMicrophone /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessMotion /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessPhone /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessRadios /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessTasks /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsAccessTrustedDevices /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsActivateWithVoice /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsActivateWithVoiceAboveLock /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsGetDiagnosticInfo /d 2 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\AppPrivacy" /t REG_DWORD /v LetAppsSyncWithDevices /d 2 /f

echo [101;93m CapabilityAccessManager [0m
echo.

echo [101;93m Camera [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Microphone [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Account Info [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Contacts [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Calendar [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Call history [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Email [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Tasks [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m TXT/MMS [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Other Devices [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Cellular Data [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Allow apps to run in background global setting [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /T REG_DWORD /V "GlobalUserDisabled" /D 1 /F
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /T REG_DWORD /V "BackgroundAppGlobalToggle" /D 0 /F

echo [101;93m My Documents [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m My Pictures [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m My Videos [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m File System [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /T REG_SZ /V "Value" /D Deny /F

echo [101;93m Location [0m
reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /T REG_SZ /V "Value" /D Deny /F

echo.

echo [101;93m Do not send my voice data (!) to Microsoft [0m
reg add "HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /t REG_DWORD /v HasAccepted /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Speech" /t REG_DWORD /v AllowSpeechModelUpdate /d 0 /f

echo [101;93m Do not share writing and typing (!) information with Microsoft [0m
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /t REG_DWORD /v RestrictImplicitTextCollection /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /t REG_DWORD /v RestrictImplicitInkCollection /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /t REG_DWORD /v HarvestContacts /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /t REG_DWORD /v "Enabled" /d 0 /f

echo [101;93m Disable activity feed [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /t REG_DWORD /v EnableActivityFeed /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /t REG_DWORD /v PublishUserActivities /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /t REG_DWORD /v UploadUserActivities /d 0 /f

echo [101;93m Disable Windows Sync [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\SettingSync" /t REG_DWORD /v DisableSettingSync /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\SettingSync" /t REG_DWORD /v DisableSettingSyncUserOverride /d 1 /f

echo [101;93m Turn off messaging cloud sync [0m
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Messaging" /t REG_DWORD /v CloudServiceSyncEnabled /d 0 /f

echo [101;93m Disable Teredo [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TCPIP\v6Transition" /t REG_SZ /v "Disabled" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TCPIP\v6Transition" /v Teredo_State /d "Disabled" /f

echo [101;93m Disable Wifi Sense [0m
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v WiFISenseAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v AutoConnectAllowedOEM /t REG_DWORD /d 0 /f

echo [101;93m Delete WPAD key for the current user [0m
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /f

echo [101;93m Disable SpyNet and do not send samples to Microsoft [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Spynet" /t REG_DWORD /v SpyNetReporting /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Spynet"  /t REG_DWORD /v SubmitSamplesConsent /d 2 /f

echo [101;93m Disable MSRT [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\MRT"  /t REG_DWORD /v DontReportInfectionInformation /d 1 /f

echo [101;93m Disable Microsoft Store [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /t REG_DWORD /v DisableStoreApps /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore " /t REG_DWORD /v AutoDownload /d 2 /f

echo [101;93m Do not use SmartScreen for AppX [0m
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f

echo [101;93m Disable "Apps for websites" [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /t REG_DWORD /v EnableAppUriHandlers /d 0 /f

echo [101;93m Disable "delivery optimisation" [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization " /t REG_DWORD /v DODownloadMode /d 100 /f

echo [101;93m Disable MS Store [0m
reg add "HKLM\Software\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /t REG_DWORD /d 1 /f

echo [101;93m Disable AppX's from the Store [0m
reg add "HKLM\Software\Policies\Microsoft\WindowsStore" /v DisableStoreApps /t REG_DWORD /d 1 /f

echo [101;93m Disable "Push to install" [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\PushToInstall" /v DisablePushToInstall /t REG_DWORD /d 1 /f

echo [101;93m Disable "Content delivery manager" [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f

echo [101;93m Disable Autoplay [0m
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /T REG_DWORD /V "DisableAutoplay" /D 1 /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /T REG_DWORD /V "DisableAutoplay" /D 1 /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /T REG_DWORD /V "NoAutoplayfornonVolume" /D 1 /F
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /T REG_DWORD /V NoDriveTypeAutoRun /D 255 /F

echo [101;93m Disable Explorer web-wizards [0m
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /T REG_DWORD /V NoWebServices /D 1 /F

echo [101;93m Disable Fast Startup feature [0m
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /T REG_DWORD /V HiberbootEnabled /D 0 /F

echo [101;93m Disable online tips [0m
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v AllowOnlineTips /t REG_DWORD /d 0 /f

echo [101;93m Do not download printer drivers over HTTP [0m
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Printers" /T REG_DWORD /V DisableWebPnPDownload /D 1 /F

echo [101;93m Force-scan attachments with antivirus [0m
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments\ScanWithAntiVirus" /T REG_DWORD /V ScanWithAntiVirus /D 3 /F

echo [101;93m Restrict AppCompat (Application compatibility) [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v VDMDisallowed /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableEngine /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableWizard /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v SbEnable /t REG_DWORD /d 0 /f

echo [101;93m Disable Game DVR [0m
reg add "HKCU\System\GameConfigStore" /T REG_DWORD /V "GameDVR_Enabled" /D 0 /F
reg add "HKCU\Software\Microsoft\GameBar" /T REG_DWORD /V "AutoGameModeEnabled" /D 0 /F
reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /T REG_DWORD /V "AllowGameDVR" /D 0 /F

echo [101;93m Disable Ink Workspace [0m
reg add "HKLM\Software\Policies\Microsoft\WindowsInkWorkspace" /v AllowWindowsInkWorkspace /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\WindowsInkWorkspace" /v AllowSuggestedAppsInWindowsInkWorkspace /t REG_DWORD /d 0 /f

echo [101;93m Prevent automatic Edge-to-Chromium upgrade [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f

echo [101;93m Do not attempt to search in Windows Store for an unknown file extension [0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /t REG_DWORD /d 1 /f

echo [101;93m Remove "3D paint"... [0m
for /f "tokens=1* delims=" %%I in (' reg query "HKEY_CLASSES_ROOT\SystemFileAssociations" /s /k /f "3D Edit" ^| find /i "3D Edit" ') do (reg delete "%%I" /f )
for /f "tokens=1* delims=" %%I in (' reg query "HKEY_CLASSES_ROOT\SystemFileAssociations" /s /k /f "3D Print" ^| find /i "3D Print" ') do (reg delete "%%I" /f )
echo ...done

:: TODO: Test if this can be executed from SHIFT+F10
echo [101;93m Disable first logon animation [0m
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f


:: Disable services

echo [101;93m Disable error reporting service [0m
sc config WerSvc start=disabled

echo [101;93m Disable Telemetry service [0m
sc config DiagTrack start=disabled

echo [101;93m Disable Wireless Application Protocol (WAP) service [0m
sc config dmwappushservice start=disabled

echo [101;93m Disable OneSync service [0m
sc config OneSyncSvc start=disabled

echo [101;93m Disable text messaging service [0m
sc config MessagingService start=disabled

echo [101;93m Disable MS account identity service [0m
sc config wlidsvc start=disabled

echo [101;93m Disable Windows Insider service [0m
sc config wisvc start=disabled

echo [101;93m Disable "Retail Demo" service [0m
sc config RetailDemo start=disabled

echo [101;93m Disable events collector service [0m
sc config diagnosticshub.standardcollector.service start=disabled

echo [101;93m Disable XBox services [0m
sc config XblAuthManager start=disabled
sc config XblGameSave start=disabled
sc config XboxNetApiSvc start=disabled

echo [101;93m Disable ActiveX Installer  [0m
sc config AxInstSV start=disabled

echo [101;93m Disable AllJoyn router [0m
sc config AJRouter start=disabled

echo [101;93m Disable bluetooth service [0m
sc config bthserv start=disabled

echo [101;93m Disable "connected devices platform" services [0m
sc config CDPUserSvc start=disabled
sc config CDPSvc start=disabled

echo [101;93m Disable Game DVR service [0m
sc config BcastDVRUserService start=disabled

echo [101;93m Disable bluetooth service [0m
sc config BluetoothUserService start=disabled

echo [101;93m Disable Miracast and DLNA service [0m
sc config DevicePickerUserSvc start=disabled

echo [101;93m Disable ConnectUX service (WiFi/bluetooth displays) [0m
sc config DevicesFlowUserSvc start=disabled

echo [101;93m Disable text messaging service [0m
sc config MessagingService start=disabled

echo [101;93m Disable Client-licensing service (MS Store) [0m
sc config ClipSVC start=disabled

echo [101;93m Disable maps broker service [0m
sc config MapsBroker start=disabled

echo [101;93m Disable Function Discovery Resource Publication service [0m
sc config FDResPub start=disabled

echo [101;93m Disable geolocation service [0m
sc config lfsvc start=disabled

echo [101;93m Disable 6to4 service [0m
sc config iphlpsvc start=disabled

echo [101;93m Disable LLTDM service [0m
sc config lltdsvc start=disabled

echo [101;93m Disable MS Account services [0m
sc config wlidsvc start=disabled
sc config NgcSvc start=disabled

echo [101;93m Disable Network Connection Broker (AppX connectivity) service [0m
sc config NcbService start=disabled

echo [101;93m Disable RPC Locator service [0m
sc config RpcLocator start=disabled

echo [101;93m Disable Program Compatibility Assistant service [0m
sc config PcaSvc start=disabled

echo [101;93m Disable sensor services [0m
sc config SensorService start=disabled
sc config SensorDataService start=disabled
sc config SensrSvc start=disabled

echo [101;93m Disable autoplay service [0m
sc config ShellHWDetection start=disabled

echo [101;93m Disable SSDP service [0m
sc config SSDPSRV start=disabled

echo [101;93m Disable sync host service [0m
sc config OneSyncSvc start=disabled

echo [101;93m Disable NetBIOS service [0m
sc config lmhosts start=disabled

echo [101;93m Disable touch keyboard and handwriting service [0m
sc config TabletInputService start=disabled

echo [101;93m Disable UPnP service [0m
sc config upnphost start=disabled

echo [101;93m Disable Wallet (AppX) service [0m
sc config WalletService start=disabled

echo [101;93m Disable Windows Insider service [0m
sc config wisvc start=disabled

echo [101;93m Disable Windows Store license service [0m
sc config LicenseManager start=disabled

echo [101;93m Disable mobile hotspot service [0m
sc config icssvc start=disabled


:: Networking


echo [101;93m Disable ipv6 [0m
reg add "HKLM\System\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 0xFF /f
netsh int ipv6 set state disabled
netsh int isatap set state disabled

echo [101;93m Disable Teredo [0m
netsh int teredo set state disabled

echo [101;93m Disable 6to4 tunneling [0m
netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled

:: Do not do this, will break "File History", etc
:: echo [101;93m Disable administrative shares [0m
:: reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v AutoShareServer /t REG_DWORD /d 0 /f
:: reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v AutoShareWks /t REG_DWORD /d 0 /f

echo [101;93m Disable memory dump on crash [0m
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0x7 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0x7 /f

echo [101;93m Disable Network Connectivity Assistant [0m
reg add "HKLM\System\CurrentControlSet\Services\NcaSvc" /v "Start" /t REG_DWORD /d "4" /f

echo [101;93m Disable NetBios [0m
reg add "HKLM\System\CurrentControlSet\services\NetBT\Parameters\Interfaces\Tcpip" /v "NetbiosOptions" /t REG_DWORD /d 2 /f
reg add "HKLM\System\CurrentControlSet\Services\NetBT\Parameters" /v "EnableLMHOSTS" /t REG_DWORD /d "0" /f
reg add "HKLM\System\CurrentControlSet\Services\NetBIOS" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\NetBT" /v "Start" /t REG_DWORD /d "4" /f
wmic nicconfig where TcpipNetbiosOptions=0 call SetTcpipNetbios 2
wmic nicconfig where TcpipNetbiosOptions=1 call SetTcpipNetbios 2

echo [101;93m Disable LLTD and SNMP [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" /v AllowRspndrOndomain /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" /v AllowRspndrOnPublicNet /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" /v AllowLLTDIOOndomain /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" /v AllowLLTDIOOnPublicNet /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" /v EnableRspndr /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" /v EnableLLTDIO /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\rspndr" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\lltdio" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\MsLldp" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\SNMP" /v "Start" /t REG_DWORD /d "4" /f

echo [101;93m Disable ip source routing [0m
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v DisableIPSourceRouting /t REG_DWORD /d 2 /f

echo [101;93m Disable Do not resolve unqualified DNS queries [0m
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v UseDomainNameDevolution /t REG_DWORD /d 0 /f

echo [101;93m Disable ICMP redirect [0m
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v EnableICMPRedirect /t REG_DWORD /d 0 /f

echo [101;93m Force-enable Windows Firewall and apply initial settings [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v EnableFirewall /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v DefaultInboundAction /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v DisableUnicastResponsesToMulticastBroadcast /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v EnableFirewall /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v DefaultInboundAction /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v DisableUnicastResponsesToMulticastBroadcast /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v EnableFirewall /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DefaultInboundAction /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DisableUnicastResponsesToMulticastBroadcast /t REG_DWORD /d 1 /f


:: Disable tasks
:: TODO: Test each one again

echo [101;93m Disable tasks that might leak information to Microsoft and Friends [0m
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
schtasks /Change /TN "Microsoft\Windows\PushToInstall\LoginCheck" /disable
schtasks /Change /TN "Microsoft\Windows\PushToInstall\Registration" /disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /disable
del /F /Q "C:\Windows\System32\Tasks\Microsoft\Windows\SettingSync\*"

:: Enable

echo [101;93m Enable Local Security Authority (LSA) hardening [0m
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 00000001 /f

echo [101;93m Always display file extension in Explorer [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

echo [101;93m Warn user on folder merge conflict [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideMergeConflicts /t REG_DWORD /d 0 /f

echo [101;93m Show NTFS-encrypted or compressed files in a different colour [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowEncryptCompressedColor /t REG_DWORD /d 1 /f

echo [101;93m Enforce saving zone information for downloaded files [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 2 /f

echo [101;93m Adjust trust logic for file attachments [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v UseTrustedHandlers /t REG_DWORD /d 3 /f

echo [101;93m Scan attachments with antivirus [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v ScanWithAntiVirus /t REG_DWORD /d 3 /f

echo [101;93m Enable verbose boot and shutdown [0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v VerboseStatus /t REG_DWORD /d 1 /f

echo [101;93m Set DEP policy to OptOut [0m
bcdedit /set {current} nx OptOut

echo [101;93m Enable long paths [0m
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f


echo All done! Press any key to exit...
echo.
set /p done=""
cls