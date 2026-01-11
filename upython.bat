@echo off
setlocal

if exist ".venv\Scripts\python.exe" (
  uv run "%~1"
) else (
  python "%~1"
)

endlocal
