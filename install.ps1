﻿# instalaÃ§Ã£o do chocolatey para ser mais fÃ¡cil instalar alguns softwares necessÃ¡rios
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
chocolatey feature enable -n allowGlobalConfirmation

choco install vagrant
choco install virtualbox
choco install git.install

cd C:\\Users\vagrant\Desktop
git clone https://github.com/jtmg/WindowsBox
cd .\WindowsBox\vagrant up