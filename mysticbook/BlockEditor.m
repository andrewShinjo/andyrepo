#import "BlockEditor.h"
#include <AppKit/AppKit.h>

@implementation BlockEditor

// "• |"
//

// Private

// Override

- (void)deleteBackward:(id)sender {

  // Get the position of the cursor.
  NSRange cursorPosition = self.selectedRange;
  // Get the index corresponding to the cursor in the string.
  NSUInteger charIndex = cursorPosition.location;
  // Get the string.
  NSString *text = self.string;
  // Get the entire line that contains the cursor.
  NSRange lineRange = [text lineRangeForRange:cursorPosition];
  // Get the text on the line.
  NSString *lineText = [text substringWithRange:lineRange];
  // Get cursor index on the current line.
  NSUInteger lineOffset = charIndex - lineRange.location;

  if ([lineText hasPrefix:@"• "] && lineOffset == 2) {
    // If we're on the first line, then do nothing.
    if (lineRange.location == 0) {
      return;
    }

    // Delete the \n on the previous line + the current line
    // to delete the current line and move the insertion point up.
    NSRange deleteRange = NSMakeRange(lineRange.location - 1, lineRange.length);
    [self.textStorage deleteCharactersInRange:deleteRange];
  } else {
    [super deleteBackward:self];
  }
}

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

  // If this is the last line, then insert a new line.

  NSRange endLineRange = [text lineRangeForRange:NSMakeRange(text.length, 0)];

  if (NSEqualRanges(lineRange, endLineRange)) {
    [self insertText:@"\n" replacementRange:self.selectedRange];
  }
}

- (void)keyDown:(NSEvent *)event {
  NSString *chars = [event charactersIgnoringModifiers];
  unichar keyChar = [chars characterAtIndex:0];

  // Get the position of the cursor.
  NSRange cursorRange = self.selectedRange;
  // Get the index corresponding to the cursor in the string.
  NSUInteger charIndex = cursorRange.location;
  // Get the string.
  NSString *text = self.string;
  // Get the entire line that contains the cursor.
  NSRange lineRange = [text lineRangeForRange:cursorRange];
  // Get the text on the line.
  NSString *lineText = [text substringWithRange:lineRange];
  // Get cursor index on the current line.
  NSUInteger lineOffset = charIndex - lineRange.location;

  // Do nothing rule:
  if ([lineText hasPrefix:@"• "] && lineOffset == 2 &&
      keyChar == NSLeftArrowFunctionKey) {
    return;
  }

  [super keyDown:event];
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
  NSUInteger lineOffset = charIndex - lineRange.location;

  // Do nothing rules.
  if ([lineText hasPrefix:@"• "] && lineOffset < 2) {
    return;
  }

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
