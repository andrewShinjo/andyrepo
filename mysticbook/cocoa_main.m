#include "CocoaAppBuilder.h"
#import "CocoaWindowBuilder.h"
#import <Cocoa/Cocoa.h>

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSLog(@"Mysticbook [cocoa]");

    NSApplication *app = [[[CocoaAppBuilder alloc] init] build];

<<<<<<< HEAD
    NSWindow *window =[[[[[
      CocoaWindowBuilder alloc] 
      init] 
      withFrame:NSMakeRect(0,0,800,600)]
      withTitle:@"Mysticbook [cocoa]"]
      build];
=======
    NSWindow *window =
        [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 800, 600)
                                    styleMask:NSWindowStyleMaskTitled |
                                              NSWindowStyleMaskClosable |
                                              NSWindowStyleMaskResizable
                                      backing:NSBackingStoreBuffered
                                        defer:NO];
>>>>>>> cd2f826 (Initial cocoa wrapper)

    [window makeKeyAndOrderFront:nil];
    [app run];
  }
  return 0;
}
