mkdir target
cd target
mkdir lib
mkdir plugins
cd ..\sdk
javac *.java -d .
jar cf ..\target\lib\jwscalculatorsdk.jar gitops\jwscalculator\sdk\*.class
rd /s /q gitops
cd ..
javac -cp ".;.\target\lib\jwscalculatorsdk.jar" plugins\*.java -d target\plugins
cd .\target\plugins
jar cf plugins.jar gitops\jwscalculator\plugin\*.class
rd /s /q gitops 
cd ..\..\
keytool -genkey -alias mykey -keystore mykeystore.store -storetype PKCS12 -keyalg RSA -storepass mystorepass  -validity 365 -keysize 2048 -storepass mystorepass -dname "CN=liudongliang, OU=chzu, L=xxxy, S=chuzhou, O=anhui, C=CH"
keytool -export -keystore mykeystore.store -alias mykey -validity 365 -file mykeystore.cert -storepass mystorepass
javac -cp ".;.\target\lib\jwscalculatorsdk.jar;.\target\plugins\plugins.jar" GuiCalculator.java -d .
MD META-INF
CD META-INF
ECHO Manifest-Version: 1.0 > MANIFEST.MF
ECHO Created-By: DLL >> MANIFEST.MF
ECHO Main-Class: gitops.jwscalculator.GuiCalculator >> MANIFEST.MF
ECHO Class-Path: lib\jwscalculatorsdk.jar plugins\plugins.jar >> MANIFEST.MF
cd ..
jar cfM target\jwscalculator.jar META-INF gitops\jwscalculator\*.class
rd /s /q META-INF
rd /s /q gitops
jarsigner -keystore myKeystore.store target\lib\jwscalculatorsdk.jar mykey -storepass mystorepass
jarsigner -keystore myKeystore.store target\plugins\plugins.jar mykey -storepass mystorepass
jarsigner -keystore myKeystore.store target\jwscalculator.jar mykey -storepass mystorepass
echo keystore "file:myKeystore.store","PKCS12"; grant signedBy "mykey" { permission java.io.FilePermission"<<ALL FILES>>","read";};>myKeystore.policy
copy mykeystore.policy target
copy mykeystore.store target
copy mykeystore.cert target
del mykeystore.policy
del mykeystore.store
del mykeystore.cert
copy index.html target
copy jwscalculator.jnlp target
cd target
jar cf jwscalculator.war *
copy jwscalculator.war "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps"
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://localhost:8080/jwscalculator/index.html
java -jar jwscalculator.jar
cd ..
rem rd /s /q target
rem .gitignore
rem target/