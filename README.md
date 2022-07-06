# TestSpecDependency

This is an example workspace to demonstrate a CocoaPods issue with unresolved symbols for a dependency of a test spec that uses a custom app host.

## Xcode build log

```
Showing All Messages
Ld /Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Products/Debug-iphonesimulator/TestSpecDependencyLib-AppHost.app/PlugIns/TestSpecDependencyLib-Unit-Tests.xctest/TestSpecDependencyLib-Unit-Tests normal (in target 'TestSpecDependencyLib-Unit-Tests' from project 'Pods')
    cd /Users/knox/src/TestSpecDependency/Pods
    /Applications/Xcode-13.4.1.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -target arm64-apple-ios14.1-simulator -bundle -isysroot /Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator15.5.sdk -L/Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Products/Debug-iphonesimulator -L/Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks -L/Applications/Xcode-13.4.1.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/iphonesimulator -L/Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Products/Debug-iphonesimulator/TestSpecDependencyBase -L/Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Products/Debug-iphonesimulator/TestSpecDependencyLib -L/Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator15.5.sdk/usr/lib/swift -L/Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/lib -F/Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Products/Debug-iphonesimulator -iframework /Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks -iframework /Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator15.5.sdk/Developer/Library/Frameworks -filelist /Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Intermediates.noindex/Pods.build/Debug-iphonesimulator/TestSpecDependencyLib-Unit-Tests.build/Objects-normal/arm64/TestSpecDependencyLib-Unit-Tests.LinkFileList -Xlinker -rpath -Xlinker /usr/lib/swift -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -rpath -Xlinker /usr/lib/swift -Xlinker -rpath -Xlinker /Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -dead_strip -bundle_loader /Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Products/Debug-iphonesimulator/TestSpecDependencyLib-AppHost.app/TestSpecDependencyLib-AppHost -Xlinker -object_path_lto -Xlinker /Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Intermediates.noindex/Pods.build/Debug-iphonesimulator/TestSpecDependencyLib-Unit-Tests.build/Objects-normal/arm64/TestSpecDependencyLib-Unit-Tests_lto.o -Xlinker -export_dynamic -Xlinker -no_deduplicate -Xlinker -objc_abi_version -Xlinker 2 -fobjc-link-runtime -L/Applications/Xcode-13.4.1.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/iphonesimulator -L/usr/lib/swift -Xlinker -add_ast_path -Xlinker /Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Intermediates.noindex/Pods.build/Debug-iphonesimulator/TestSpecDependencyLib-Unit-Tests.build/Objects-normal/arm64/TestSpecDependencyLib_Unit_Tests.swiftmodule -ObjC -lTestSpecDependencyLib -framework XCTest -framework Foundation -Xlinker -no_adhoc_codesign -Xlinker -dependency_info -Xlinker /Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Intermediates.noindex/Pods.build/Debug-iphonesimulator/TestSpecDependencyLib-Unit-Tests.build/Objects-normal/arm64/TestSpecDependencyLib-Unit-Tests_dependency_info.dat -o /Users/knox/Library/Developer/Xcode/DerivedData/TestSpecDependency-buquwtwshqcdvugjeajkneolkerh/Build/Products/Debug-iphonesimulator/TestSpecDependencyLib-AppHost.app/PlugIns/TestSpecDependencyLib-Unit-Tests.xctest/TestSpecDependencyLib-Unit-Tests

Undefined symbols for architecture arm64:
  "(extension in TestSpecDependencyBase):__C.UIWindow.init(rootViewController: __C.UIViewController) -> __C.UIWindow", referenced from:
      TestSpecDependencyLib_Unit_Tests.TestSpecDependencyLibTests.testExtension() throws -> () in TestSpecDependencyLibTests.o
ld: symbol(s) not found for architecture arm64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
```

## Trigger

The problem is triggered by specifying a custom app host dependency in the podspec:

```
  s.test_spec 'Tests' do |t|
    t.source_files = 'TestSpecDependencyLib/Tests/**/*'
    t.requires_app_host = true
    t.app_host_name = 'TestSpecDependencyLib/AppHost'
    t.dependency 'TestSpecDependencyLib/AppHost'
  end

```

With a default app host it just works.

## Notes

* Specifying a custom app host shifts the required `OTHER_LDFLAGS` from the generated xcconfig for the test target to the one for the app host and thus linking fails.
* The problem can be circumvented with `use_frameworks!` in the Podfile.
