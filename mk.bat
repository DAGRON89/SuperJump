@echo OFF
IF "%1"=="a" (
    copy System\SuperJumpCOnfig.ini ..\System
)
del ..\System\SuperJump.* && ..\System\ucc.exe make