#import "BlockEditor.h"

#define KEY_LEFT_ARROW 123
#define KEY_RIGHT_ARROW 124

@implementation BlockEditor

// Private

// Override

- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];

  self.typingAttributes = @{
    NSFontAttributeName : [NSFont systemFontOfSize:24],
  };

  NSString *bullet = @"• \n";
  NSString *initialText = [self.string length] > 0 ? self.string : @"";
  if (![initialText hasPrefix:bullet]) {
    [self setString:[bullet stringByAppendingString:initialText]];
  }

  NSRange insertionPoint = NSMakeRange(2, 0);
  [self setSelectedRange:insertionPoint];

  return self;
}

- (void)mouseDown:(NSEvent *)event {
  [super mouseDown:event];

  NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
  NSUInteger charIndex = [self characterIndexForInsertionAtPoint:point];
  NSRange lineRange =
      [[self string] lineRangeForRange:NSMakeRange(charIndex, 0)];
  NSString *lineText = [[self string] substringWithRange:lineRange];

  NSLog(@"charIndex = %lu", (unsigned long)charIndex);
  NSLog(@"Line text: %@", lineText);

  if ([lineText length] == 0) {
    [self insertText:@"• \n"
        replacementRange:NSMakeRange(lineRange.location, 0)];

    NSUInteger bulletCursorIndex = lineRange.location + 2;
    [self setSelectedRange:NSMakeRange(bulletCursorIndex, 0)];
  }
}

@end
