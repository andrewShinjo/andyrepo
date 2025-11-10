#ifndef BLOCK_EDITOR_H
#define BLOCK_EDITOR_H

#include <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

@interface BlockEditor : NSTextView

@property (nonatomic) CGFloat currentFontSize;

@end

#endif