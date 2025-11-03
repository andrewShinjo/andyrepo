#ifndef COCOA_WINDOW_BUILDER_H
#define COCOA_WINDOW_BUILDER_H

#import <Cocoa/Cocoa.h>

@interface CocoaWindowBuilder : NSObject

- (CocoaWindowBuilder *)withFrame:(NSRect)frame;
- (CocoaWindowBuilder *)withTitle:(NSString *)title;
- (NSWindow *)build;

@end

#endif