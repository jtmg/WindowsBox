$oldpath= (Get-ItemPropertyValue -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PATH)
$newpath="$oldpath;C:\Program Files\Java\jdk1.8.0_172\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath
Get-ChildItem -Path c:\"Program Files"\wildfly.zip -File -Recurse | Remove-Item