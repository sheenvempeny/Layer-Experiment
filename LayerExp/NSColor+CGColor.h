//
//  NSColor+CGColor.m
//
//  Created by Michael Sanders on 11/19/10.
//

#import <AppKit/AppKit.h>

@interface NSColor (CGColor)

//
// The Quartz color reference that corresponds to the receiver's color.
//
@property (nonatomic, readonly) CGColorRef CGColor;

//
// Converts a Quartz color reference to its NSColor equivalent.
//
+ (NSColor *)colorWithCGColor:(CGColorRef)color;

@end