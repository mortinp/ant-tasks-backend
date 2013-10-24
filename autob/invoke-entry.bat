@echo off

set script_dir=%~dp0
set script_dir=%script_dir%##
set script_dir=%script_dir:\##=##%
set script_dir=%script_dir:##=%

"%script_dir%/invoke.bat" "deploy" "ftp-transfer"

echo "Press 'ENTER' to continue..."
pause
