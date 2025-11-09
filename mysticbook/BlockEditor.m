#import "BlockEditor.h"

@implementation BlockEditor

- (bool)isHeading:(NSString *)line {
  return [line hasPrefix:@"• "];
}

- (void)resetStyling:(NSTextStorage *)storage {
  [storage setAttributes:@{} range:NSMakeRange(0, storage.string.length)];
}

- (void)didChangeText {
  [super didChangeText];
  [self applyHeadingStyles];
}

- (void)applyHeadingStyles {
  NSTextStorage *storage = self.textStorage;
  NSString *text = storage.string;
  NSArray *lines = [text componentsSeparatedByString:@"\n"];

  NSUInteger location = 0;
  [storage beginEditing];
  [storage setAttributes:@{} range:NSMakeRange(0, text.length)];

  for (NSString *line in lines) {
    NSRange lineRange = NSMakeRange(location, line.length);

    if ([line hasPrefix:@"* "] || [line hasPrefix:@"• "]) {
      NSString *bulletLine =
          [@"• " stringByAppendingString:[line substringFromIndex:2]];
      [storage replaceCharactersInRange:lineRange withString:bulletLine];

      // Re-apply style to new range
      NSRange newRange = NSMakeRange(location, bulletLine.length);
      [storage addAttributes:@{
        NSFontAttributeName : [NSFont boldSystemFontOfSize:28],
        NSForegroundColorAttributeName : [NSColor systemBlueColor]
      }
                       range:newRange];

      location += bulletLine.length + 1;
    } else {
      location += line.length + 1;
    }
  }
  [storage endEditing];
}

- (void)mouseDown:(NSEvent *)event {

  NSPoint clickPoint = [self convertPoint:[event locationInWindow]
                                 fromView:nil];
  NSUInteger clickedIndex = [self characterIndexForInsertionAtPoint:clickPoint];
  NSString *text = self.string;
  NSRange lineRange = [text lineRangeForRange:NSMakeRange(clickedIndex, 0)];
  NSString *clickedLine = [text substringWithRange:lineRange];

  NSLog(@"Clicked line: %@", clickedLine);

  if ([self isHeading:clickedLine]) {
    NSUInteger clickedLineIndex = clickedIndex - lineRange.location;
    NSLog(@"Clicked index: %lu\n", (unsigned long)clickedLineIndex);

    if (clickedLineIndex < 2) {
      return;
    }
  }

  [super mouseDown:event];
}

@end