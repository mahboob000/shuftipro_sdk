#import "ShuftiproSdk.h"
#if __has_include(<shuftipro_sdk/shuftipro_sdk-Swift.h>)
#import <shuftipro_sdk/shuftipro_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shuftipro_sdk-Swift.h"
#endif

@implementation ShuftiproSdk
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftShuftiproSdk registerWithRegistrar:registrar];
}
@end
