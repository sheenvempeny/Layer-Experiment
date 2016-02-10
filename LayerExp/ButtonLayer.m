//
//  ButtonLayer.m
//  LayerExp
//
//  Created by Pradip on 4/28/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ButtonLayer.h"
#import "NSObject+Utilities.h"

@implementation ButtonLayer

@synthesize state;
@synthesize highLight;
@synthesize image;
@synthesize alternateImage;

-(void)update
{
	if(highLight || state == onState)
		self.contents = (id)[self CGImage:alternateImage];
	else
		self.contents = (id)[self CGImage:image];
}

-(void)setHighLight:(BOOL)inHighLight
{
	highLight = inHighLight;
	[self update];
}

-(void)setState:(EState)inState
{
	state = inState;
	[self update];
}

- (void)dealloc {
    
	self.image = nil;
	self.alternateImage = nil;
    [super dealloc];
}


@end
