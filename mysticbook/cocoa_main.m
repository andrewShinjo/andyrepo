#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>

#include "CocoaAppBuilder.h"
#import "CocoaWindowBuilder.h"

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

    NSView *contentView = window.contentView;
    contentView.wantsLayer = true;

    // Setup metal.
    CAMetalLayer *metalLayer = [CAMetalLayer layer];
    metalLayer.device = MTLCreateSystemDefaultDevice();
    metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    metalLayer.frame = contentView.bounds;
    metalLayer.contentsScale = [NSScreen mainScreen].backingScaleFactor;
    [contentView.layer addSublayer:metalLayer];

    // Draw something in metal.
    id<MTLDevice> device = metalLayer.device;
    id<MTLCommandQueue> commandQueue = [device newCommandQueue];
    id<CAMetalDrawable> drawable = [metalLayer nextDrawable];

    if(drawable) {
      MTLRenderPassDescriptor *renderPassDescriptor 
        = [MTLRenderPassDescriptor renderPassDescriptor];
      renderPassDescriptor.colorAttachments[0].texture = drawable.texture;
      renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
      renderPassDescriptor.colorAttachments[0].clearColor 
        = MTLClearColorMake(0.2, 0.4, 0.6, 1.0);
      
      id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
      id<MTLRenderCommandEncoder> renderCommandEncoder = [
        commandBuffer 
        renderCommandEncoderWithDescriptor:renderPassDescriptor
      ];
      [renderCommandEncoder endEncoding];
      [commandBuffer presentDrawable:drawable];
      [commandBuffer commit];
    }

    [window makeKeyAndOrderFront:nil];
    [app run];
  }
  return 0;
}
