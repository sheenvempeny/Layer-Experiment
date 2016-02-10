//
//  NSObject+Utilities.m
//  LayerExp
//
//  Created by Pradip on 4/28/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Utilities.h"

@implementation NSObject (Utilities)

-(CGImageRef)CGImage:(NSImage*)image
{
    CGContextRef bitmapCtx = CGBitmapContextCreate(NULL/*data - pass NULL to let CG allocate the memory*/, 
                                                   [image size].width,  
                                                   [image size].height, 
                                                   8 /*bitsPerComponent*/, 
                                                   0 /*bytesPerRow - CG will calculate it for you if it's allocating the data.  This might get padded out a bit for better alignment*/, 
                                                   [[NSColorSpace genericRGBColorSpace] CGColorSpace], 
                                                   kCGBitmapByteOrder32Host|kCGImageAlphaPremultipliedFirst);
	
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:bitmapCtx flipped:NO]];
    [image drawInRect:NSMakeRect(0,0, [image size].width, [image size].height) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    [NSGraphicsContext restoreGraphicsState];
	
    CGImageRef cgImage = CGBitmapContextCreateImage(bitmapCtx);
    CGContextRelease(bitmapCtx);
	
    return (CGImageRef)[(id)cgImage autorelease];
}


-(CGImageRef)imageFormLayer:(CALayer*)layer
{
	CGSize imageSize = CGSizeMake(layer.bounds.size.width, layer.bounds.size.height);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
	CGContextRef theContext = CGBitmapContextCreate(NULL, imageSize.width, imageSize.height, 8, 4*imageSize.width, colorSpace, kCGImageAlphaPremultipliedLast);
    [layer renderInContext:theContext];
	// Layer tree has backgroundFilters set on some of the CALayers
	// When it's rendered in the Bitmap Context, none of these filters are applied.
	CGImageRef CGImage = CGBitmapContextCreateImage(theContext);
						  
	return CGImage;
}

-(NSImage*)imageForAngle:(float)degrees withImage:(NSImage*)inImage
{
	//	if (0 != fmod(degrees,90.)) { NSLog( @"This code has only been tested for multiples of 90 degrees. (TODO: test and remove this line)"); }
	degrees = fmod(degrees, 360.);
	if (0 == degrees) {
		return inImage;
	}
	NSSize size = [inImage size];
	NSSize maxSize;
	if (90. == degrees || 270. == degrees || -90. == degrees || -270. == degrees) {
		maxSize = NSMakeSize(size.height, size.width);
	} else if (180. == degrees || -180. == degrees) {
		maxSize = size;
	} else {
		maxSize = NSMakeSize(MAX(size.width, size.height), MAX(size.width, size.height));
	}
	NSAffineTransform *rot = [NSAffineTransform transform];
	[rot rotateByDegrees:degrees];
	NSAffineTransform *center = [NSAffineTransform transform];
	[center translateXBy:maxSize.width / 2. yBy:maxSize.height / 2.];
	[rot appendTransform:center];
	NSImage *image = [[[NSImage alloc] initWithSize:maxSize] autorelease];
	[image lockFocus];
	[rot concat];
	NSRect rect = NSMakeRect(0, 0, size.width, size.height);
	NSPoint corner = NSMakePoint(-size.width / 2., -size.height / 2.);
	[inImage drawAtPoint:corner fromRect:rect operation:NSCompositeCopy fraction:1.0];
	[image unlockFocus];
	return image;
}


@end
