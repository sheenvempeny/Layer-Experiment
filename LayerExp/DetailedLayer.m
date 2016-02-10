//
//  DetailedLayer.m
//  LayerExp
//
//  Created by Pradip on 4/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "DetailedLayer.h"
#import "NSColor+CGColor.h"
#import "NSObject+Utilities.h"

@implementation DetailedLayer

@synthesize downloadTextLayer;
@synthesize uploadTextLayer;
@synthesize animate;
@synthesize uploadString;
@synthesize downloadString;

-(void)setpSubLayers
{
	if(!downloadTextLayer)
	{
		downloadTextLayer = [CATextLayer layer];
		CGFontRef anotherFont = CGFontCreateWithFontName((__bridge CFStringRef)@"Arial");
		downloadTextLayer .font = anotherFont;
		downloadTextLayer.foregroundColor = [NSColor blackColor].CGColor;
		downloadTextLayer.fontSize = 12.0;
		downloadTextLayer.string = @"Download:20 bytes";
		downloadTextLayer.frame = CGRectMake(5.0, self.bounds.size.height - 20.0, self.bounds.size.width - 10.0, 20.0);
		[self addSublayer:downloadTextLayer];
		//[downloadTextLayer release];
		download = 4.0;
		
	}
	
	if(!uploadTextLayer)
	{
		uploadTextLayer = [CATextLayer layer];
		CGFontRef anotherFont = CGFontCreateWithFontName((__bridge CFStringRef)@"Arial");
		uploadTextLayer.font = anotherFont;
		uploadTextLayer.fontSize = 12.0;
		uploadTextLayer.foregroundColor = [NSColor blackColor].CGColor;
		uploadTextLayer.string = @"Upload: 40 bytes";
		uploadTextLayer.frame = CGRectMake(5.0, self.bounds.size.height - 40.0, self.bounds.size.width - 10.0, 20.0);
		[self addSublayer:uploadTextLayer];
		//[uploadTextLayer release];
		upload = 10.0;
	}
	
}

- (void)dealloc 
{
	self.uploadTextLayer = nil;
    self.downloadTextLayer = nil;
    [super dealloc];
}


-(void)updateOnGoing
{
	upload += 4.0;
	download += 5.0;
	
	if(upload > 400)
		upload = 4;
	
	if(download > 800)
		download = 5.0;
	
	self.downloadString = [NSString stringWithFormat:@"Download:%2.f bytes",download];
	self.uploadString = [NSString stringWithFormat:@"Upload: %2.f bytes",upload];
	self.downloadTextLayer.string = self.downloadString;
	self.uploadTextLayer.string = self.uploadString;
}

-(void)animateTexts:(BOOL)status
{
	if(status)
	{	
		
		animate = YES;
		animTimer = [[NSTimer timerWithTimeInterval:0.40 target:self selector:@selector(updateOnGoing) userInfo:nil repeats:YES] retain];
		[[NSRunLoop currentRunLoop] addTimer:animTimer forMode:NSRunLoopCommonModes];
	}
	else
	{
	
		animate = NO;
		if(animTimer)
		{	
			[animTimer invalidate];
			[animTimer release];
			animTimer = nil;
		}	
	}
	
	[self setNeedsDisplay];
}



@end
