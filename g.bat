@echo off
setlocal

if not exist ".git\" goto end

if not exist ".g" type nul > ".g"

if not exist ".gitignore" (
  > ".gitignore" echo .g
  goto end
)

for %%A in (".gitignore") do if %%~zA==0 (
  > ".gitignore" echo .g
  goto end
)

findstr /x /c:".g" ".gitignore" >nul 2>nul && goto end
findstr /x /c:".*" ".gitignore" >nul 2>nul && goto end

>> ".gitignore" echo(
>> ".gitignore" echo .g

:end

endlocal
