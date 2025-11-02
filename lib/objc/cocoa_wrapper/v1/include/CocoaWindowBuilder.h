#ifndef COCOA_WINDOW_BUILDER_H
#define COCOA_WINDOW_BUILDER_H

#import <Cocoa/Cocoa.h>

@interface CocoaWindowBuilder : NSObject

- (CocoaWindowBuilder *)withFrame:(NSRect)frame;

// Style mask
- (CocoaWindowBuilder *)withStyleClosable;
- (CocoaWindowBuilder *)withStyleResizable;
- (CocoaWindowBuilder *)withStyleTitled;

- (NSWindow *)build;

@end

#endif