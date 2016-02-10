//
//  LayerViewController.m
//  LayerExp
//
//  Created by Pradip on 4/24/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LayerViewController.h"
#import "NSColor+CGColor.h"
#import "NSObject+Utilities.h"

@interface LayerViewController()
-(NSInteger)numberOfExpandedLayers;
-(NSInteger)numberOfCollapsedLayers;
-(void)addLayerForModals;
-(void)arrangeLayerForModals:(BOOL)withAnimation;
-(ModalLayer*)layerForModal:(Modal*)modal;
-(ModalLayer*)layerAtPoint:(NSPoint)point;
-(void)expandLayer:(ModalLayer*)layerToExpand collpaseLayer:(ModalLayer*)layerToCollapse;
-(ModalLayer*)expandedLayer;
@end


@implementation LayerViewController
@synthesize modals;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)loadView
{
	[super loadView];
	expandedRowHeight = 120.0;
	normalRowHeight = 50.0;

	[self.view setWantsLayer:YES];
	animatedImages = [[NSMutableArray alloc] init];
	[(ContainerView*)self.view setDelegate:self];
}

-(void)addModal:(NSString*)name
{
	Modal *newModal = [Modal new];
	newModal.name = name;
	newModal.state = Resume;
	NSMutableArray *array = [NSMutableArray arrayWithArray:self.modals];
	[array addObject:newModal];
	[newModal release];
	self.modals = array;
	[self addLayerForModals];
}
-(ModalLayer*)expandedLayer
{
	
	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		if(layer.expanded)
			return layer;
	}

	return nil;
}


-(NSInteger)numberOfExpandedLayers
{
	int i = 0;
	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		if(layer.expanded)
			i++;
	}
	return i;
}

-(NSInteger)numberOfCollapsedLayers
{
	int i = 0;
	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		if(!layer.expanded)
			i++;
	}
	return i;
}

-(ModalLayer*)layerForModal:(Modal*)modal
{
	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		if([layer.mModal isEqual:modal])
			return layer;
	}
	
	return nil;
}

-(void)removeModal:(Modal*)modal
{
	[[self layerForModal:modal] removeFromSuperlayer];
	NSMutableArray *array = [NSMutableArray arrayWithArray:self.modals];
	[array removeObject:modal];
	self.modals = array;
	[self addLayerForModals];
}

-(void)addLayerForModals
{
	NSMutableArray *modalsNeedLayer = [NSMutableArray arrayWithArray:self.modals];
	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		[modalsNeedLayer removeObject:layer.mModal];
	}
	//Here we have to add subLayers
	for (Modal *newModal in modalsNeedLayer)
	{
		ModalLayer *mModalLayer = [ModalLayer new];
		mModalLayer.backgroundColor = [[NSColor colorWithDeviceRed:252.0/255.0 green:253.0/255.0 blue:249.0/255.0 alpha:1.0] CGColor];
		mModalLayer.mModal = newModal;
		mModalLayer.delegate = mModalLayer;
		mModalLayer.expanded = NO;
		mModalLayer.viewDelegate = self;
		[self.view.layer addSublayer:mModalLayer];
		mModalLayer.autoresizingMask = kCALayerHeightSizable | kCALayerMinXMargin | kCALayerMinYMargin;
		[mModalLayer release];
	}
	
	[self arrangeLayerForModals:NO];
}

-(void)arrangeLayerForModals:(BOOL)withAnimation
{
	if(withAnimation)
	{
		[CATransaction setAnimationDuration:0.350];
		[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[CATransaction begin];
	}
	
	int i = 0;
	//Here we have to correct the height
	float totalHeight = (self.numberOfExpandedLayers * expandedRowHeight) + (self.numberOfCollapsedLayers * normalRowHeight);
	if(totalHeight < self.view.visibleRect.size.height)
	{
		totalHeight = self.view.visibleRect.size.height;
	}
	[self.view setFrame:NSMakeRect(0.0, 0.0, self.view.bounds.size.width, totalHeight)];
	CGRect layerRect = CGRectMake(0.0, totalHeight, self.view.bounds.size.width,1.0);
	i = 0;
	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		if(layer.expanded)
		{
			layerRect.size.height = expandedRowHeight;
			layer.discolureButtonLayer.state = onState;
		}
		else
		{
			layerRect.size.height = normalRowHeight;
			layer.discolureButtonLayer.state = offState;
		}	
		
		layerRect.origin.y -= layerRect.size.height;
		layer.frame = layerRect;
		
		
		if([layer setupSubLayers])
		{	
			[layer setStatusImage:[NSImage imageNamed:@"sync"]];
			[layer setTittle:[NSString stringWithFormat:@"Sheen %d",i]];
		}
		
		[layer setNeedsDisplay];
		
		i++;
	}
	
	if(withAnimation)
	{
		[CATransaction commit];
	}

}



- (void)drawLayer:(ModalLayer *)layer inContext:(CGContextRef)ctx
{
//	[[NSColor blackColor] set];
//	[layer.mModal.name drawAtPoint:layer.frame.origin withAttributes:nil];	
	
}


-(void)createAnimatedImages
{

	float rotationDegree = 3.0;
	float degree = 0.0;
	while (degree <= 360.0)
	{
		NSImage *image = [self imageForAngle:-degree withImage:[NSImage imageNamed:@"sync"]];
		[animatedImages addObject:(id)[self CGImage:image]];
		degree += rotationDegree;
	}
}


-(void)animate:(BOOL)status
{
	if(animatedImages.count == 0)
		[self createAnimatedImages];
	

	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		if(status)
		{
			layer.mDetailedLayer.animate = YES;
			CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath: @"contents"];
			animation.calculationMode = kCAAnimationLinear;
			animation.repeatCount = HUGE_VALF;
			animation.duration = 1.0;
			animation.values = animatedImages; // NSArray of CGImageRefs
			[layer.imageLayer addAnimation: animation forKey: @"contents"];
		}	
		else
		{
			[layer.imageLayer removeAllAnimations];
			layer.mDetailedLayer.animate = NO;
		}
	}
		
}

-(void)mouseDown:(NSEvent*)event forView:(ContainerView*)view
{
	NSPoint locationInView = [view convertPoint:[event locationInWindow]
				fromView:[[view window] contentView]];
	ModalLayer *layer = [self layerAtPoint:locationInView];
	[layer mouseDownAtPoint:locationInView];
}

-(ModalLayer*)layerAtPoint:(NSPoint)point
{
	ModalLayer *returnLayer = nil;
	
	for (ModalLayer *layer in self.view.layer.sublayers)
	{
		if(NSPointInRect(point, layer.frame))
		{
			returnLayer = layer;
			break;
		}
		
	}
	
	return returnLayer;
}

-(void)expand:(ModalLayer*)layer
{
	[self expandLayer:layer collpaseLayer:self.expandedLayer];
}
-(void)collpase:(ModalLayer*)layer
{
	//[layer.mDetailedLayer removeFromSuperlayer];
	[self expandLayer:nil collpaseLayer:layer];
}

-(void)expandLayer:(ModalLayer*)layerToExpand collpaseLayer:(ModalLayer*)layerToCollapse
{
	[layerToExpand setExpanded:YES];
	[layerToCollapse setExpanded:NO];
	[self arrangeLayerForModals:YES];
}


@end
