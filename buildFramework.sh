PRODUCTS_PATH=${PWD}/products
PRODUCTS_IOS_PATH=${PRODUCTS_PATH}/ios
WORKSPACE=RRuleSwift.xcworkspace
SCHEME="RRuleSwift iOS"
FRAMEWORK_NAME=RRuleSwift
FRAMEWORK=${FRAMEWORK_NAME}.framework
DEVICE_ARCHIVE=${FRAMEWORK_NAME}-iOS
SIM_ARCHIVE=${FRAMEWORK_NAME}-Sim

if [ -d "products" ]; then rm -rf products; fi

mkdir products
mkdir products/ios

echo "XCFramework: Archiving DEVICE type..."
xcodebuild archive -workspace "${WORKSPACE}" -scheme "${SCHEME}" -destination 'generic/platform=iOS' -archivePath "${PRODUCTS_IOS_PATH}/${DEVICE_ARCHIVE}" SKIP_INSTALL=NO | xcpretty

echo "XCFramework: Archiving SIMULATOR type..."
xcodebuild archive -workspace "${WORKSPACE}" -scheme "${SCHEME}" -destination 'generic/platform=iOS Simulator' -archivePath "${PRODUCTS_IOS_PATH}/${SIM_ARCHIVE}" SKIP_INSTALL=NO | xcpretty

# First, get all the UUID filepaths for BCSymbolMaps, because these are randomly generated and need to be individually added as the `-debug-symbols` parameter. The dSYM path is always the same so that one is manually added
echo "XCFramework: Generating IPHONE BCSymbolMap paths..."
IPHONE_BCSYMBOLMAP_PATHS=(${PRODUCTS_IOS_PATH}/${DEVICE_ARCHIVE}.xcarchive/BCSymbolMaps/*)
IPHONE_BCSYMBOLMAP_COMMANDS=""

for path in "${IPHONE_BCSYMBOLMAP_PATHS[@]}"; do
  IPHONE_BCSYMBOLMAP_COMMANDS="$IPHONE_BCSYMBOLMAP_COMMANDS -debug-symbols $path "
  echo $IPHONE_BCSYMBOLMAP_COMMANDS
done

echo "XCFramework: Creating XCFramework file"
xcodebuild -create-xcframework -framework "${PRODUCTS_IOS_PATH}/${DEVICE_ARCHIVE}.xcarchive/Products/Library/Frameworks/${FRAMEWORK}" -debug-symbols "${PRODUCTS_IOS_PATH}/${DEVICE_ARCHIVE}.xcarchive/dSYMs/${FRAMEWORK}.dSYM" $IPHONE_BCSYMBOLMAP_COMMANDS -framework "${PRODUCTS_IOS_PATH}/${SIM_ARCHIVE}.xcarchive/Products/Library/Frameworks/${FRAMEWORK}" -debug-symbols "${PRODUCTS_IOS_PATH}/${SIM_ARCHIVE}.xcarchive/dSYMs/${FRAMEWORK}.dSYM" -output "${PRODUCTS_IOS_PATH}/${FRAMEWORK_NAME}.xcframework"
