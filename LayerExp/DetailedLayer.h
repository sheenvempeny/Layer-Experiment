//
//  DetailedLayer.h
//  LayerExp
//
//  Created by Pradip on 4/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface DetailedLayer : CALayer 
{
	CATextLayer *downloadTextLayer;
	CATextLayer *uploadTextLayer;
	BOOL animate;
	
	float download,upload;
	NSString *downloadString;
	NSString *uploadString;
	
	NSTimer *animTimer;

}
@property(nonatomic,retain) NSString *uploadString;
@property(nonatomic,retain) NSString *downloadString;

@property(nonatomic,getter = isAnimating,setter = animateTexts:) BOOL animate;
@property(nonatomic,retain) CATextLayer *downloadTextLayer;
@property(nonatomic,retain) CATextLayer *uploadTextLayer;

-(void)setpSubLayers;


@end
