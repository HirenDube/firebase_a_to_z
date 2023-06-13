@echo off
rem This file was created by pub v2.19.3.
rem Package: webdev
rem Version: 2.7.12
rem Executable: webdev
rem Script: webdev
if exist "C:\Users\HP\AppData\Local\Pub\Cache\global_packages\webdev\bin\webdev.dart-2.19.3.snapshot"                                                                                                                                                                           (
  call dart "C:\Users\HP\AppData\Local\Pub\Cache\global_packages\webdev\bin\webdev.dart-2.19.3.snapshot"                                                                                                                                                                           %*
  rem The VM exits with code 253 if the snapshot version is out-of-date.
  rem If it is, we need to delete it and run "pub global" manually.
  if not errorlevel 253 (
    goto error
  )
  call dart pub global run webdev:webdev %*
) else (
  call dart pub global run webdev:webdev %*
)
goto eof
:error
exit /b %errorlevel%
:eof
