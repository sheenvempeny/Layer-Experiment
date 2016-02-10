//
//  NSObject+Utilities.h
//  LayerExp
//
//  Created by Pradip on 4/28/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utilities)

-(CGImageRef)CGImage:(NSImage*)image;
-(NSImage*)imageForAngle:(float)degrees withImage:(NSImage*)inImage;
-(CGImageRef)imageFormLayer:(CALayer*)layer;

@end
