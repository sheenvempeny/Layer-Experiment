//
//  NSBezierPath+CGPath.h
//  LayerExp
//
//  Created by Pradip on 4/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSBezierPath (CGPath)

- (CGPathRef)quartzPath;

@end
