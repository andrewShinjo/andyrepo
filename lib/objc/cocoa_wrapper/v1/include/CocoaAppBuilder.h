#ifndef COCOA_APP_BUILDER_H
#define COCOA_APP_BUILDER_H

#import <Cocoa/Cocoa.h>

@interface CocoaAppBuilder : NSObject

- (NSApplication *)build;

@end

#endif