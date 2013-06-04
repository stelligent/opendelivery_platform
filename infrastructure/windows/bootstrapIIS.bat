:#
setlocal

set CDOPGitRepoUrl=%1
set Branch=%2

set chef="C:\chef"
set opscode="C:\opscode"
set git="C:\Program Files (x86)\Git"
set bootstrap="C:\bootstrap"

set PATH=%PATH%;%opscode%\bin;%git%\bin

PATH
set


mkdir %bootstrap%
pushd %bootstrap%


if NOT "%BRANCH%"=="" GOTO :RepoBranch  
  git clone %CDOPGitRepoUrl% cdop
  goto :Done
:RepoBranch
  git clone -b %Branch% %CDOPGitRepoUrl% cdop

:Done
cd "cdop\infrastructure\windows"

PowerShell  -c "Set-ExecutionPolicy RemoteSigned -Force"
PowerShell.exe .\chef-iis.ps1

popd