## This script automates the process of deploying our integration tests to Firebase Test Labs
## To use this script, you must pull the service account private key file from OnePassword
## and place it in the root directory

## Variables
path_to_test="./integration_test/login_test.dart"
path_to_service_account_key_file="./equifax---test-09535c4e9a7c.json"
project=equifax---test

pushd android
# flutter build generates files in android/ for building the app
flutter build apk --flavor dev --dart-define="FLAVOR=dev"
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug -Ptarget=integration_test/login_test.dart
popd

# Install Google Cloud CLI
brew install --cask google-cloud-sdk

# Authenticate using service account and send the test apks to Firebase
gcloud auth activate-service-account --key-file=$path_to_service_account_key_file
gcloud --quiet config set project $project
gcloud firebase test android run --type instrumentation \
  --app build/app/outputs/apk/dev/debug/app-dev-debug.apk \
  --test build/app/outputs/apk/androidTest/dev/debug/app-dev-debug-androidTest.apk\
  --timeout 2m \
  --results-dir="./"