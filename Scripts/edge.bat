::
:: https://github.com/stoptracking/windows10
::

@echo off
SETLOCAL EnableDelayedExpansion

echo This should be run with Administrator privileges, otherwise errors will occur.
set /p rtg="Press any key if you are ready, close this window if not."
cls

echo [101;93m Do not show spam at the start page [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\ServiceUI" /t REG_DWORD /v AllowWebContentOnNewTabPage /d 0 /f

echo [101;93m Prevent the First Run webpage from opening [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /t REG_DWORD /v PreventFirstRunPage /d 1 /f

echo [101;93m Do not update books [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\BooksLibrary" /t REG_DWORD /v AllowConfigurationUpdateForBooksLibrary /d 0 /f

echo [101;93m Do not send text typed in the address bar without user's consent [0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\ServiceUI" /t REG_DWORD /v ShowOneBox /d 0 /f

set /p done=""