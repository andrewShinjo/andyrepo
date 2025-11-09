#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>

#import "BlockEditor.h"
#import "CocoaAppBuilder.h"
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

    // Add a scroll view.
    NSScrollView *scrollView = 
      [[NSScrollView alloc] initWithFrame:[[window contentView] bounds]];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [scrollView setHasVerticalScroller:YES];

    // Add a text view.
    BlockEditor *blockEditor = 
      [[BlockEditor alloc] initWithFrame:[[scrollView contentView] bounds]];
    [blockEditor setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [blockEditor setEditable:YES];
    [blockEditor setRichText:YES];

    // Add text view to window.
    [scrollView setDocumentView:blockEditor];
    [[window contentView] addSubview:scrollView];

    [window makeKeyAndOrderFront:nil];
    [app run];
  }
  return 0;
}
