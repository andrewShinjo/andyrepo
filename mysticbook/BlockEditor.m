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
    NSForegroundColorAttributeName : [NSColor whiteColor]
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

- (void)insertNewline:(id)sender {
  [super insertNewline:sender];

  NSRange cursorRange = self.selectedRange;
  NSString *text = self.string;
  NSRange lineRange = [text lineRangeForRange:cursorRange];

  // After inserting a new line, insert a bullet point.
  [self insertText:@"• " replacementRange:NSMakeRange(lineRange.location, 0)];
}

- (void)mouseDown:(NSEvent *)event {

  NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
  NSUInteger charIndex = [self characterIndexForInsertionAtPoint:point];
  NSRange lineRange =
      [[self string] lineRangeForRange:NSMakeRange(charIndex, 0)];
  NSString *lineText = [[self string] substringWithRange:lineRange];
  NSString *trimmedText = [lineText
      stringByTrimmingCharactersInSet:[NSCharacterSet
                                          whitespaceAndNewlineCharacterSet]];

  // When I press an empty line, insert a bullet point.
  if ([trimmedText length] == 0) {
    [self insertText:@"• \n"
        replacementRange:NSMakeRange(lineRange.location, 0)];

    NSUInteger bulletCursorIndex = lineRange.location + 2;
    [self setSelectedRange:NSMakeRange(bulletCursorIndex, 0)];
  } else {
    [super mouseDown:event];
  }
}

@end
