#import <Cocoa/Cocoa.h>

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSLog(@"Mysticbook [cocoa]");

    NSApplication *app = [NSApplication sharedApplication];

    NSWindow *window = [
      [NSWindow alloc]
      initWithContentRect:NSMakeRect(0, 0, 800, 600)
      styleMask:NSWindowStyleMaskTitled |
        NSWindowStyleMaskClosable |
        NSWindowStyleMaskResizable
      backing:NSBackingStoreBuffered
      defer:NO
    ];

    [window setTitle:@"Mysticbook [cocoa]"];

    [app setActivationPolicy:NSApplicationActivationPolicyRegular];
    [app activateIgnoringOtherApps:YES];
    [window makeKeyAndOrderFront:nil];
    [app run];
  }
  return 0;
}
