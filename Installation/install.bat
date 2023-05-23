platform-tools\adb.exe shell "echo $EXTERNAL_STORAGE" 
platform-tools\adb.exe shell "pm list packages com.Barnaque.Virtualite" 
platform-tools\adb.exe uninstall com.Barnaque.Virtualite 
platform-tools\adb.exe install "Binaries\Virtualite-armv7.apk" 
platform-tools\adb.exe shell "pm grant com.Barnaque.Virtualite android.permission.READ_EXTERNAL_STORAGE" 
platform-tools\adb.exe shell "pm grant com.Barnaque.Virtualite android.permission.WRITE_EXTERNAL_STORAGE" 
platform-tools\adb.exe shell "rm -r /sdcard/UE4Game/Virtualite" 
platform-tools\adb.exe push "Android_ASTC" "/sdcard/UE4Game/Virtualite"
platform-tools\adb.exe shell "rm /sdcard/obb/com.Barnaque.Virtualite/main.1.com.Barnaque.Virtualite.obb" 
platform-tools\adb.exe shell "rm /sdcard/obb/com.Barnaque.Virtualite/patch.1.com.Barnaque.Virtualite.obb"  
platform-tools\adb.exe shell "rm /sdcard/obb/com.Barnaque.Virtualite/overflow1.1.com.Barnaque.Virtualite.obb" 
platform-tools\adb.exe shell "rm /sdcard/obb/com.Barnaque.Virtualite/overflow2.1.com.Barnaque.Virtualite.obb" 
platform-tools\adb.exe shell "echo 'APK: 2023-05-17 1:33:39 PM' > /sdcard/UE4Game/Virtualite/APKFileStamp.txt" 
platform-tools\adb.exe shell getprop ro.product.cpu.abi 
platform-tools\adb.exe logcat -c 
platform-tools\adb.exe shell "am start -n com.Barnaque.Virtualite/com.epicgames.ue4.GameActivity" 
echo "INSTALLATION TERMINÉE"
sleep 3