rem 创建目录
mkdir target
cd target
mkdir lib
cd ..\sdk
rem 打包jwscalculatorsdk.jar
javac *.java -d .
jar cf ..\target\lib\jwscalculatorsdk.jar gitops\jwscalculator\sdk\*.class
rd /s /q gitops
cd ..
rem 证书和数字签名
keytool -genkey -alias mykey -keystore mykeystore.store -storetype PKCS12 -keyalg RSA -storepass mystorepass  -validity 365 -keysize 2048 -storepass mystorepass -dname "CN=liudongliang, OU=chzu, L=xxxy, S=chuzhou, O=anhui, C=CH"
keytool -export -keystore mykeystore.store -alias mykey -validity 365 -file mykeystore.cert -storepass mystorepass
rem 生成清单文件，打包jwscalculator.jar
javac -cp ".;.\target\lib\jwscalculatorsdk.jar;" GuiCalculator.java -d .
MD META-INF
CD META-INF
ECHO Manifest-Version: 1.0 > MANIFEST.MF
ECHO Created-By: DLL >> MANIFEST.MF
ECHO Main-Class: gitops.jwscalculator.GuiCalculator >> MANIFEST.MF
ECHO Class-Path: lib\jwscalculatorsdk.jar >> MANIFEST.MF
cd ..
jar cfM target\jwscalculator.jar META-INF gitops\jwscalculator\*.class
rd /s /q META-INF
rd /s /q gitops
jarsigner -keystore myKeystore.store target\lib\jwscalculatorsdk.jar mykey -storepass mystorepass
jarsigner -keystore myKeystore.store target\jwscalculator.jar mykey -storepass mystorepass
echo keystore "file:myKeystore.store","PKCS12"; grant signedBy "mykey" { permission java.io.FilePermission"<<ALL FILES>>","read";};>myKeystore.policy
rem 打包jwscalculator.war
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
rem 拷贝本机webapps目录
copy jwscalculator.war "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps"
rem 浏览器启动Java应用：Java web Start
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://localhost:8080/jwscalculator/index.html
rem 本地测试
java -jar jwscalculator.jar
cd ..
rem rd /s /q target
rem .gitignore
rem target/