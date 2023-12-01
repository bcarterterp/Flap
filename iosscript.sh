output="../build/ios_integ"
product="build/ios_integ/Build/Products"
dev_target="17.0"

# Pass --simulator if building for the simulator.
flutter build ios --flavor dev --dart-define="FLAVOR=dev" integration_test/login_test.dart --release

pushd ios
xcodebuild build-for-testing \
  -workspace Runner.xcworkspace \
  -scheme Runner \
  -xcconfig Flutter/Release.xcconfig \
  -configuration Release \
  -derivedDataPath \
  $output -sdk iphoneos
popd

pushd $product
zip -r ios_tests.zip . -i Release-iphoneos Runner_iphoneos17.0-arm64.xctestrun
popd