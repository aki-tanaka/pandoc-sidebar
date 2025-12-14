cd /d %~dp0

@echo off
set /p input_file="enter the file name to be converted: "

docker run -it --rm -v "%~dp0data:/data" -v "%~dp0template:/usr/local/share/pandoc/templates" tanakaaki/pandoc-diagram-auto:1.0.0 /data/%input_file%

pause
