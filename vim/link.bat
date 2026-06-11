@echo off
setlocal
pushd %~dp0

REM ------------------------python-------------------------
py --version 2>&1>nul
if not errorlevel 0 (
  winget install Python -e --source winget
  if errorlevel == 1 (
    echo [FAIL] Python not found and could not be installed
    set FAIL=1
  ) else (
    echo [ OK ] Python not found and could not be installed
  )
) else ( 
  echo [ OK ] Python ok
)

REM -------------------------git---------------------------
where git | find "git.exe" 2>&1>nul
if errorlevel == 1 (
  winget install --id Git.Git -e --source winget
  if errorlevel == 1 (
    echo [FAIL] Git not found and could not be installed
    set FAIL=1
  ) else (
    echo [ OK ] Git not found and could not be installed
  )
) else ( 
  echo [ OK ] Git ok
)


REM --------------------- .vimrc --------------------------
set TARGET=%HOMEPATH%\.vimrc
fsutil hardlink list .vimrc | find "%TARGET%" 2>&1>nul
if errorlevel == 1 (
  if EXIST %TARGET% (
    set BKPFILENAME=.vimrc-backup-%DATE:/=-%-%TIME::=.%
    echo The file '%TARGET%' already exists and will be renamed to '%BKPFILENAME%'
    ren "%TARGET%" "%BKPFILENAME%"
  )

  mklink /h "%TARGET%" .vimrc 2>&1>nul
  if errorlevel == 0 (
    echo [ OK ] %TARGET% [link created]
  ) else (
    echo [FAIL] %TARGET% link could not be created
    set FAIL=1
  )
) else ( 
  echo [ OK ] %TARGET%
)


REM ---------------------init.vim--------------------------
if NOT EXIST %LOCALAPPDATA%\nvim mkdir %LOCALAPPDATA%\nvim
set TARGET=%LOCALAPPDATA:~2%\nvim\init.vim
fsutil hardlink list init.vim | find "%TARGET%" 2>&1>NUL
if errorlevel == 1 (
  if EXIST %TARGET% (
    set BKPFILENAME=init.vim-backup-%DATE:/=-%-%TIME::=.%
    echo The file '%TARGET%' already exists and will be renamed to '%BKPFILENAME%'
    ren "%TARGET%" "%BKPFILENAME%"
  )

  mklink /h "%TARGET%" init.vim 2>&1>nul
  if errorlevel == 0 (
    echo [ OK ] %TARGET% [link created]
  ) else (
    echo [FAIL] %TARGET% link could not be created
    set FAIL=1
  )
) else ( 
  echo [ OK ] %TARGET%
)

REM ---------------------ginit.vim--------------------------
set TARGET=%LOCALAPPDATA:~2%\nvim\ginit.vim
fsutil hardlink list ginit.vim | find "%TARGET%" 2>&1>NUL
if errorlevel == 1 (
  if EXIST %TARGET% (
    set BKPFILENAME=ginit.vim-backup-%DATE:/=-%-%TIME::=.%
    echo The file '%TARGET%' already exists and will be renamed to '%BKPFILENAME%'
    ren "%TARGET%" "%BKPFILENAME%"
  )

  mklink /h "%TARGET%" ginit.vim 2>&1>nul
  if errorlevel == 0 (
    echo [ OK ] %TARGET% [link created]
  ) else (
    echo [FAIL] %TARGET% link could not be created
    set FAIL=1
  )
) else ( 
  echo [ OK ] %TARGET%
)

REM ---------------------.vim folder------------------------
set TARGET=%USERPROFILE:~2%\.vim
dir /AL %USERPROFILE%\ | find "%CD%\.vim" 2>&1>NUL
if errorlevel == 1 (
  if EXIST %TARGET% (
    set BKPFILENAME=.vim-backup-%DATE:/=-%-%TIME::=.%
    echo The folder '%TARGET%' already exists and will be renamed to '%BKPFILENAME%'
    ren "%TARGET%" "%BKPFILENAME%"
  )

  mklink /j "%TARGET%" "%CD%\.vim"
  if errorlevel == 0 (
    echo [ OK ] %TARGET% [link created]
  ) else (
    echo [FAIL] %TARGET% link could not be created
    set FAIL=1
  )
) else ( 
  echo [ OK ] %TARGET%
)

if not defined FAIL (
  echo "Vim will open to install packages..."
  nvim-qt -- -c PlugInstall
)
