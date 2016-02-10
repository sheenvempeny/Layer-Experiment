//
//  AppDelegate.m
//  LayerExp
//
//  Created by Pradip on 4/24/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

-(IBAction)addGroup:(id)sender
{
	[mLayerViewController addModal:[NSString stringWithFormat:@"%d",mLayerViewController.modals.count + 1]];
}

-(void)awakeFromNib
{
	mLayerViewController = [[LayerViewController alloc] initWithNibName:@"LayerViewController" bundle:[NSBundle mainBundle]];
	[mLayerViewController loadView];
	mLayerViewController.view.enclosingScrollView.frame = containerView.frame;
	[containerView addSubview:mLayerViewController.view.enclosingScrollView];

}

-(IBAction)animate:(id)sender
{
	[mLayerViewController animate:[(NSButton*)sender state]];
}

@end
