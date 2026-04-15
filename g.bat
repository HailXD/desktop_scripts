@echo off
setlocal

if not exist ".git\" goto end

if not exist ".g" type nul > ".g"

if not exist ".gitignore" (
  > ".gitignore" <nul set /p "=.g"
  goto end
)

for %%A in (".gitignore") do if %%~zA==0 (
  > ".gitignore" <nul set /p "=.g"
  goto end
)

more < ".gitignore" | findstr /x /c:".g" >nul 2>nul && goto end
more < ".gitignore" | findstr /x /c:".*" >nul 2>nul && goto end

>> ".gitignore" echo(
>> ".gitignore" <nul set /p "=.g"

:end

endlocal
