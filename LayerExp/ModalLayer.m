//
//  ModalLayer.m
//  LayerExp
//
//  Created by Pradip on 4/24/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//


#import "ModalLayer.h"
#import "NSColor+CGColor.h"
#import "NSObject+Utilities.h"
#import "NSBezierPath+CGPath.h"
#import "LayerLayoutManager.h"

@implementation ModalLayer
@synthesize mModal;
@synthesize expanded;
@synthesize imageLayer;
@synthesize mainTextLayer;
@synthesize subTextLayer;
@synthesize discolureButtonLayer;
@synthesize viewDelegate;
@synthesize mDetailedLayer;



-(BOOL)setupSubLayers
{
	self.needsDisplayOnBoundsChange = YES;
	if(!self.imageLayer)
	{
		imageSize = NSMakeSize(24.0, 24.0);
		self.imageLayer = [CALayer layer];
		self.mainTextLayer = [CATextLayer layer];
		self.subTextLayer = [CATextLayer layer];
		self.discolureButtonLayer = [ButtonLayer layer];
		self.discolureButtonLayer.image = [NSImage imageNamed:@"fold-arrow-left"];
		self.discolureButtonLayer.alternateImage = [NSImage imageNamed:@"fold-arrow"];
		//assigning frame for layers
		self.imageLayer.frame = CGRectMake(0.0, self.bounds.size.height - imageSize.height, imageSize.width, imageSize.height);
		[self addSublayer:self.imageLayer];
		self.imageLayer.autoresizingMask = kCALayerMinXMargin | kCALayerMinYMargin;
		
		
		float textMargin = self.imageLayer.frame.origin.x + self.imageLayer.frame.size.width+11;
		self.mainTextLayer.frame = CGRectMake(textMargin,self.bounds.size.height - 16.0 , self.frame.size.width - (textMargin + 11.0), 16.0);
		[self addSublayer:self.mainTextLayer];
		CGFontRef anotherFont = CGFontCreateWithFontName((__bridge CFStringRef)@"Arial");
		self.mainTextLayer.font = anotherFont;
		self.mainTextLayer.fontSize = 12.0;
		//self.mainTextLayer.font = (id)[NSFont fontWithName:@"Courier" size:12.0];
		self.mainTextLayer.backgroundColor = [[NSColor clearColor] CGColor];
		self.mainTextLayer.wrapped = NO;
		self.mainTextLayer.foregroundColor = [[NSColor blackColor] CGColor];
		self.mainTextLayer.autoresizingMask = kCALayerMinXMargin | kCALayerMinYMargin;
		self.discolureButtonLayer.frame = CGRectMake(self.mainTextLayer.frame.origin.x + self.mainTextLayer.frame.size.width - 10.0, self.bounds.size.height - 10.0, 10.0, 10.0);
		[self addSublayer:self.discolureButtonLayer];
		[self.discolureButtonLayer setState:offState];
		self.discolureButtonLayer.autoresizingMask = kCALayerMinXMargin | kCALayerMinYMargin;
		self.mDetailedLayer = [DetailedLayer layer];
		self.mDetailedLayer.frame = CGRectMake(0.0, -70.0, self.frame.size.width, 70);
		self.mDetailedLayer.autoresizingMask = kCALayerMinXMargin | kCALayerMinYMargin;
		[mDetailedLayer setpSubLayers];
		[self addSublayer:self.mDetailedLayer];
		mDetailedLayer.hidden = YES;
		return  YES;
	}
	
	return NO;
}

- (void)dealloc 
{
	self.subTextLayer = nil;
	self.imageLayer = nil;
	self.mainTextLayer = nil;
	self.discolureButtonLayer = nil;
    [super dealloc];
}

-(void)setStatusImage:(NSImage*)image
{
	self.imageLayer.contents = (id)[self CGImage:image];
	
}

-(void)setTittle:(NSString*)title
{
	self.mainTextLayer.string = title;
	
}

-(void)mouseDownAtPoint:(NSPoint)point
{
	if(expanded)
	{
		
		[self.viewDelegate collpase:self];
	}
	else
	{
	
		[self.viewDelegate expand:self];
	}
}

-(void)setExpanded:(BOOL)inExpanded
{
	if(inExpanded || (expanded != inExpanded))
	{
		if(inExpanded)
		{
			mDetailedLayer.hidden = NO;
			[mDetailedLayer animateTexts:YES];
		}
		else
		{
			[mDetailedLayer animateTexts:NO];
		}
		
	}
	
	expanded = inExpanded;
}



-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
	
	CGColorRef bgColor = [NSColor grayColor].CGColor;
    CGContextSetStrokeColorWithColor(context, bgColor);
//    CGContextFillRect(context, layer.bounds);
	
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 0.0f, 0.0f);
	CGContextAddLineToPoint(context, layer.bounds.size.width, 0.0f);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
	
}

@end
