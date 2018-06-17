# instalação do chocolatey para ser mais fácil instalar alguns softwares necessários
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
chocolatey feature enable -n allowGlobalConfirmation
# instalação do chrome, mysql, nodejs, jdk8/jre8, nginx tudo utilizando o chocolatey
choco install googlechrome --ignore-cheksums
choco install mysql.utilities
choco install mysql
choco install nodejs --version 8.10.0
choco install jdk8
choco install jre8
choco install nginx
choco install nginx-service

$TARGETDIR = 'C:\Mongo'
# guarda para ver se o diretorio para a instalação do mongo db ja esta presente
 if(!(Test-Path -Path $TARGETDIR )){
     
mkdir C:\Mongo\data\db
mkdir C:\Mongo\data\log
 
"" > C:\Mongo\data\log\mongod.log
 
# The minimum needed for a MongoDB config file
 
@"
systemLog:
    destination: file
    path: C:\Mongo\data\log\mongod.log
storage:
    dbPath: C:\Mongo\data\db
"@	> "C:\Mongo\mongod.cfg"
# link para descarregar o mongodb
Invoke-WebRequest http://downloads.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-v3.2-latest-signed.msi?_ga=1.56414827.19723263.1478030430 -OutFile mongodb.msi 
 
# começa a intalação do mongodb de forma silenciosa
start-process mongodb.msi /qn -Wait
# mete o mongodb a correr como serviço
new-service -Name "MongoDB" -binaryPathName '"C:\Program Files\MongoDB\Server\3.2\bin\mongod.exe" --service --config "C:\Mongo\mongod.cfg"' -DisplayName "MongoDB" -StartupType Automatic
 
Start-Service -DisplayName "MongoDB"
 }
 else
 {
     #caso o mongodb ja esteja instalado para não instalar novamente 
     echo "Mongo is already installed"
 }

# definir as variáveis de ambiente necessárias para correr os programas necessários, o diretorio do powershelll teve de ser adicionado porque a máquina não estava a correr os scrips de aprovisionamento uma segunda vez se fosse necessário
$oldpath= (Get-ItemPropertyValue -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PATH)
$newpath="$oldpath;C:\Program Files\MongoDB\Server\3.2\bin;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Java\jdk1.8.0_172\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath



cd c:\"Program Files"
$TARGETDIR = "C:\Program Files\wildfly-13.0.0.Beta1"
#verificação para ver se o wildfly ja está criado
if(!(Test-Path -Path $TARGETDIR )){
    Invoke-WebRequest http://download.jboss.org/wildfly/13.0.0.Beta1/wildfly-13.0.0.Beta1.zip -OutFile wildfly.zip
    Expand-Archive c:\"Program Files"\wildfly.zip -DestinationPath c:\"Program Files"
}else
{
    echo "WildFLy already exists"
}


#copiar para a pasta bin o diretorio onde está os scripts para por o wildfly como serviçlo
Copy-Item c:\"Program Files"\wildfly-13.0.0.Beta1\docs\contrib\scripts\service -Destination c:\"Program Files"\wildfly-13.0.0.Beta1\bin -Recurse
cd c:\"Program Files"\wildfly-13.0.0.Beta1\bin\service

#meter o wildfly como serviço
./service.bat install
Start-Service -Name "WildFly"
Set-Service -Name "WildFly" -StartupType Automatic





