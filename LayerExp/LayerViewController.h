//
//  LayerViewController.h
//  LayerExp
//
//  Created by Pradip on 4/24/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Modal.h"
#import "ModalLayer.h"
#import <QuartzCore/QuartzCore.h>
#import "ContainerView.h"

@interface LayerViewController : NSViewController 
{
	NSArray *modals;
	float expandedRowHeight;
	float normalRowHeight;
	NSMutableArray *animatedImages;
		
}

@property(nonatomic,retain,getter = modals) NSArray *modals;

-(void)addModal:(NSString*)name;
-(void)removeModal:(Modal*)modal;
-(void)animate:(BOOL)status;
@end

@protocol LayerExpandDelegate <NSObject>

-(void)expand:(id)layer;
-(void)collpase:(id)layer;

@end


