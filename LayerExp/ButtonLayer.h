//
//  ButtonLayer.h
//  LayerExp
//
//  Created by Pradip on 4/28/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

typedef enum
{
	offState = 0,
	onState = 1
} EState;



#import <QuartzCore/QuartzCore.h>
@interface ButtonLayer : CALayer
{

	BOOL highLight;
	EState state;
	NSImage *image;
	NSImage *alternateImage;
}
@property(nonatomic,retain) NSImage *alternateImage;
@property(nonatomic,retain) NSImage *image;
@property(nonatomic,getter = isHighlighted,setter = setHighLight:) BOOL highLight;
@property(nonatomic,assign) EState state;

@end
