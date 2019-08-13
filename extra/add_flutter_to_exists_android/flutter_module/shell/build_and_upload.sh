if [ -z $v ]
then
  v='1.0.0'
fi

echo "上传的aar版本号: $v"
echo "准备复制gradle文件"
cp ../template/android/build.gradle ../.android/Flutter
cp ../template/android/settings.gradle ../.android/settings.gradle
echo "复制结束"

cd ../.android
./gradlew :flutter:uploadArchives -Pv=$v