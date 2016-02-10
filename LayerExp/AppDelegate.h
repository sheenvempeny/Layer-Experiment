//
//  AppDelegate.h
//  LayerExp
//
//  Created by Pradip on 4/24/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LayerViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	IBOutlet NSView *containerView;
	LayerViewController *mLayerViewController;
	
}

-(IBAction)animate:(id)sender;
-(IBAction)addGroup:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
