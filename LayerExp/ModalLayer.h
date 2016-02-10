//
//  ModalLayer.h
//  LayerExp
//
//  Created by Pradip on 4/24/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Modal.h"
#import "ButtonLayer.h"
#import "LayerViewController.h"
#import "DetailedLayer.h"

@interface ModalLayer : CAScrollLayer
{
	Modal *mModal;
	BOOL expanded;
	CALayer *imageLayer;
	CATextLayer *mainTextLayer;
	CATextLayer *subTextLayer;
	ButtonLayer *discolureButtonLayer;
	NSSize imageSize;
	id viewDelegate;
	
	DetailedLayer *mDetailedLayer;
	BOOL drawAnimateImage;
	
}

@property(nonatomic,assign) id viewDelegate;
@property(nonatomic,assign) BOOL expanded;
@property(nonatomic,assign) Modal *mModal;
@property(nonatomic,retain) CALayer *imageLayer;
@property(nonatomic,retain) CATextLayer *mainTextLayer;
@property(nonatomic,retain) CATextLayer *subTextLayer;
@property(nonatomic,retain) ButtonLayer *discolureButtonLayer;
@property(nonatomic,retain) DetailedLayer *mDetailedLayer;

-(void)setStatusImage:(NSImage*)image;
-(void)setTittle:(NSString*)title;
-(BOOL)setupSubLayers;
-(void)mouseDownAtPoint:(NSPoint)point;


@end
