#import "../include/CocoaWindowBuilder.h"

@implementation CocoaWindowBuilder {
  NSRect _frame;
  NSString *_title;
  NSWindowStyleMask _windowStyleMask;
}

- (instancetype)init {
  self = [super init];
  _windowStyleMask = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | 
    NSWindowStyleMaskResizable;
  return self;
}

- (CocoaWindowBuilder *)withFrame:(NSRect)frame {
  _frame = frame;
  return self;
}

- (CocoaWindowBuilder *)withTitle:(NSString *)title {
  _title = title;
  return self;
}

- (NSWindow *)build {
  NSWindow *window =
      [
        [NSWindow alloc] 
        initWithContentRect:_frame
        styleMask:_windowStyleMask
        backing:NSBackingStoreBuffered
        defer:NO
      ];
  [window setTitle:_title];             
  return window;
}

@end