@echo off

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList 'NoProfile -ExecutionPolicy RemoteSigned -Force' -File ""D:\Projects\Formattingscript\script.ps1""' -Verb RunAs}"

