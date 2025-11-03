#include "CocoaAppBuilder.h"
#import "CocoaWindowBuilder.h"
#import <Cocoa/Cocoa.h>

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSLog(@"Mysticbook [cocoa]");

    NSApplication *app = [[[CocoaAppBuilder alloc] init] build];

    NSWindow *window =[[[[[
      CocoaWindowBuilder alloc] 
      init] 
      withFrame:NSMakeRect(0,0,800,600)]
      withTitle:@"Mysticbook [cocoa]"]
      build];

    [window makeKeyAndOrderFront:nil];
    [app run];
  }
  return 0;
}
