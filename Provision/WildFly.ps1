cd c:\"Program Files"
Invoke-WebRequest http://download.jboss.org/wildfly/13.0.0.Beta1/wildfly-13.0.0.Beta1.zip -OutFile wildfly.zip
Expand-Archive c:\"Program Files"\wildfly.zip -DestinationPath c:\"Program Files"
cd \bin
cmd.exe /c 'standalone.bat'