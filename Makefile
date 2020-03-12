ios-framework:
	if [ -d "build" ]; then rm -r build; fi
	if [ -d "products" ]; then rm -r products; fi

	xcodebuild -project RRuleSwift.xcodeproj -target RRuleSwift-iOS -sdk iphoneos | xcpretty
	xcodebuild -project RRuleSwift.xcodeproj -target RRuleSwift-iOS -sdk iphonesimulator | xcpretty

	lipo build/Release-iphonesimulator/RRuleSwift.framework/RRuleSwift build/Release-iphoneos/RRuleSwift.framework/RRuleSwift -create -output build/Release-iphoneos/RRuleSwift.framework/RRuleSwift
	lipo build/Release-iphonesimulator/RRuleSwift.framework.dSYM/Contents/Resources/DWARF/RRuleSwift build/Release-iphoneos/RRuleSwift.framework.dSYM/Contents/Resources/DWARF/RRuleSwift -create -output build/Release-iphoneos/RRuleSwift.framework.dSYM/Contents/Resources/DWARF/RRuleSwift

	cp -r build/Release-iphonesimulator/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/ build/Release-iphoneos/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule

	mkdir products
	mkdir products/ios

	mv build/Release-iphoneos/RRuleSwift.framework products/ios/RRuleSwift.framework
	mv build/Release-iphoneos/RRuleSwift.framework.dSYM products/ios/RRuleSwift.framework.dSYM

	rm -r build
