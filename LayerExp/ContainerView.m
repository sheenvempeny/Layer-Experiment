//
//  ContainerView.m
//  LayerExp
//
//  Created by Pradip on 4/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ContainerView.h"

@implementation ContainerView
@synthesize delegate;
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
	// Drawing code here.
	[[NSColor colorWithDeviceRed:252.0/255.0 green:253.0/255.0 blue:249.0/255.0 alpha:1.0] set];
	NSRectFill(dirtyRect);
	
}

-(void)mouseDown:(NSEvent *)theEvent
{
	[self.delegate mouseDown:theEvent forView:self];
	[super mouseDown:theEvent];
}

@end
