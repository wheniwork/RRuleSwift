ios-framework:
	if [ -d "build" ]; then rm -r build; fi
	if [ -d "products" ]; then rm -r products; fi

	xcodebuild -project RRuleSwift.xcodeproj -target RRuleSwift-iOS -sdk iphoneos | xcpretty
	xcodebuild -project RRuleSwift.xcodeproj -target RRuleSwift-iOS -sdk iphonesimulator | xcpretty

	lipo build/Release-iphonesimulator/RRuleSwift.framework/RRuleSwift build/Release-iphoneos/RRuleSwift.framework/RRuleSwift -create -output build/Release-iphoneos/RRuleSwift.framework/RRuleSwift

	mv build/Release-iphonesimulator/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/i386.swiftdoc build/Release-iphoneos/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/ 
	mv build/Release-iphonesimulator/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/i386.swiftmodule build/Release-iphoneos/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/ 
	mv build/Release-iphonesimulator/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/x86_64.swiftdoc build/Release-iphoneos/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/ 
	mv build/Release-iphonesimulator/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/x86_64.swiftmodule build/Release-iphoneos/RRuleSwift.framework/Modules/RRuleSwift.swiftmodule/ 

	mkdir products
	mkdir products/ios

	mv build/Release-iphoneos/RRuleSwift.framework products/ios/RRuleSwift.framework

	rm -r build
