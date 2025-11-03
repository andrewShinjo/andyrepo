#import "../include/CocoaAppBuilder.h"

@implementation CocoaAppBuilder {

}

- (NSApplication *)build {
  NSApplication *app = [NSApplication sharedApplication];
  [app setActivationPolicy:NSApplicationActivationPolicyRegular];
  [app activateIgnoringOtherApps:YES];
  return app;
}

@end