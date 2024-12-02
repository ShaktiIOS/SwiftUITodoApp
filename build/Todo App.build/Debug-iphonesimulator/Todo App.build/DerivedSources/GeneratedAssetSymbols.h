#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.yusata.Todo-App";

/// The "ColorBackground" asset catalog color resource.
static NSString * const ACColorNameColorBackground AC_SWIFT_PRIVATE = @"ColorBackground";

/// The "ColorBase" asset catalog color resource.
static NSString * const ACColorNameColorBase AC_SWIFT_PRIVATE = @"ColorBase";

/// The "illustration-no1" asset catalog image resource.
static NSString * const ACImageNameIllustrationNo1 AC_SWIFT_PRIVATE = @"illustration-no1";

/// The "illustration-no2" asset catalog image resource.
static NSString * const ACImageNameIllustrationNo2 AC_SWIFT_PRIVATE = @"illustration-no2";

/// The "illustration-no3" asset catalog image resource.
static NSString * const ACImageNameIllustrationNo3 AC_SWIFT_PRIVATE = @"illustration-no3";

/// The "todo-app-logo" asset catalog image resource.
static NSString * const ACImageNameTodoAppLogo AC_SWIFT_PRIVATE = @"todo-app-logo";

#undef AC_SWIFT_PRIVATE
