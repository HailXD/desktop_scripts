@echo off
setlocal

if /I "%~1"=="install" (
  shift
  uv pip %* --system
) else if /I "%~1"=="uninstall" (
  shift
  uv pip %* --system
) else (
  uv pip %*
)

endlocal
