@echo off

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""$ENV:USERPROFILE\Downloads\FormattingScript-master\FormattingScript-master\script.ps1""' -Verb RunAs}"

exit