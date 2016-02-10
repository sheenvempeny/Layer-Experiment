//
//  NSColor+CGColor.m
//  LayerExp
//
//  Created by Pradip on 4/27/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//


#import "NSColor+CGColor.h"

@implementation NSColor (CGColor)

- (CGColorRef)CGColor
{
    const NSInteger numberOfComponents = [self numberOfComponents];
    CGFloat components[numberOfComponents];
    CGColorSpaceRef colorSpace = [[self colorSpace] CGColorSpace];
	
    [self getComponents:(CGFloat *)&components];
	
    return (CGColorRef)[(id)CGColorCreate(colorSpace, components) autorelease];
}

+ (NSColor *)colorWithCGColor:(CGColorRef)CGColor
{
    if (CGColor == NULL) return nil;
    return [NSColor colorWithCIColor:[CIColor colorWithCGColor:CGColor]];
}

@end