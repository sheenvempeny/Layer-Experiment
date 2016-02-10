//
//  ContainerView.h
//  LayerExp
//
//  Created by Pradip on 4/29/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ContainerView : NSView
{
	
	id delegate;
	
}

@property(nonatomic,assign) id delegate;

@end

@protocol ContainerMouseDown <NSObject>

-(void)mouseDown:(NSEvent*)event forView:(ContainerView*)view;

@end