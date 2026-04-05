@echo off
setlocal

if exist ".venv" goto run
if /I "%~1"=="install" shift & goto system
if /I "%~1"=="uninstall" shift & goto system

:run
uv pip %*
goto end

:system
uv pip %* --system

:end

endlocal
