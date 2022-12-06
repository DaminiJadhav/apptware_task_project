flutter packages pub get

FIREBASE_PROJECT='flutter-integration-tests'
GCLOUD_KEY_FILE='D:\keys/apptwaretaskproject-0cffbf5584b6.json'

cd .. & rm -rf build

flutter build apk --debug

TARGET_DIR="$(pwd)/integration_test/app_text_test.dart"

cd $FCI_BUILD_DIR

pushd android
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug -Ptarget="$FCI_BUILD_DIR/integration_test/app_text_test.dart"

popd

echo $GCLOUD_KEY_FILE | base64 --decode > ./gcloud_key_file.json

gcloud auth activate-service-account --key-file=gcloud_key_file.json

gcloud --quiet config set project apptwaretaskproject

gcloud firebase test android run \
 --type instrumentation \
 --app build/app/outputs/apk/debug/app-debug.apk \
 --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
 --timeout 2m


#storage
#--results-bucket=gs://cripto-moedas-app-appspot.com \
#--results-dir=tests/firebase