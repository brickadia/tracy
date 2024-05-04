@echo off

:: Check VS installer
if not exist "C:\Program Files (x86)\Microsoft Visual Studio\Installer" (
	echo Error: Visual Studio is not installed.
	exit /b 1
)

:: Locate MSBuild
pushd "C:\Program Files (x86)\Microsoft Visual Studio\Installer"
for /f "usebackq tokens=* delims=" %%i in (`vswhere.exe -version "[17.0,18.0)" -products * -requires Microsoft.Component.MSBuild -property installationPath -nologo`) do (
	set VisualStudioLocation=%%i
)
popd

if not exist "%VisualStudioLocation%" (
	echo Error: Visual Studio is not installed.
	exit /b 1
)

:: Generate
if exist "%~dp0profiler\build" rmdir /s /q "%~dp0profiler\build"
mkdir "%~dp0profiler\build"

pushd "%~dp0profiler\build"
cmake -G "Visual Studio 17 2022" ..
popd
