@echo off
setlocal

if exist ".g" goto end

type nul > ".g"

if not exist ".gitignore" (
  powershell -NoProfile -Command "[IO.File]::WriteAllText('.gitignore','.g')"
  goto end
)

powershell -NoProfile -Command "$text=[IO.File]::ReadAllText('.gitignore'); $lines=$text -split '\r?\n'; if ($lines.Contains('.g') -or $lines.Contains('.*')) { exit 0 } else { exit 1 }"
if not errorlevel 1 goto end

powershell -NoProfile -Command "$text=[IO.File]::ReadAllText('.gitignore'); $trimmed=$text -replace '(?s)(?:\r?\n[ \t]*)+\z',''; if ([string]::IsNullOrWhiteSpace($trimmed)) { [IO.File]::WriteAllText('.gitignore','.g') } else { [IO.File]::WriteAllText('.gitignore',$trimmed + [Environment]::NewLine + '.g') }"

:end

endlocal
