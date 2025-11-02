#import "../include/CocoaWindowBuilder.h"

@implementation CocoaWindowBuilder {
  NSRect _frame;
  NSWindowStyleMask _windowStyleMask;
}

- (CocoaWindowBuilder *)withFrame:(NSRect)frame {
  _frame = frame;
  return self;
}

- (CocoaWindowBuilder *)withStyleClosable {
  _windowStyleMask |= NSWindowStyleMaskClosable;
  return self;
}

- (CocoaWindowBuilder *)withStyleResizable {
  _windowStyleMask |= NSWindowStyleMaskResizable;
  return self;
}

- (CocoaWindowBuilder *)withStyleTitled {
  _windowStyleMask |= NSWindowStyleMaskTitled;
  return self;
}

- (NSWindow *)build {
  NSWindow *window =
      [[NSWindow alloc] initWithContentRect:_frame
                                  styleMask:_windowStyleMask
                                    backing:NSBackingStoreBuffered
                                      defer:NO];
  return window;
}

@end