#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>
#import <MetalKit/MetalKit.h>
#import <CoreText/CoreText.h>

#import "CocoaAppBuilder.h"
#import "CocoaWindowBuilder.h"

CGImageRef createTextImage(NSString *text, CGSize size, CGFloat scale) {
    NSDictionary *attrs = @{
        NSFontAttributeName: [NSFont systemFontOfSize:32],
        NSForegroundColorAttributeName: NSColor.whiteColor
    };
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:attrs];

    CGContextRef context = CGBitmapContextCreate(NULL,
        size.width * scale, size.height * scale,
        8, 0,
        CGColorSpaceCreateDeviceRGB(),
        kCGImageAlphaPremultipliedLast);
    CGContextScaleCTM(context, scale, scale);
    CGContextSetFillColorWithColor(context, NSColor.clearColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, size.width, size.height), NULL);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, NULL);
    CTFrameDraw(frame, context);

    CGImageRef image = CGBitmapContextCreateImage(context);
    CFRelease(frame); CFRelease(path); CFRelease(framesetter); CGContextRelease(context);
    return image;
}

id<MTLTexture> createTextureFromImage(id<MTLDevice> device, CGImageRef image) {
    MTKTextureLoader *loader = [[MTKTextureLoader alloc] initWithDevice:device];
    NSError *error = nil;
    return [loader newTextureWithCGImage:image options:@{ MTKTextureLoaderOptionSRGB : @NO } error:&error];
}

void drawTextToMetal(CAMetalLayer *metalLayer, NSString *text) {
    id<MTLDevice> device = metalLayer.device;
    id<MTLCommandQueue> commandQueue = [device newCommandQueue];
    id<CAMetalDrawable> drawable = [metalLayer nextDrawable];
    if (!drawable) return;

    CGSize textSize = CGSizeMake(512, 128);
    CGFloat scale = [NSScreen mainScreen].backingScaleFactor;
    CGImageRef textImage = createTextImage(text, textSize, scale);
    id<MTLTexture> textTexture = createTextureFromImage(device, textImage);
    CGImageRelease(textImage);

    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    id<MTLBlitCommandEncoder> blit = [commandBuffer blitCommandEncoder];
    [blit copyFromTexture:textTexture
              sourceSlice:0 sourceLevel:0
             sourceOrigin:MTLOriginMake(0, 0, 0)
               sourceSize:MTLSizeMake(textTexture.width, textTexture.height, 1)
                toTexture:drawable.texture
         destinationSlice:0 destinationLevel:0
        destinationOrigin:MTLOriginMake(0, 0, 0)];
    [blit endEncoding];
    [commandBuffer presentDrawable:drawable];
    [commandBuffer commit];
}

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

    drawTextToMetal(metalLayer, @"Hello CoreText in Metal!");

    [window makeKeyAndOrderFront:nil];
    [app run];
  }
  return 0;
}
